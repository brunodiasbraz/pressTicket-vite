import React, { useCallback, useContext, useEffect, useRef, useState } from "react";

import Badge from "@material-ui/core/Badge";
import IconButton from "@material-ui/core/IconButton";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemText from "@material-ui/core/ListItemText";
import Popover from "@material-ui/core/Popover";
import { makeStyles } from "@material-ui/core/styles";
import ChatIcon from "@material-ui/icons/Chat";
import VolumeOffIcon from "@material-ui/icons/VolumeOff";
import VolumeUpIcon from "@material-ui/icons/VolumeUp";
import { format } from "date-fns";
import { useHistory } from "react-router-dom";
import useSound from "use-sound";
import alertSound from "../../assets/sound.mp3";
import { AuthContext } from "../../context/Auth/AuthContext";
import useTickets from "../../hooks/useTickets";
import openSocket from "../../services/socket-io";
import { i18n } from "../../translate/i18n";
import TicketListItem from "../TicketListItem";

const useStyles = makeStyles(theme => ({
	tabContainer: {
		overflowY: "auto",
		maxHeight: 350,
		...theme.scrollbarStyles,
	},
	popoverPaper: {
		width: "100%",
		maxWidth: 350,
		marginLeft: theme.spacing(2),
		marginRight: theme.spacing(1),
		[theme.breakpoints.down("sm")]: {
			maxWidth: 270,
		},
	},
	noShadow: {
		boxShadow: "none !important",
	},
}));

const NotificationsPopOver = () => {
	const classes = useStyles();

	const history = useHistory();
	const { user } = useContext(AuthContext);
	const ticketIdUrl = +history.location.pathname.split("/")[2];
	const ticketIdRef = useRef(ticketIdUrl);
	const anchorEl = useRef();
	const [isOpen, setIsOpen] = useState(false);
	const [notifications, setNotifications] = useState([]);
	const [isAudioEnabled, setIsAudioEnabled] = useState(
		localStorage.getItem("userAudioEnabled") === "true"
	);
	const [, setDesktopNotifications] = useState([]);

	const { tickets } = useTickets({ withUnreadMessages: "true" });
	const [play, { stop }] = useSound(alertSound, { soundEnabled: isAudioEnabled });
	const soundAlertRef = useRef();

	const historyRef = useRef(history);

	useEffect(() => {
		soundAlertRef.current = play;

		if (!("Notification" in window)) {
			console.log("This browser doesn't support notifications");
		} else {
			Notification.requestPermission();
		}
	}, [play]);

	useEffect(() => {
		setNotifications(tickets);
	}, [tickets]);

	useEffect(() => {
		ticketIdRef.current = ticketIdUrl;
	}, [ticketIdUrl]);

	const handleNotifications = useCallback((data) => {
		const { message, contact, ticket } = data;

		const options = {
			body: `${message.body} - ${format(new Date(), "HH:mm")}`,
			icon: contact.profilePicUrl,
			tag: ticket.id,
			renotify: true,
		};

		const notification = new Notification(
			`${i18n.t("tickets.notification.message")} ${contact.name}`,
			options
		);

		notification.onclick = e => {
			e.preventDefault();
			window.focus();
			historyRef.current.push(`/tickets/${ticket.id}`);
		};

		setDesktopNotifications(prevState => {
			const notfiticationIndex = prevState.findIndex(
				n => n.tag === notification.tag
			);
			if (notfiticationIndex !== -1) {
				prevState[notfiticationIndex] = notification;
				return [...prevState];
			}
			return [notification, ...prevState];
		});

		if (isAudioEnabled && soundAlertRef.current) {
			soundAlertRef.current();
		}
	}, [isAudioEnabled]);

	useEffect(() => {
		const socket = openSocket();

		socket.on("connect", () => socket.emit("joinNotification"));

		socket.on("ticket", data => {
			if (data.action === "updateUnread" || data.action === "delete") {
				setNotifications(prevState => {
					const ticketIndex = prevState.findIndex(t => t.id === data.ticketId);
					if (ticketIndex !== -1) {
						prevState.splice(ticketIndex, 1);
						return [...prevState];
					}
					return prevState;
				});

				setDesktopNotifications(prevState => {
					const notfiticationIndex = prevState.findIndex(
						n => n.tag === String(data.ticketId)
					);
					if (notfiticationIndex !== -1) {
						prevState[notfiticationIndex].close();
						prevState.splice(notfiticationIndex, 1);
						return [...prevState];
					}
					return prevState;
				});
			}
		});

		socket.on("appMessage", data => {
			const UserQueues = user.queues.findIndex((users) => (users.id === data.ticket.queueId));
			if (
				(data.action === "create" &&
					!data.message.read &&
					(data.ticket.userId === user?.id || !data.ticket.userId)
					&& (UserQueues !== -1 || !data.ticket.queueId))
			) {
				setNotifications(prevState => {
					const ticketIndex = prevState.findIndex(t => t.id === data.ticket.id);
					if (ticketIndex !== -1) {
						prevState[ticketIndex] = data.ticket;
						return [...prevState];
					}
					return [data.ticket, ...prevState];
				});

				const shouldNotNotificate =
					(data.message.ticketId === ticketIdRef.current &&
						document.visibilityState === "visible") ||
					(data.ticket.userId && data.ticket.userId !== user?.id) ||
					data.ticket.isGroup;

				if (shouldNotNotificate) return;

				handleNotifications(data);
			}
		});

		return () => {
			socket.disconnect();
		};
	}, [user, handleNotifications]);

	const toggleAudio = () => {
		const newAudioStatus = !isAudioEnabled;
		setIsAudioEnabled(newAudioStatus);
		localStorage.setItem("userAudioEnabled", newAudioStatus.toString());

		if (!newAudioStatus) {
			stop();
		}
	};

	const handleClick = () => {
		setIsOpen(prevState => !prevState);
	};

	const handleClickAway = () => {
		setIsOpen(false);
	};

	const NotificationTicket = ({ children }) => {
		return <div onClick={handleClickAway}>{children}</div>;
	};

	return (
		<>
			<IconButton onClick={toggleAudio} aria-label="Toggle Sound" color="inherit">
				{isAudioEnabled ? <VolumeUpIcon /> : <VolumeOffIcon />}
			</IconButton>
			<IconButton
				onClick={handleClick}
				ref={anchorEl}
				aria-label="Open Notifications"
				color="secondary"
			>
				<Badge
					badgeContent={notifications.length}
					color="secondary"
					overlap="rectangular"
					max={9999} >
					<ChatIcon />
				</Badge>
			</IconButton>
			<Popover
				disableScrollLock
				open={isOpen}
				anchorEl={anchorEl.current}
				anchorOrigin={{
					vertical: "bottom",
					horizontal: "right",
				}}
				transformOrigin={{
					vertical: "top",
					horizontal: "right",
				}}
				classes={{ paper: classes.popoverPaper }}
				onClose={handleClickAway}
			>
				<List dense className={classes.tabContainer}>
					{notifications.length === 0 ? (
						<ListItem>
							<ListItemText>{i18n.t("notifications.noTickets")}</ListItemText>
						</ListItem>
					) : (
						notifications.map(ticket => (
							<NotificationTicket key={ticket.id}>
								<TicketListItem ticket={ticket} />
							</NotificationTicket>
						))
					)}
				</List>
			</Popover>
		</>
	);
};

export default NotificationsPopOver;
import React, { createContext } from "react";

import useWhatsApps from "../../hooks/useWhatsApps";

export const WhatsAppsContext = createContext();

export const WhatsAppsProvider = ({ children }) => {
	const { loading, whatsApps } = useWhatsApps();

	return (
		<WhatsAppsContext.Provider value={{ whatsApps, loading }}>
			{children}
		</WhatsAppsContext.Provider>
	);
};

// export { WhatsAppsContext, WhatsAppsProvider };

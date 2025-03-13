import { Request, Response } from "express";
import AppError from "../errors/AppError";
import { getIO } from "../libs/socket";
import { removeWbot, getWbot } from "../libs/wbot";
import { StartWhatsAppSession } from "../services/WbotServices/StartWhatsAppSession";

import CreateWhatsAppService from "../services/WhatsappService/CreateWhatsAppService";
import DeleteWhatsAppService from "../services/WhatsappService/DeleteWhatsAppService";
import ListWhatsAppsService from "../services/WhatsappService/ListWhatsAppsService";
import ShowWhatsAppService from "../services/WhatsappService/ShowWhatsAppService";
import UpdateWhatsAppService from "../services/WhatsappService/UpdateWhatsAppService";

import ListSettingsService from "../services/SettingServices/ListSettingsService";

import dotenv from "dotenv";
dotenv.config();
const apiUrl = `${process.env.BACKEND_URL}:${process.env.PORT}/api/messages/send`;

interface WhatsappData {
  name: string;
  queueIds: number[];
  greetingMessage?: string;
  farewellMessage?: string;
  status?: string;
  isDefault?: boolean;
  color?: string;
}

export const index = async (req: Request, res: Response): Promise<Response> => {
  const whatsapps = await ListWhatsAppsService();

  return res.status(200).json(whatsapps);
};

export const store = async (req: Request, res: Response): Promise<Response> => {
  const WhatsApps = await ListWhatsAppsService();

  if (WhatsApps.length >= Number(process.env.CONNECTIONS_LIMIT)) {
    throw new AppError("ERR_CONNECTION_CREATION_COUNT", 403);
  }

  const {
    name,
    status,
    isDefault,
    greetingMessage,
    farewellMessage,
    queueIds,
    color
  }: WhatsappData = req.body;

  const { whatsapp, oldDefaultWhatsapp } = await CreateWhatsAppService({
    name,
    status,
    isDefault,
    greetingMessage,
    farewellMessage,
    queueIds,
    color
  });

  StartWhatsAppSession(whatsapp);

  const io = getIO();
  io.emit("whatsapp", {
    action: "update",
    whatsapp
  });

  if (oldDefaultWhatsapp) {
    io.emit("whatsapp", {
      action: "update",
      whatsapp: oldDefaultWhatsapp
    });
  }

  return res.status(200).json(whatsapp);
};

export const show = async (req: Request, res: Response): Promise<Response> => {
  const { whatsappId } = req.params;

  const whatsapp = await ShowWhatsAppService(whatsappId);

  return res.status(200).json(whatsapp);
};

export const update = async (
  req: Request,
  res: Response
): Promise<Response> => {
  const { whatsappId } = req.params;
  const whatsappData = req.body;

  const { whatsapp, oldDefaultWhatsapp } = await UpdateWhatsAppService({
    whatsappData,
    whatsappId
  });

  const io = getIO();
  io.emit("whatsapp", {
    action: "update",
    whatsapp
  });

  if (oldDefaultWhatsapp) {
    io.emit("whatsapp", {
      action: "update",
      whatsapp: oldDefaultWhatsapp
    });
  }

  return res.status(200).json(whatsapp);
};

export const remove = async (
  req: Request,
  res: Response
): Promise<Response> => {
  const { whatsappId } = req.params;

  await DeleteWhatsAppService(whatsappId);
  removeWbot(+whatsappId);

  const io = getIO();
  io.emit("whatsapp", {
    action: "delete",
    whatsappId: +whatsappId
  });

  return res.status(200).json({ message: "Whatsapp deleted." });
};

export const sendMensage = async (req: Request, res: Response): Promise<Response> => {

  const { numero, mensagem, id_sessao } = req.body;


  let whatsapp = await ShowWhatsAppService(id_sessao);

  while (whatsapp.status === "OPENING") {
    console.log("Aguardando Chip");
    await new Promise(resolve => setTimeout(resolve, 2000));
    whatsapp = await ShowWhatsAppService(id_sessao);
  }

  if (whatsapp.status !== "CONNECTED" || whatsapp.queues[0].id == undefined || !whatsapp.queues[0].id) {
    return res.status(420).json({ error: "Chip desconectado, verifique a conexão!" });
  }

  try {
    // // Consulta se existe a sessao
    const wbot2 = getWbot(parseInt(id_sessao, 10));

    const keyToken = await ListSettingsService();

    const token = keyToken && keyToken[10] ? keyToken[10].value : undefined;


    const myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");
    myHeaders.append("Authorization", `Bearer ${token}`);

    const raw = JSON.stringify({
      "number": numero,
      "body": mensagem,
      "userId": null,
      "queueId": whatsapp.queues[0].id,
      "whatsappId": id_sessao
    });

    const requestOptions = {
      method: "POST",
      headers: myHeaders,
      body: raw,
      redirect: "follow" as RequestRedirect
    };

    fetch(apiUrl, requestOptions)
      .then((response) => response.text())
      .then((result) => console.log(result))
      .catch((error) => console.error("Erro ao enviar a mensagem:", error));



    return res.status(200).json("Enviado para " + numero.replace("@c.us", ""));
  } catch (error) {
    return res.status(400).json({ error: "Erro ao enviar mensagem" });
  }
};

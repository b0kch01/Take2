import express from "express";
import { createServer } from "http";
import cors from "cors";

const PORT = 9999;
const app = express();
const httpServer = createServer(app);

app.set(cors({ origin: true, credentials: true }));
app.use(express.json());

httpServer.listen(PORT, () => {
  console.log("SERVER STARTED");
});

import express, { Application } from "express";
import cors from "cors";
import dotenv from "dotenv";

import userRoutes from "../src/routers/userRouters";
import accountRoutes from "../src/routers/accountRouters";
import categoryRoutes from "../src/routers/categoryRouters";
import transactionRoutes from "../src/routers/transactionRouters";
import noteRoutes from "../src/routers/noteRouters";

import { swaggerDocs } from "../src/config/swagger";

dotenv.config();

const app: Application = express();
const PORT = process.env.PORT || 3222;
const DB_HOST = process.env.DB_HOST || "localhost";

app.use(
  cors({
    origin: [`http://localhost:3000`, `http://89.111.169.232:3000`],
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true,
  })
);

app.use(express.json());

app.use("/users", userRoutes);
app.use("/accounts", accountRoutes);
app.use("/categories", categoryRoutes);
app.use("/transactions", transactionRoutes);
app.use("/notes", noteRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  swaggerDocs(app, PORT);
});

console.log(`Database Host: ${process.env.DB_HOST}`);
console.log(`Server is running on port: ${process.env.PORT}`);

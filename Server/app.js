const express = require("express");
const body_parser = require("body-parser");
const userRouter = require("./routes/user.routes");
const todoRouter = require("./routes/todo.routes");

const app = express();
app.use(express.json());

app.use(body_parser.json());

app.use("/", userRouter);
app.use("/", todoRouter);

module.exports = app;

const mongoose = require("mongoose");

const connection = mongoose
  .createConnection(
    "mongodb+srv://mailstuntdinesh:grkVAe8SHDxbToKP@todoease.gay1hux.mongodb.net/?retryWrites=true&w=majority&appName=todoease"
  )
  .on("open", () => {
    console.log("MongoDB connected.");
  })
  .on("error", () => {
    console.log("MongoDB error");
  });

module.exports = connection;

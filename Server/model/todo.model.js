const mongoose = require("mongoose");
const db = require("../config/db");
const userModel = require("../model/user.model");

const { Schema } = mongoose;

const todoSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    ref: userModel.modelName,
  },
  title: {
    type: String,
  },
  isDone: {
    type: Boolean,
  },
});

const todoModel = db.model("todo", todoSchema);

module.exports = todoModel;

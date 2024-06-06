const router = require("express").Router();
const todoController = require("../controller/todo.controller");

// Routes
router.post("/newTodo", todoController.createTodo);
router.post("/getTodo", todoController.getTodo);
router.post("/deleteTodo", todoController.deleteTodo);

module.exports = router;

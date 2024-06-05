const router = require("express").Router();
const todoController = require("../controller/todo.controller");

//Routes
router.post("/newTodo", todoController.createTodo);

module.exports = router;

const todoServices = require("../services/todo.service");

exports.createTodo = async (req, res, next) => {
  try {
    const { userId, title, isDone } = req.body;
    let todo = await todoServices.createTodo(userId, title, isDone);
    res.json({ status: true, success: todo });
  } catch (error) {
    throw error;
  }
};

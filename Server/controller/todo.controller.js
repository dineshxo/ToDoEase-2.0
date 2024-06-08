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

exports.getTodo = async (req, res, next) => {
  try {
    const { userId } = req.body;
    let todo = await todoServices.getTodo(userId);
    res.json({ status: true, success: todo });
  } catch (error) {
    throw error;
  }
};

exports.deleteTodo = async (req, res, next) => {
  try {
    const { id } = req.body;
    let deleted = await todoServices.deleteTodo(id);
    res.json({ status: true, success: deleted });
  } catch (error) {
    throw error;
  }
};

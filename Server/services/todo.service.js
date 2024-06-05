const Todo = require("../model/todo.model");

class TodoServices {
  static async createTodo(userId, title, isDone) {
    const newTodo = new Todo({
      userId,
      title,
      isDone,
    });
    await newTodo.save();
    return newTodo;
  }
}

module.exports = TodoServices;

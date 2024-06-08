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

  static async getTodo(userId) {
    const todoList = await Todo.find({
      userId,
    });

    return todoList;
  }

  static async deleteTodo(id) {
    const deleteTodo = await Todo.findOneAndDelete({ _id: id });

    return deleteTodo;
  }
}

module.exports = TodoServices;

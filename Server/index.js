const app = require("./app");
const db = require("./config/db");
const userModel = require("./model/user.model");
const todoModel = require("./model/todo.model");

const port = 3000;

app.listen(port, () => {
  console.log(`Server is running on port:${port}`);
});

app.get("/", (req, res) => {
  res.send("Hello");
});

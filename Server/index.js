const app = require("./app");
const db = require("./config/db");

const port = 3000;

app.listen(port, () => {
  console.log(`Server is running on ${port}`);
});

app.get("/", (req, res) => {
  res.send("Hello world!");
});

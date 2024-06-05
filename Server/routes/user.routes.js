const router = require("express").Router();
const userController = require("../controller/user.controller");

//Routes
router.post("/registration", userController.register);
router.post("/login", userController.login);

module.exports = router;

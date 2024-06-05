const userModel = require("../model/user.model");
const UserService = require("../services/user.service");

exports.register = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const successRes = await UserService.registerUser(email, password);
    res.json({ status: true, success: "User Registered Successfully." });
  } catch (err) {
    throw err;
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    const user = await UserService.checkUser(email);

    if (!user) {
      throw new Error("User do not exist. Please Register.");
    } else {
      const isMatch = user.comparePassword(password);

      if (isMatch === false) {
        throw new Error("Invalid Password.");
      } else {
        let tokenData = { _id: user._id, email: user.email };
        const token = await UserService.generateToken(
          tokenData,
          "todoease",
          "1h"
        );

        res.status(200).json({ status: true, token: token });
      }
    }
  } catch (err) {
    throw err;
  }
};

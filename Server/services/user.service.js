const userModel = require("../model/user.model");
const jwt = require("jsonwebtoken");

class UserService {
  // User registration
  static async registerUser(email, password) {
    try {
      const newUser = userModel({ email, password });
      return await newUser.save();
    } catch (err) {
      throw err;
    }
  }

  // Check User
  static async checkUser(email) {
    try {
      return await userModel.findOne({ email });
    } catch (err) {
      throw err;
    }
  }

  //JWT Token
  static async generateToken(tokenData, secretKey, jwt_expire) {
    return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
  }
}

module.exports = UserService;

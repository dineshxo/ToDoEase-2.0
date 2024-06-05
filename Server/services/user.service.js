const userModel = require("../model/user.model");

class UserService {
  static async registerUser(email, password) {
    try {
      const newUser = userModel({ email, password });
      return await newUser.save();
    } catch (err) {
      throw err;
    }
  }
}

module.exports = UserService;

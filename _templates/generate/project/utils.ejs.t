---
to: <%= path %>/app/utils/util.js
---

/* dependencies  */
const moment = require("moment");

/* custom dependencies  */
const jwt = require('jsonwebtoken');
const config = require('../../config');
const userModel = require('../models/user.model');

exports.getToken = async data => {
    const privateKey = await config.JWT_SECRET_PK()
    return jwt.sign({
        username: data.username,
        email: data.email
    }, privateKey, {
        expiresIn: config.JWT_EXPIRES
    });
}

exports.userExists = async data => {
    const user = await userModel.findOne({
        email: data.email
    });
    if (!user) {
        throw new Error("user not found");
    }

    if (!user.status) {
        throw new Error("user is  disable");
    }
    return await user;
}
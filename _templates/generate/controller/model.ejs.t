---
to: <%= path %>/app/models/<%= name %>.model.js
---

const mongoose = require("mongoose");
const { Schema } = require("mongoose");


const <%= h.capitalize(name) %>Schema = {
  createdAt: {
    type: Date,
    default: Date.now(),
  },
  modifiedAt: {
    type: Date,
    default: Date.now(),
  },
};

module.exports = mongoose.model("<%= name %>", <%= h.capitalize(name) %>Schema, "<%= name %>");
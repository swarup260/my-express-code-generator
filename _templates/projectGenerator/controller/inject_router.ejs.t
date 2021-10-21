---
inject: true
to: <%= path %>/index.js
skip_if: <%= name %>
before: "Test Routes"
---


const <%= name %>Routes = require("./api/routes/<%= name %>.routes");
app.use("/<%= h.inflection.pluralize(name) %>", <%= name %>Routes);
---
to: <%= path %>/src/resolvers/<%= name %>.resolvers.js
---

const { 
       get<%= h.capitalize(name) %>,
       get<%= h.capitalize(name) %>s,
       search<%= h.capitalize(name) %>s,
       add<%= h.capitalize(name) %>,
       update<%= h.capitalize(name) %>,
       delete<%= h.capitalize(name) %> 
       } = require('../controllers/<%= name %>.controller')
module.exports = {
  Query: {
    get<%= h.capitalize(name) %>,
    get<%= h.capitalize(name) %>s,
    search<%= h.capitalize(name) %>s
  },
  Mutation:{
    add<%= h.capitalize(name) %>,
    update<%= h.capitalize(name) %>,
    delete<%= h.capitalize(name) %>
  }
}
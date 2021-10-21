---
to: <%= path %>/app/routes/<%= name %>.routes.js
---

const Express = require('express');
const router = Express.Router();
const <%= name %>Controller = require('../controllers/<%= name %>.controller');
const checkAuth = require('../middlewares/CheckAuth.middleware');

router.post('/', <%= name %>Controller.create<%= h.capitalize(name) %>);
router.patch('/',<%= name %>Controller.update<%= h.capitalize(name) %>);
router.get('/:objectId?',<%= name %>Controller.get<%= h.capitalize(name) %>);
router.delete('/:objectId',<%= name %>Controller.delete<%= h.capitalize(name) %>);

module.exports = router;
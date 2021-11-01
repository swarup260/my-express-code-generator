---
to: <%= path %>/app/controllers/<%= name %>.controller.js
---

const { ObjectID } = require('mongodb');
const <%= h.capitalize(name) %>Model = require('../models/<%= name %>.model');

exports.create<%= h.capitalize(name) %> = async (request, response) => {
   try {

      const requestBody = request.body;
      /* Validation */
      if (typeof requestBody != "object") {
         return response.status(400).json({
            status: false,
            message: `required type object but instead got ${typeof requestBody}`
         })
      }

      // TODO :

      return response.status(200).json({
         status: true,
         message: "request processed successfully",
      });

   } catch (error) {
      return response.status(400).json({
         status: false,
         message: error.message
      })
   }
}

exports.update<%= h.capitalize(name) %> = async (request, response) => {
   try {

      const requestBody = request.body;
      /* Validation */
      if (typeof requestBody != "object") {
         return response.status(400).json({
            status: false,
            message: `required type object but instead got ${typeof requestBody}`
         })
      }

      // TODO :

      return response.status(200).json({
         status: true,
         message: "request processed successfully",
      });

   } catch (error) {
      return response.status(400).json({
         status: false,
         message: error.message
      })
   }
}

exports.get<%= h.capitalize(name) %> = async (request, response) => {
   try {
      const id = await request.params.objectId;

      if (!id) {
         return response.status(400).json({
            status: false,
            message: 'id is a required field'
         })
      }

      if (!ObjectID.isValid(id)) {
         return response.status(400).json({
            status: false,
            message: `invalid id`
         })
      }

      const result = await <%= h.capitalize(name) %>Model.findById(id);

      if (!result) {
         return response.status(200).json({
            status: false,
            message: 'Result Not Found!',
         })
      }

      return response.status(200).json({
         status: true,
         message: 'Result Found',
         data: result
      })

      

   } catch (error) {
      response.status(400).json({
         status: false,
         message: error.message
      })
   }
}

exports.delete<%= h.capitalize(name) %> = async (request, response) => {
   try {
      const id = await request.params.objectId;
      if (!id) {
         return response.status(400).json({
            status: false,
            message: 'id is a required field'
         })
      }

      if (!ObjectID.isValid(id)) {
         return response.status(400).json({
            status: false,
            message: `invalid id`
         })
      }

      const result = await <%= h.capitalize(name) %>Model
         .findByIdAndDelete(id).exec();
      if (result) {
         return response.status(200).json({
            status: true,
            message: '<%= h.capitalize(name) %> deleted successfully'
         });
      }

      return response.status(200).json({
         status: false,
         message: '<%= h.capitalize(name) %> With ObjectID Not Found'
      });

   } catch (error) {
      response.status(400).json({
         status: false,
         message: error.message
      })
   }
}



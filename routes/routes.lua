local Router = require("modules.router")



Router.get("/resource/get/{id}/{?city}", "users_controller.index")
Router.post("/resource/post", "users_controller.create")
Router.put("/resource/put/{id}", "users_controller.update")
Router.patch("/resource/patch/{id}", "users_controller.update")
Router.delete("/resource/delete/{id}", "users_controller.destroy")
-----------------

Router.get("/resource/main/get/{id}/{?city}", "main_controller.index")
Router.post("/resource/main/main/post", "main_controller.create")
Router.put("/resource/main/put/{id}", "main_controller.update")
Router.patch("/resource/main/patch/{id}", "main_controller.update")
Router.delete("/resource/main/delete/{id}", "main_controller.destroy")
Router.get("/resource/main/test", "main_controller")
Router.get("/resource/anon", function(req, res) return res:with_status("200 OK"):with_headers({["Content-Type"] = "application/json" }):with_output(req:get_inputs()):send() end)
Router.get("/resource/test1", "main_controller.asd")
Router.get("/resource/test2", "destroy")
Router.get("/resource/test3", "")
Router.get("/resource/test4")

-- Router.get("/resource", "main_controller.index")
-- Router.get("/resource/name/{?name}/{?age}", "main_controller.index")
-- Router.get("/resource/param/{?age}/{?name}/{?city}/{?country}/{?delivery}/{?post_code}", "main_controller.index")
-- Router.get("/resource/name/{id}/{?city}", "main_controller.index")
-- Router.post("/resource/main/user", "main_controller.create")
-- Router.post("/resource/main/post", "main_controller.create")
-- Router.put("/resource/main/put", "main_controller.update")
-- Router.patch("/resource/main/patch", "main_controller.update")
-- Router.delete("/resource/main/delete/{id}", "main_controller.destroy")
-- Router.get("/resource/test", "main_controller")
-- Router.get("/resource/testmet", "main_controller.asd")
-- Router.get("/resource/testukas", "destroy")
-- Router.get("/resource/testas", "")
-- Router.get("/resource/te")

return Router

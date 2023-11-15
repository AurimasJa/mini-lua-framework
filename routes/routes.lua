local Router = require("modules.router")

Router.get("/resource", "main_controller.index")
Router.get("/resource/get/{?name}/{?age}", "main_controller.index")
Router.get("/resource/param/{?age}/{?name}/{?city}/{?country}/{?delivery}/{?post_code}", "main_controller.index")
Router.get("/resource/name/{id}/{?city}", "main_controller.index")
Router.post("/resource/user", "main_controller.create")
Router.post("/resource/post", "main_controller.create")
Router.put("/resource/put", "main_controller.update")
Router.patch("/resource/patch", "main_controller.update")
Router.delete("/resource/delete", "main_controller.destroy")
Router.get("/resource/test", "main_controller")
Router.get("/resource/testmet", "main_controller.asd")
Router.get("/resource/testukas", "destroy")
Router.get("/resource/testas", "")
Router.get("/resource/te")
Router.get("/resource/anon", function(req) return print(req:get_inputs()) end)

return Router

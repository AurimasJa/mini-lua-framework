local Router = require("modules.router")

Router.get("/resource/get", "main_controller.index")
Router.post("/resource/post", "main_controller.create")
Router.put("/resource/put", "main_controller.update")
Router.patch("/resource/patch", "main_controller.update")
Router.delete("/resource/delete", "main_controller.destroy")
Router.get("/resource/test", "main_controller")
Router.get("/resource/testukas", "destroy")
Router.get("/resource/testas", "")
Router.get("/resource/te")
Router.get("/resource/anon", function(req) return print(req:get_payload(), "<<<<<<<<<<<<<<<<<<<<<<<") end)

return Router

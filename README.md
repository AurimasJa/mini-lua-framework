# LUA MICRO FRAMEWORK TO HANDLE HTTP REQUEST<br />

## Getting started<br />
Micro framework to handle HTTP requests using Lua programming language.

### Dependencies
- luarocks install cjson
- luarocks install luasql-sqlite3
- uhttpd web server

### Contents
3 types of contents:<br />
    "application/json",<br />
    "application/x-www-form-urlencoded",<br />
    "multipart/form-data"<br />
<br />

### Validation
Project includes:
- Route validation
- Request validation
- Content-type validation
- Controller validation

### Router

All available paths that current available<br />
```
Router.get("/", "users_controller.")
Router.get("/resource/get/{id}/{?city}", "users_controller.index")
Router.post("/resource/post", "users_controller.create")
Router.put("/resource/put/{id}", "users_controller.update")
Router.patch("/resource/patch/{id}", "users_controller.update")
Router.delete("/resource/delete/{id}", "users_controller.destroy")
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
```
You can add your own routes in
```
./routes/routes.lua
```
using like this:
```
Router.[method]("[path]", ["controller"])
Router.[method]("[path]", ["controller.method"])
Router.[method]("[path]", ["function"])
```

### Request
Request is being built from:
- Query
- Header
- Input

All methods accessed through setters/getters
```
local Request = require("Request")
local request_instance = Request.create()

SETTING DATA:
request_instance:set_headers({ ["Content-Type"] = "application/json" })
request_instance:set_query({ p1 = "value1", p2 = "value2" })
request_instance:set_inputs({ data = "example payload" })

GETTING DATA:
request_instance:get_headers()
request_instance:get_queries()
request_instance:get_inputs()

GETTING SPECIFIC DATA:
request_instance:get_header("Content-Type")
request_instance:get_query("param1")
request_instance:get_input("data")
```

### Response
Response you will get will be in application/json
Ability to give custom responses
```
function UsersController.index(req, resp, parsed_params)
    local response = {
        message = "Custom message",
        // other data
    }

    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end
```

### ORM
4DaysLua ORM is being used. It is little bit modified to be able to retrieve last inserted id from database.

### Parser
To get request payload/content-type/method/url-params/headers

### User model
There is built in user model and roles
User includes:
```
username, password, age, city, country, time_create
```
Roles includes:
```
name
```
UserRoles includes:
```
user_id, role_id
```

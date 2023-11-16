local cjson = require("cjson")
local models = require("models.users_model")
local User = models.User

local UsersController = {}
UsersController.__index = UsersController

function UsersController.new(model)
    local instance = {}
    setmetatable(instance, UsersController)
    instance.model = model
    return instance
end

function UsersController.index(req, resp, parsed_params)
    local user = User.get:where({ id = parsed_params["id"] }):first()

    local response = {
        message = "Request was successful",
        parsed_params = parsed_params,
        request = req,
        user = user and user.username or nil
    }

    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function UsersController.create(req, resp, parsed_params)
    local user = User({
        username = req.input.username,
        password = req.input.password,
        city = req.input.city,
        country = req.input.country,
        age = req.input.age,
        time_create = os.time()
    })
    user:save()

    local response = {
        message = "Request was successful, created",
        parsed_params = parsed_params,
        username = user.username,
        request = req
    }

    return resp:with_status(201):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

-----------------
function UsersController.update(req, resp, parsed_params)
    for index, value in pairs(req.input) do
        print(index, value)
    end
    local user = User.get:where({ id = parsed_params["id"] }):first()
    if req.input.username ~= "" or req.input.username ~= nil then user.username = req.input.username end
    if req.input.password ~= "" or req.input.password ~= nil then user.password = req.input.password end
    if req.input.city ~= "" or req.input.city ~= nil then user.city = req.input.city end
    if req.input.country ~= "" or req.input.country ~= nil then user.country = req.input.country end
    if req.input.age ~= "" or req.input.age ~= nil then user.age = req.input.age end
    user:save()

    local response = {
        message = "Update was successful",
        parsed_params = parsed_params,
        username = user.username,
        request = req
    }

    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function UsersController.destroy(req, resp, parsed_params)
    local user = User.get:where({ id = parsed_params["id"] }):first()


    local response = {
        message = "Delete was successful",
        parsed_params = parsed_params,
        request = req
    }
    if user and user.username then
        print("Username:", user.username)
        user:delete()
        return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
    end
    
    return resp:with_status(400):with_headers({ ["Content-Type"] = "application/json" }):with_output("BAD REQUEST"):send()
end

function UsersController.default(req, resp, parsed_params)
    local response = {
        message = "That is default method",
        parsed_params = parsed_params,
        request = req
    }
    local json_response = cjson.encode(response)
    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

return UsersController

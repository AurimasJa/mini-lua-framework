local cjson = require("cjson")
local Valid = require("middleware.controller_validator.validator")
local models = require("models.users_model")
local rmodels = require("models.roles_model")
local codes = require("responses.http_codes")

local UsersController = {}
UsersController.__index = UsersController

function UsersController.new(model)
    local instance = {}
    setmetatable(instance, UsersController)
    instance.model = model
    return instance
end

function UsersController.index(req, resp, parsed_params)
    local user = models.User.get:where({ id = parsed_params["id"] }):first()

    local response = {
        message = "Request was successful",
        user = user and user.username or nil
    }

    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function UsersController.create(req, resp, parsed_params)
    -- local validator = Valid.new(req:get_inputs())
    -- local is_data_valid, error_message = validator:validate_all_data()
    -- if not is_data_valid then
    --     return resp:with_status(codes.BadRequest):with_headers({ ["Content-Type"] = "application/json" }):with_output(
    --         error_message):send()
    -- end

    -- local role1 = rmodels.Role.get:where({ id = 1 }):first()
    -- local role2 = rmodels.Role.get:where({ id = 2 }):first()
    -- for key, value in pairs(role1) do
    --     print(key, value)
    -- end
    local user = models.User({
        username = req:get_input("username"),
        password = req:get_input("password"),
        city = req:get_input("city"),
        country = req:get_input("country"),
        age = req:get_input("age"),
        time_create = os.time()
    })
    print(user:save())
    -- local success, error_message = pcall(function()
    --     user:save()
    -- end)
    
    -- if not success then
    --     return resp:with_status(400)
    --     :with_headers({ ["Content-Type"] = "application/json" })
    --     :with_output(error_message)
    --     :send()
    -- end
    -- print(role1:_data())
    -- print(user:_data())
    -- -- print(user:update())
    -- print(user.update)
    -- print(user._data.id)
    -- for key, value in pairs(user._data.id) do
    --     print(key, value)
    --     if type(value) == "table" then
    --         for k, v in pairs(value) do
    --             print(k, v)
    --         end
    --     end
    --     -- print(key,value)
    -- end
    -- local userrole1 = models.UserRole({
    --     user_id = 1,
    --     role_id = 1,
    -- })
    -- userrole1:save()

    -- local userrole2 = models.UserRole({
    --     user_id = 1,
    --     role_id = 2,
    -- })
    -- userrole2:save()
    local response = {
        message = "Request was successful, user created",
    }

    return resp:with_status(201):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function UsersController.update(req, resp, parsed_params)
    local validator = Valid.new(req.input)
    local is_data_valid, error_message = validator:validate_all_data()
    if not is_data_valid then
        return resp:with_status(codes.BadRequest):with_headers({ ["Content-Type"] = "application/json" }):with_output(
            error_message):send()
    end
    local user = models.User.get:where({ id = parsed_params["id"] }):first()
    if req.input.username ~= "" or req.input.username ~= nil then user.username = req.input.username end
    if req.input.password ~= "" or req.input.password ~= nil then user.password = req.input.password end
    if req.input.city ~= "" or req.input.city ~= nil then user.city = req.input.city end
    if req.input.country ~= "" or req.input.country ~= nil then user.country = req.input.country end
    if req.input.age ~= "" or req.input.age ~= nil then user.age = req.input.age end
    local success = user:save()
    if success then
        return resp:with_status(400):with_headers({ ["Content-Type"] = "application/json" }):with_output(
            "There was an error updating your value"):send()
    end
    local response = {
        message = "Update was successful",
    }

    return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function UsersController.destroy(req, resp, parsed_params)
    local user = models.User.get:where({ id = parsed_params["id"] }):first()

    local response = {
        message = "Delete was successful",
    }
    if user and user.username then
        local success = user:delete()
        if success then
            return resp:with_status(400):with_headers({ ["Content-Type"] = "application/json" }):with_output(
                "There was an error deleting your request"):send()
        end
        return resp:with_status(200):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
    end

    return resp:with_status(400):with_headers({ ["Content-Type"] = "application/json" }):with_output("BAD REQUEST"):send()
end

return UsersController

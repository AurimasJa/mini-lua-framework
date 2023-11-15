local cjson = require("cjson")
local users = require("models.users_model")

local MainController = {}



function MainController.index(req, resp, parsed_params)
    -- if type(parsed_params["id"]) ~= "number" then
    --     return resp:with_status("400 Bad request"):with_headers({["Content-Type"] = "application/json" }):with_output("Provided ID is incorrect"):send()
    -- end

    -- -- -- --Router.get("/resource/name/{id}/{?city}", "main_controller.index") -- only for this path
    -- local success, user = users.find_by_id(parsed_params["id"])

    -- if not success then
    --     return resp:with_status("400 Bad request"):with_headers({["Content-Type"] = "application/json" }):with_output("Provided ID is incorrect"):send()
    -- end

    local response = {
        message = "Request was successful",
        parsed_params = parsed_params,
        -- username = user.username,
        -- city = user.city,
        request = req
    }

    -- local json_response = cjson.encode(response)
    return resp:with_status("200 OK"):with_headers({["Content-Type"] = "application/json" }):with_output(response):send()
end




function MainController.create(req, resp, parsed_params)
    -- local data = cjson.encode(req.input)
    -- data = cjson.decode(data)
    local success, user = users.create(req.input)
    if not success then
        return resp:with_status("400 Bad request"):with_headers({["Content-Type"] = "application/json" }):with_output("Provided data is incorrect"):send()
    end

    local response = {
        message = "Request was successful, created",
        parsed_params = parsed_params,
        username = "user.username",
        city = "user.city"
    }


    return resp:with_status("201 Created"):with_headers({["Content-Type"] = "application/json" }):with_output(response):send()
end
-----------------
function MainController.update(req, resp, parsed_params)
    local response = {
        message = "Put/patch, main controller",
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return resp:with_status("200 OK"):with_headers({["Content-Type"] = "application/json" }):with_output(response):send()
end

function MainController.destroy(req, resp, parsed_params)
    local response = {
        message = "Destroy, main controller",
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return resp:with_status("200 OK"):with_headers({["Content-Type"] = "application/json" }):with_output(response):send()
end

function MainController.default(req, resp, parsed_params)
    local response = {
        message = "Default, main controller",
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return resp:with_status("200 OK"):with_headers({["Content-Type"] = "application/json" }):with_output(response):send()

end

return MainController

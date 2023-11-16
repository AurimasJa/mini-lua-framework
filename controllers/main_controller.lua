local cjson = require("cjson")

local MainController = {}
MainController.__index = MainController

function MainController.new(model)
    local instance = {}
    setmetatable(instance, MainController)
    instance.model = model
    return instance
end

function MainController.index(req, resp, parsed_params)
    local response = {
        message = "Request was successful, index",
        parsed_params = parsed_params,
        request = req
    }

    return resp:with_status("200 OK"):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function MainController.create(req, resp, parsed_params)
    local response = {
        message = "Request was successful, create",
        parsed_params = parsed_params,
        request = req
    }
    return resp:with_status("201 Created"):with_headers({ ["Content-Type"] = "application/json" }):with_output(response)
    :send()
end

function MainController.update(req, resp, parsed_params)
    local response = {
        message = "Put/patch, main controller",
        parsed_params = parsed_params,
        request = req
    }
    return resp:with_status("200 OK"):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function MainController.destroy(req, resp, parsed_params)
    local response = {
        message = "Destroy, main controller",
        parsed_params = parsed_params,
        request = req
    }
    return resp:with_status("200 OK"):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

function MainController.default(req, resp, parsed_params)
    local response = {
        message = "Default, main controller",
        parsed_params = parsed_params,
        request = req
    }

    return resp:with_status("200 OK"):with_headers({ ["Content-Type"] = "application/json" }):with_output(response):send()
end

return MainController

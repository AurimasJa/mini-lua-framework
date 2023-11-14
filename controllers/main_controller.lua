local cjson = require("cjson")
local MainController = {}


function MainController.index(req, method, url, parsed_params)
    local response = {
        message = "Index, main controller   " .. url .. "    " .. method,
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.create(req, method, url, parsed_params)
    local response = {
        message = "Create, main controller   " .. url .. "    " .. method,
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.update(req, method, url, parsed_params)
    local response = {
        message = "Put/patch, main controller   " .. url .. "    " .. method,
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.destroy(req, method, url, parsed_params)
    local response = {
        message = "Destroy, main controller   " .. url .. "    " .. method,
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.default(req, method, url, parsed_params)
    local response = {
        message = "Default, main controller   " .. url .. "    " .. method,
        parsed_params = parsed_params,
        req = req
    }
    local json_response = cjson.encode(response)
    return json_response
end

return MainController

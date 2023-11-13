local cjson = require("cjson")
local MainController = {}


function MainController.index(body)
    local response = {
        message = "Index, main controller"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.create(body)
    local response = {
        message = "Create, main controller"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.update(body)
    local response = {
        message = "Put/patch, main controller"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.destroy(body)
    local response = {
        message = "Destroy, main controller"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function MainController.default(body)
    local response = {
        message = "Default, main controller"
    }
    local json_response = cjson.encode(response)
    return json_response
end

return MainController

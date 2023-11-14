local cjson = require("cjson")
local Request = {}
Request.__index = Request

function Request:create()
    local ins = {}
    setmetatable(ins, Request)
    ins.headers = {}
    ins.query = {}
    ins.input = {}
    return ins
end

function Request:set_headers(headers)
    self.headers = headers
end

function Request:set_query(query)
    self.query = query
end

function Request:set_inputs(input)
    self.input = input
end

function Request:get_queries()
    local response = {
        query = self.query
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_query(key)
    local response = {
        [key] = self.query[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_headers()
    return self.headers
end

function Request:get_header(key)
    local response = {
        [key] = self.headers[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_inputs()
    return self.input
end

function Request:get_input(key)
    local response = {
        [key] = self.input[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

return Request

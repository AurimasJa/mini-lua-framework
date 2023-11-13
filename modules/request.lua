local cjson = require("cjson")
local Request = {}
Request.__index = Request

function Request:create()
    local ins = {}
    setmetatable(ins, Request)
    ins.headers = {}
    ins.query = {}
    ins.payload = {}
    return ins
end

function Request:set_headers(headers)
    self.headers = headers
end

function Request:set_query(query)
    self.query = query
end

function Request:set_payload(payload)
    self.payload = payload
end

function Request:get_query()
    local response = {
        url = self.query
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_query_value(key)
    local response = {
        [key] = self.query[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_headers()
    local response = {}

    for key, value in pairs(self.headers) do
        response[key] = value
    end

    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_headers_value(key)
    local response = {
        [key] = self.headers[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_payload()
    local response = {}

    for key, value in pairs(self.payload) do
        response[key] = value
    end

    local json_response = cjson.encode(response)
    return json_response
end

function Request:get_payload_value(key)
    local response = {
        [key] = self.payload[key] or "nil"
    }
    local json_response = cjson.encode(response)
    return json_response
end

return Request

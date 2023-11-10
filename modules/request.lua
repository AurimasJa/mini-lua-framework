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
    return self.query
end

function Request:get_headers()
    return self.headers
end

function Request:get_payload()
    return self.payload
end
return Request
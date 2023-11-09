local cjson = require("cjson")
local Request = require("modules.request")
local Parser = {}

local function parse_json(data)
    local parsedData = {}
    parsedData = cjson.decode(data)
    return parsedData
end
local function parse_encoded(data)
    local parsedData = {}
    local sequences = {}
    -- local query = data:match("%?(.*)")
    for pair in data:gmatch("[^&]+") do
        table.insert(sequences, pair)
    end
    for _, sequence in ipairs(sequences) do
        local key, value = sequence:match("([^=]+)=([^=]+)")
        if key and value then
            key = key:gsub("+", " "):gsub("%%(%x%x)", function(h)
                return string.char(tonumber(h, 16))
            end)
            value = value:gsub("+", " "):gsub("%%(%x%x)", function(h)
                return string.char(tonumber(h, 16))
            end)
            parsedData[key] = value
        end
    end
    return parsedData
end
local function parse_multipart(data, boundary)
    local parsedData = {}
    local parts = {}
    local boundaryDelimiter = "--" .. boundary

    for part in data:gmatch("(.-)" .. boundaryDelimiter) do
        table.insert(parts, part)
    end

    for _, part in ipairs(parts) do
        local name, value = part:match('name="([^"]-)"%s*\n%s*\n([^\n]*)\n')
        if name then
            parsedData[name] = value
        end
    end

    return parsedData
end

function Parser.parseRequest(env)
    local urlParams = env.QUERY_STRING
    local headers = env
    return urlParams, headers
end

function Parser.parse_request_method(env)
    return env.REQUEST_METHOD
end

function Parser.parse_url_route(env)
    local route = env.REQUEST_URI
    if string.find(route, "/$") then
        route = route:sub(1, -2)
    end
    return string.match(route, "/api(.+)") --/api/(.+)
end

function Parser.parse_body(content_type, body, urlParams, headers)
    local data = {}
    local req = Request:create()

    if content_type == "application/json" then
        data = parse_json(body)
    elseif content_type == "application/x-www-form-urlencoded" then
        data = parse_encoded(urlParams)     -- URL
    elseif string.match(content_type, "^multipart/form%-data") then
        local boundary = content_type:match("boundary=([^;]+)")
        if boundary then
            data = parse_multipart(body, boundary)
        else
            data.error = "Invalid multipart/form-data format"
        end
    end
    if not data.error then
    
        req:set_headers(headers)
        req:set_query(urlParams)
        req:set_payload(body)
        return req
    end
    return req
end

return Parser

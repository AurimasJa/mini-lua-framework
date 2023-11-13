local cjson = require("cjson")
local Request = require("modules.request")
local Parser = {}

local function parse_json(data)
    local parsedData = {}
    parsedData = cjson.decode(data)
    return parsedData
end
local function parse_encoded(data, body)
    local parsedData = {}
    local sequences = {}
    local data_to_parse = body
    if not body or body == "" then
        data_to_parse = data
    end
    -- local query = data:match("%?(.*)")
    for pair in data_to_parse:gmatch("[^&]+") do
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
    return string.match(route, "/api(/[^?]+)")
end

-- function Parser.is_parameter_must_be

function Parser.parse_url_parameters(url)
    local params = {}
    local sequences = {}
    for pair in url:gmatch("[^&]+") do
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
            params[key] = value
        end
    end
    return params
end

function Parser.parse_body(content_type, body, urlParams, headers)
    local data = {}
    local data_error
    local req = Request:create()

    if content_type == "application/json" then
        data = parse_json(body)
    elseif content_type == "application/x-www-form-urlencoded" then
        data = parse_encoded(urlParams, body)
    elseif string.match(content_type, "^multipart/form%-data") then
        local boundary = content_type:match("boundary=([^;]+)")
        if boundary then
            data = parse_multipart(body, boundary)
        else
            data_error = "Invalid multipart/form-data format"
        end
    end
    if not data.error then
        req:set_headers(headers)
        req:set_query(urlParams)
        req:set_payload(data)
        return req
    end
    return data_error
end

return Parser

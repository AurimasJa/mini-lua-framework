local cjson = require("cjson")
local Request = require("modules.request")
local Responses = require("modules.http_responses")
local Parser = {}

local function parse_json(data, uhttpd)
    local success, response = pcall(cjson.decode, data)
    if not success then
        return Responses.send_bad_request(uhttpd, response .. ". Check your inputs.")
    end
    return response
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

function Parser.parse_body(content_type, body, urlParams, headers, uhttpd)
    local data = {}
    local data_error
    local success
    local req = Request:create()
    if body ~= "" then
        if content_type == "application/json" then
            data = parse_json(body, uhttpd)
        elseif content_type == "application/x-www-form-urlencoded" then
            success, data = pcall(parse_encoded, urlParams, body)
            if not success then
                return Responses.send_bad_request(uhttpd, data .. ". Check your inputs.")
            end
        elseif string.match(content_type, "^multipart/form%-data") then
            local boundary = content_type:match("boundary=([^;]+)")
            if boundary then
                success, data = pcall(parse_multipart, body, boundary)

                if not success then
                    return Responses.send_bad_request(uhttpd, data .. ". Check your inputs.")
                end
            else
                return Responses.send_bad_request(uhttpd, "Invalid multipart/form-data format.")
            end
        end
    end

    local url_params = Parser.parse_url_parameters(urlParams)
    req:set_headers(headers)
    req:set_query(url_params)
    req:set_inputs(data)
    return req
end

return Parser

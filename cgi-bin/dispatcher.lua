package.path = package.path .. ";/www/cgi-bin/?.lua;/www/?.lua"
local Router = require("modules.router")
local Parser = require("middleware.parser")
local Validator = require("middleware.validator")
local Request = require("modules.request")
local Helper = require("helpers.read_request_body")
local routes = require("routes")

local function send_response(response)
    uhttpd.send("Status: 200\r\n")
    uhttpd.send("Content-Type: text/html\r\n\r\n")
    uhttpd.send(response)
end

local Dispatcher = {}

function handle_route(env)
    local parsedUrl = Parser.parse_url_route(env)
    print(parsedUrl)
    local urlParams, headers = Parser.parseRequest(env)
    local content_type = Validator.validate_content_type(uhttpd, headers)
    if content_type ~= false then
        local body = Helper.read_request_body(headers)

        local req = Request:create()
        req = Parser.parse_body(content_type, body, urlParams, headers)
        if req:get_headers() ~= nil then
            print(req:get_headers())
        end
        if req:get_query() ~= nil then
            print(req:get_query())
        end
        if req:get_payload() ~= nil then
            print(req:get_payload())
        end
        Router.match(parsedUrl, Parser.parse_request_method(env), urlParams, uhttpd, body)
    end


    -- local parsedUrl = Parser.parse_url_route(env)
    -- local request_method = Parser.parse_request_method(env)

    -- if parsedUrl:match("^route/") then

    --     local Router = require("modules.router")
    --     local send = send_response
    --     Router.env = env
    --     Router.handle_request(env, send)
    -- else
    --     uhttpd.send("invalid link")
    -- end
end

-- Main body required by uhhtpd-lua plugin
function handle_request(env)
    -- -- -- -- -- -- Injected uhttpd method
    uhttpd.send("Status: 200\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    handle_route(env)

    -- handle_route(env)
    -- for k, v in pairs(env) do
    --     if type(v) == "table" then
    --         for key, value in pairs(v) do
    --             uhttpd.send(key .. "  ->  " .. value .. "\n")
    --         end
    --     else
    --         uhttpd.send(k .. "  ->  " .. v .. "   \n")
    --     end
    -- end
end

return Dispatcher

-- uhttpd.send("   ||| {METHOD} ---->  " .. request_method .. "\r\n")
-- uhttpd.send("   ||| {ROUTE} ---->  " .. parsedUrl .. "\r\n\r\n")

-- for k, v in pairs(env) do
--     if type(v) == "table" then
--         for key, value in pairs(v) do
--             uhttpd.send(key .. "  ->  " .. value .. "\n")
--         end
--     else
--         uhttpd.send(k .. "  ->  " .. v .. "   \n")
--     end
-- end

-- Router.send = send_response
-- Router.env = env
-- Router.handle_request(env)


-- local route = env.REQUEST_URI  -- Extract the route from the request URI
-- print(route)
-- if Router.route(route) then
--     local url = "localhost"
--     local headers = { ["Content-Type"] = "application/json", ["Date"] = "2023-11-07" }
--     local parsedData = Parser.parseEnvironmentVariables(url, headers)
--     print("Parsed Data:", parsedData)
--     -- print(#parsedData)
--     -- for key, value in pairs(parsedData) do
--     --     print(key .. "   ----->    " .. value)
--     --     break
--     -- end
--     local contentType = "application/json"
--     if ContentType.supportedTypes(contentType) then
--         print("Content type supported:", contentType)
--     end

--     local statusCode = 200
--     HTTPCodes.setCode(statusCode)

--     local validationHeaders = { ["Content-Type"] = "application/json", ["Date"] = "2023-11-07" }
--     local isValid, message = Validator.validateRequest(validationHeaders, "Some data")
--     print("Validation:", isValid, message)
-- else
--     -- Handle case when the route doesn't exist
--     send_response("Route not found")
-- end

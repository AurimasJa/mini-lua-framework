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

end

-- Main body required by uhhtpd-lua plugin
function handle_request(env)
    -- -- -- -- -- -- Injected uhttpd method
    uhttpd.send("Status: 200\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    handle_route(env)
end

return Dispatcher

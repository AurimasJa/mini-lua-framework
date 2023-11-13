package.path = package.path .. ";/www/cgi-bin/?.lua;/www/?.lua"
local Router = require("modules.router")
local Parser = require("middleware.parser")
local Validator = require("middleware.validator")
local Request = require("modules.request")
local Helper = require("helpers.read_request_body")
local Routes = require("routes")
local Responses = require("modules.http_responses")

local function send_response(response)
    uhttpd.send("Status: 200\r\n")
    uhttpd.send("Content-Type: text/html\r\n\r\n")
    uhttpd.send(response)
end

local Dispatcher = {}

function handle_route(env)
    local method = Parser.parse_request_method(env)
    local parsedUrl = Parser.parse_url_route(env)
    local urlParams, headers = Parser.parseRequest(env)
    local content_type = Validator.validate_content_type(uhttpd, headers)
    if content_type ~= false then
        local body = Helper.read_request_body(headers)
        local req = Request:create()
        req = Parser.parse_body(content_type, body, urlParams, parsedUrl, headers)
        local route = Routes.route(parsedUrl, urlParams, method, uhttpd, req)

        uhttpd.send("Status: 200\r\n")
        uhttpd.send("Content-Type: application/json\r\n\r\n")
        if route ~= nil then
            print(route)
        end
        if type(req) == "table" then
            if req:get_headers() ~= nil then
                print(req:get_headers_value("REQUEST_METHOD"))
            end
            if req:get_query() ~= nil then
                print(req:get_query())
            end
            if req:get_payload() ~= nil then
                print(req:get_payload_value("name"))
            end
        else
            print(req)
        end
    end
end

function handle_request(env)
    handle_route(env)
end

return Dispatcher

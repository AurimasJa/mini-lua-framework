package.path = package.path .. ";/www/cgi-bin/?.lua;/www/?.lua"
local Router = require("modules.router")
local Parser = require("middleware.parser")
local Validator = require("middleware.validator")
local Request = require("modules.request")
local Helper = require("helpers.read_request_body")
local Routes = require("routes.routes")
local Responses = require("responses.http_responses")

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
    local content_type = Validator.validate_content_type(headers)
    if content_type ~= false then
        local body = Helper.read_request_body(headers)
        local req = Request.create()
        req = Parser.parse_body(content_type, body, urlParams, headers)
        local route = Routes.route(parsedUrl, method, req)

        if route ~= nil then
            print(route)
        end
        if type(req) == "table" then
            if req:get_headers() ~= nil then
                print(req:get_header("REQUEST_METHOD"))
            end
            if req:get_queries() ~= nil then
                print(req:get_queries())
            end
            if req:get_inputs() ~= nil then
                print(req:get_input("name"))
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

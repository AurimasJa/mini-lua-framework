local Responses = require("modules.http_responses")
local Parser = require("middleware.parser")
local Router = {}
local routes = {}
local contr = require("controllers.main_controller")

function Router.add_route(url, handler, method)
    routes[url] = {
        method = method,
        handler = handler
    }
end

function Router.get(url, handler)
    Router.add_route(url, handler, "GET")
end

function Router.post(url, handler)
    Router.add_route(url, handler, "POST")
end

function Router.put(url, handler)
    Router.add_route(url, handler, "PUT")
end

function Router.patch(url, handler)
    Router.add_route(url, handler, "PATCH")
end

function Router.delete(url, handler)
    Router.add_route(url, handler, "DELETE")
end

function Router.default(params)
    return contr.default("test") -- TODO: check if default function exists
end

function Router.route(url, urlParams, method, uhttpd, req)
    local parsed_url = Parser.parse_url_parameters(urlParams)

    local route = routes[url]

    if not route then
        return Responses.send_not_found(uhttpd) -- check response
    end
    local handler = route.handler

    if route.method ~= method or not handler then
        return Responses.send_method_not_allowed(uhttpd) -- check response
    end

    if type(handler) == "function" then
        return handler(req)
    end

    local controller_name, function_name = string.match(handler, "([^.]+)%.?([^.]*)")
    if not controller_name then
        return Responses.send_internal_server_error(uhttpd) -- check response
    end
    if not function_name or function_name == "" then
        function_name = "default"
        Router.default(req)
    end

    local success, controller = pcall(require, "controllers." .. controller_name)
    if not success then
        return Responses.send_not_found(uhttpd) -- check response
    end

    if not controller or not controller[function_name] or type(controller[function_name]) ~= "function" then
        return Responses.send_not_found(uhttpd) -- check response
    end

    return controller[function_name](req)
end

return Router

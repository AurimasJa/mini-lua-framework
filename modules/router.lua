-- router.lua
local Parser = require("middleware.parser")
local Responses = require("modules.http_responses")
local router = {}
local routes = {}

function router.get(url, handler)
    routes[url] = {
        method = "GET",
        handler = handler or "main_controller",
        handler_method = "index"
    };
end

function router.post(url, handler)
    routes[url] = {
        method = "POST",
        handler = handler or "main_controller",
        handler_method = "create"
    };
end

function router.put(url, handler)
    routes[url] = {
        method = "PUT",
        handler = handler or "main_controller",
        handler_method = "update"
    };
end

function router.patch(url, handler)
    routes[url] = {
        method = "PATCH",
        handler = handler or "main_controller",
        handler_method = "update"
    };
end

function router.delete(url, handler)
    routes[url] = {
        method = "DELETE",
        handler = handler or "main_controller",
        handler_method = "destroy"
    };
end

function router.match(url, method, urlParams, uhttpd, body)
    -- local url = urlas
    -- local method = "GET"
    local params = urlParams
    -- local data = "asdsad"
    print(url .. " <-----------")
    print(method .. " <-----------")
    print(params .. " <-----------")
    print(body .. " <-----------")
    if method == "GET" then
        router.get(url)
    elseif method == "POST" then
        router.post(url)
    elseif method == "PUT" then
        router.put(url)
    elseif method == "DELETE" then
        router.delete(url)
    end

    local route = routes[url]
    print(route.handler)
    if not route then
        Responses.send_not_found(uhttpd)
        return
    end

    print(method, route.method)
    if method ~= route.method then
        Responses.send_method_not_allowed(uhttpd)
        return
    end

    -- local controller_name, function_name = string.gmatch(route.handler,"([^.]+)%.([^.]+)")--(%a+).(%a+)
    -- print("------------------------")
    -- print(controller_name, function_name)
    -- if not controller or not function_name then
    --     -- Handle invalid handler
    --     Responses.send_internal_server_error(uhttpd)
    --     return
    -- end

    local controller = require("controllers.main_controller")
    -- function_name = function_name or "index"

    -- -- Call the controller function
    controller[route.handler_method](url, params, body)
end

return router

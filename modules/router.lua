local Responses = require("responses.http_responses")
local Response = require("responses.response")

local Router = {}
local routes = {}
local default_functions = {
    GET = "index",
    POST = "create",
    PUT = "put",
    PATCH = "patch",
    DELETE = "destroy"
}

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

function Router.default(req, url, method, parsed_params, controller_name, function_name)
    local success, controller = pcall(require, "controllers." .. controller_name)

    if not success then
        return Responses.send_not_found("Controller [" .. controller_name .. "] does not exist!")
    end

    if not controller or not controller[function_name] or type(controller[function_name]) ~= "function" then
        return Responses.send_not_found("Controller [" .. function_name .. "] method does not exist!")
    end
    local response = Response.new()
    return controller[function_name](req, response, parsed_params)
end

local function match_route(route, url)
    local pattern = "^" .. route:gsub("{%??([^/]+)}", "([^/]-)"):gsub("/", "/?") .. "$" -- ([^/]+)
    if url == "" or url == nil then
        return Responses.send_bad_request("Url is not provided correctly. Resource does not exist.")
    end
    local records = { string.match(url, pattern) }

    if #records > 0 then
        local params = {}

        local param_pattern = "{(%??)([^/]+)}" -- {?id} ~= {id}
        local param_names = {}

        for optional, value in route:gmatch(param_pattern) do
            local is_optional = optional == "?" -- true = ?
            table.insert(param_names, { value = value, optional = is_optional })
        end

        local counter = 1
        local records_cleaned = {}

        for _, value in ipairs(records) do
            if value ~= "" then
                table.insert(records_cleaned, value)
            end
        end

        for _, param in ipairs(param_names) do
            if not param.optional and (records_cleaned[counter] == nil or records_cleaned[counter] == "") then
                return Responses.send_bad_request("Parameters must be provided. " .. route)
            end

            params[param.value] = records_cleaned[counter] or (param.optional and "") -- or nil
            counter = counter + 1
        end

        return true, params, route
    end

    return false
end
function Router.route(url, method, req)
    local response = Response.new()
    local parsed_params
    local success
    for route, struct in pairs(routes) do
        local temp
        success, parsed_params, temp = match_route(route, url)
        if success and struct.method == method then
            url = temp
            break
        end
    end

    local route = routes[url]

    if not route then
        return Responses.send_not_found("Route " .. url .. " is not implemented")
    end

    local handler = route.handler

    if route.method ~= method or not handler then
        return Responses.send_method_not_allowed("There was a problem with your request - " ..
            method .. "; expected " .. route.method .. " or handler was not implemented")
    end

    if type(handler) == "function" then
        return handler(req, response)
    end

    local controller_name, function_name = string.match(handler, "([^.]+)%.?([^.]*)")

    if not controller_name then
        return Responses.send_not_found("Controller does not exist!")
    end

    if not function_name or function_name == "" then
        function_name = default_functions[route.method]
    end

    local success, controller = pcall(require, "controllers." .. controller_name)
    print(controller)
    if not success then
        return Responses.send_not_found("Controller [" .. controller_name .. "] does not exist!")
    end

    if not controller or not controller[function_name] or type(controller[function_name]) ~= "function" then
        return Responses.send_not_found("Controller [" .. function_name .. "] method does not exist!")
    end


    return controller[function_name](req, response, parsed_params)
end

return Router

local cjson = require("cjson")
local Responses = {}

function Responses.send_bad_request(uhttpd)
    local response = {
        response = "Bad request"
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 400 Bad request\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

function Responses.send_unauthorized(uhttpd)
    local response = {
        response = "Unauthorized"
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 401 Unauthorized\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

function Responses.send_forbidden(uhttpd)
    local response = {
        response = "Forbidden"
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 403 Forbidden\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

function Responses.send_not_found(uhttpd, message)
    local response = {
        response = message
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 404 Not Found\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

function Responses.send_method_not_allowed(uhttpd)
    local response = {
        response = "Method not allowed"
    }

    local json_response = cjson.encode(response)

    uhttpd.send("Status: 405 Method not allowed\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end


function Responses.send_unsupported_media_type(uhttpd)
    local response = {
        response = "Unsupported Media Type"
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 415 Unsupported Media Type\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

function Responses.send_internal_server_error(uhttpd)
    local response = {
        response = "Internal server error"
    }
    local json_response = cjson.encode(response)
    uhttpd.send("Status: 500 Internal server error\r\n")
    uhttpd.send("Content-Type: application/json\r\n\r\n")
    uhttpd.send(json_response)
    os.exit()
end

return Responses

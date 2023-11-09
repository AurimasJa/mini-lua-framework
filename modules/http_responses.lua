local Responses = {}

function Responses.send_bad_request(uhttpd)
    uhttpd.send("Status: 400\r\n")
    uhttpd.send("Bad request\r\n\r\n")
end

function Responses.send_unauthorized(uhttpd)
    uhttpd.send("Status: 401\r\n")
    uhttpd.send("Unauthorized\r\n\r\n")
end

function Responses.send_forbidden(uhttpd)
    uhttpd.send("Status: 403\r\n")
    uhttpd.send("Forbidden\r\n\r\n")
end

function Responses.send_not_found(uhttpd)
    uhttpd.send("Status: 404\r\n")
    uhttpd.send("Not Found\r\n\r\n")
end

function Responses.send_method_not_allowed(uhttpd)
    uhttpd.send("Status: 405\r\n")
    uhttpd.send("Method not allowed\r\n\r\n")
end

function Responses.send_unsupported_media_type(uhttpd)
    uhttpd.send("Status: 415\r\n")
    uhttpd.send("Provided content is not supported\r\n\r\n")
end

function Responses.send_internal_server_error(uhttpd)
    uhttpd.send("Status: 500\r\n")
    uhttpd.send("Internal server error\r\n\r\n")
end

return Responses

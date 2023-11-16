local cjson = require("cjson")
local Responses = {}
local R = require("responses.response")
local codes = require("responses.http_codes")

local resp = R.new()
function Responses.send_bad_request(message)
    resp:with_status(codes.BadRequest):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_unauthorized(message)
    resp:with_status(codes.Unauthorized):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_forbidden(message)
    resp:with_status(codes.Forbidden):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_not_found(message)
    resp:with_status(codes.NotFound):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_method_not_allowed(message)
    resp:with_status(codes.MethodNotAllowed):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_unsupported_media_type(message)
    resp:with_status(codes.UnsupportedMediaType):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

function Responses.send_internal_server_error(message)
    resp:with_status(codes.InternalServerError):with_headers({ ["Content-Type"] = "application/json" }):with_output(message):send()
    os.exit()
end

return Responses
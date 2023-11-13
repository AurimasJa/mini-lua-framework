local Responses = require("modules.http_responses")
local Available_Contents = require("core.content-type")
local Validator = {}



function Validator.validate_content_type(uhttpd, headers)
    if not headers.CONTENT_TYPE then
        Responses.send_bad_request(uhttpd)
        return false
    end

    local content_type = headers.CONTENT_TYPE

    local is_valid = false
    for _, allowed_type in ipairs(Available_Contents) do
        if string.match(content_type, allowed_type) then
            is_valid = true
            break
        end
    end

    if not is_valid then
        Responses.send_unsupported_media_type(uhttpd)
    end

    return content_type
end


return Validator


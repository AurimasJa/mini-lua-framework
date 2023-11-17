local Responses = require("responses.http_responses")
local Available_Contents = require("core.content-type")
local Validator = {}



function Validator.validate_content_type(headers)
    if not headers.CONTENT_TYPE then
        Responses.send_bad_request("Request CONTENT-TYPE is not provided!")
        return false
    end

    local content_type = headers.CONTENT_TYPE

    local is_valid = false
    for _, allowed_type in ipairs(Available_Contents) do
        if string.match(content_type, allowed_type) and #content_type == #allowed_type then
            is_valid = true
            break
        end
    end

    if not is_valid then
        Responses.send_unsupported_media_type("The provided CONTENT_TYPE [" .. headers.CONTENT_TYPE .. "] is not supported.")
    end

    return content_type
end

return Validator

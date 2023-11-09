local Responses = require("modules.http_responses")
local Contents = require("core.content-type")
local Validator = {}



function Validator.validate_content_type(uhttpd, headers)
    if not headers.CONTENT_TYPE then
        Responses.send_bad_request(uhttpd)
        return false
    end

    local contentType = headers.CONTENT_TYPE

    local isValidContentType = false
    if type(Contents[contentType]) == "boolean" then
        isValidContentType = Contents[contentType]
    elseif type(Contents["multipart/form-data"]) == "function" then
        isValidContentType = Contents["multipart/form-data"](contentType)
    end

    if not isValidContentType then
        Responses.send_unsupported_media_type(uhttpd)
        return false
    end

    return contentType
end


return Validator


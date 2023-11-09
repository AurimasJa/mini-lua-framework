Helper = {}

function Helper.read_request_body(headers)
    local content
    local contentLength = tonumber(headers.CONTENT_LENGTH) or 0

    local requestBody = ""
    if contentLength > 0 then
        -- Read the request body using io library
        local input = io.input():read(contentLength)
        if input then
            requestBody = input
        end
    end
    return requestBody
end
return Helper
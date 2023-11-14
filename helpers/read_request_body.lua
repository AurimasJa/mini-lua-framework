Helper = {}

function Helper.read_request_body(headers)
    local contentLength = tonumber(headers.CONTENT_LENGTH) or 0

    local requestBody = ""
    if contentLength > 0 then
        local input = io.input():read(contentLength)
        if input then
            requestBody = input
        end
    end
    return requestBody
end
return Helper
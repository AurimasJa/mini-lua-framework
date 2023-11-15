local cjson = require("cjson")
local Response = {}
Response.__index = Response

function Response.new()
    local self = {
        status_code = "200 OK",
        headers = { ["Content-Type"] = "text/plain" },
        output = "Successful",
    }
    setmetatable(self, Response)
    return self
end

function Response:with_status(status)
    self.status_code = status
    return self
end

function Response:with_headers(headers)
    for key, value in pairs(headers) do
        self.headers[key] = value
    end
    return self
end

function Response:with_output(output)
    self.output = output
    return self
end

function Response:send()
    uhttpd.send("Status: " .. self.status_code .. " \r\n")
    for key, value in pairs(self.headers) do
        uhttpd.send(string.format("%s: %s\r\n", key, value))
    end
    uhttpd.send("\r\n")
    uhttpd.send(cjson.encode({response = self.output}))
    os.exit()
end

return Response


local contents = {
    ["application/json"] = true,
    ["application/x-www-form-urlencoded"] = true,
    ["multipart/form-data"] = function(contentType)
        return string.match(contentType, "^multipart/form%-data")
    end
}

return contents
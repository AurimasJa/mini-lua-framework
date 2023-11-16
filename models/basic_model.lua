local basic = {}
basic.__index = basic

function basic.new()
    local instance = {}
    setmetatable({},instance)
    
    return basic
end




return basic
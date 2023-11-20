local Validation = {}
Validation.__index = Validation

function Validation.new(data)
    local instance = {
        data = data
    }
    setmetatable(instance, Validation)
    return instance
end

function Validation:validate_all_data(field, validators)
    local splitted_validators = {}
    for val in validators:gmatch("[^|]+") do
        table.insert(splitted_validators, val)
    end

    for _, value in pairs(splitted_validators) do
        if value == "length" then
            if #field > value and type(field) == "string" then return false, "Field is too long" end
        elseif value == "required" then
            if field == "" or field == nil then return false, "Field is required" end
        elseif value == "only_letters" then
            if field:lower():match("%a") then return false, "Field must contain only letters" end
        elseif value == "only_digits" then
            if field:match("%d") then return false, "Field must contain only digits" end
        elseif value == "email" then
            if not field:match("^[%w.+]+@%w+%.%w+$") then return false, "Email address is not correct" end
        end
    end
    return true
end

return Validation

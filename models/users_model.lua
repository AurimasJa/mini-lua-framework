local DB = require("config.config_db")

local Table = require("orm.model")
local fields = require("orm.tools.fields")
local User = Table({
    __tablename__ = "user",
    username = fields.CharField({max_length = 100, unique = true}),
    password = fields.CharField({max_length = 50, unique = true}),
    age = fields.IntegerField({max_length = 2, null = true}),
    city = fields.CharField({max_length = 40, null = true}),
    country = fields.CharField({max_length = 40, null = true}),
    time_create = fields.DateTimeField({null = true})
})

function User.find_by_id(user_id)
    local user = User.get:where({ id = user_id }):first()
    if user ~= nil then
        return true, user
    end
    return false
end

function User.create(data)
    local user = User(data)

    local success, error_message = pcall(function()
        user:save()
    end)
    if not success then
        print("Error during save:", error_message)
    end

    -- Check if the user was successfully saved
    if user ~= nil then
        return true, "user"
    else
        return false, nil
    end
end

return User

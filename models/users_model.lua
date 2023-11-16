local models = {}
local DB = require("config.config_db")

local Table = require("orm.model")
local fields = require("orm.tools.fields")

models.User = Table({
    __tablename__ = "user",
    username = fields.CharField({max_length = 100, unique = true}),
    password = fields.CharField({max_length = 50, unique = true}),
    age = fields.IntegerField({max_length = 2, null = true}),
    city = fields.CharField({max_length = 40, null = true}),
    country = fields.CharField({max_length = 40, null = true}),
    time_create = fields.DateTimeField({null = true})
})

return models

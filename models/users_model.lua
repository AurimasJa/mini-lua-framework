local models = {}
local DB = require("config.config_db")

local Table = require("orm.model")
local fields = require("orm.tools.fields")
local rmodels = require("models.roles_model")
local Role = rmodels.Role

models.User = Table({
    __tablename__ = "users",
    username = fields.CharField({max_length = 100, unique = true}),
    password = fields.CharField({max_length = 50, unique = true}),
    age = fields.IntegerField({max_length = 2, null = true}),
    city = fields.CharField({max_length = 40, null = true}),
    country = fields.CharField({max_length = 40, null = true}),
    time_create = fields.DateTimeField({null = true})
})
models.UserRole = Table({
    __tablename__ = "user_roles",
    user_id = fields.ForeignKey({to = models.User}),
    role_id = fields.ForeignKey({to = Role}),
})
return models

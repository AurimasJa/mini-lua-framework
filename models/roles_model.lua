local models = {}
local DB = require("config.config_db")

local Table = require("orm.model")
local fields = require("orm.tools.fields")
-- local umodels = require("models.users_model")
-- local User = umodels.User

-- models.Role = Table({
--     __tablename__ = "roles",
--     name = fields.CharField({max_length = 100, unique = true})
--     -- user_id = fields.ForeignKey({to = User})
-- })
-- local role1
-- role1 = models.Role({name = "basic"})
-- role1:save()
return models


local PostgreSql = require 'db.postgresql'
local SqlOrm = require 'gin.db.sql.orm'

return SqlOrm.define_model(PostgreSql, 'players')


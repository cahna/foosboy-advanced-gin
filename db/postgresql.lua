local SqlDatabase = require 'gin.db.sql'
local Gin = require 'gin.core.gin'

-- First, specify the environment settings for this database, for instance:
local DbSettings = {
    development = {
        adapter = 'postgresql',
        host = '0.0.0.0',
        port = 5432,
        database = "foosboy_advanced",
        user = "fba_admin",
        password = "foosboy_advanced",
        pool = 5
    }

--     test = {
--     },

--     production = {
--     }
}

-- Then initialize and return your database:
local PostgreSQL = SqlDatabase.new(DbSettings[Gin.env])
return PostgreSQL

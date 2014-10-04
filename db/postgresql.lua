local SqlDatabase = require 'gin.db.sql'
local Gin = require 'gin.core.gin'

-- First, specify the environment settings for this database, for instance:
local DbSettings = {
  development = {
    adapter = 'postgresql',
    host = '0.0.0.0',
    port = 5432,
    database = "foosboy_advanced",
    user = "super",
    password = "foosboy_advanced",
    pool = 5
  },

  test = {
    adapter = 'postgresql',
    host = '0.0.0.0',
    port = 5433,
    database = "foosboy_advanced",
    user = "super",
    password = "foosboy_advanced",
    pool = 5
  },

  drone = {
    adapter = 'postgresql',
    host = '127.0.0.1',
    port = 5432,
    database = "foosboy_advanced",
    user = 'postgres',
    password = "",
    pool = 5
  }

  --     production = {
  --     }
}

-- Then initialize and return your database:
local PostgreSQL = SqlDatabase.new(DbSettings[Gin.env])
return PostgreSQL

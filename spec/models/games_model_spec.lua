require 'spec.spec_helper'

local PostgreSql = require 'db.postgresql'
local Games = require 'app.models.games'

local function clean_db()
  PostgreSql:execute("DELETE FROM games;")
end

describe("Games Model", function()
  after_each(function()
    clean_db()
  end)

  pending("#create a game", function()  end)
end)


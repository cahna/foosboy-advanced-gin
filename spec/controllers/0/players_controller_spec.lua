require 'spec.spec_helper'


local PostgreSql = require 'db.postgresql'
local Players = require 'app.models.players'

local function clean_db()
  PostgreSql:execute("TRUNCATE TABLE players;")
end

describe("PlayersController", function()
  before_each(function()
    clean_db()
  end)

  after_each(function()
    clean_db()
  end)

  describe("#index", function()
    local captain_kirk, mr_spock

    before_each(function()
      captain_kirk = Players.create { player_name = 'Captain Kirk' }
      mr_spock = Players.create { player_name = 'Mr Spock' }
    end)

    after_each(function()
      captain_kirk = nil
      mr_spock = nil
    end)

    it("shows the list of players", function()
      local response = hit({
        method = 'GET',
        path = "/players"
      })

      assert.are.equal(200, response.status)
      assert.are.same({
        [1] = captain_kirk,
        [2] = mr_spock
      }, response.body)
    end)
  end)
  
  describe("#create", function()
    it("adds a new player", function()
      local test_player_name = 'test user'
      local response = hit({
        method = 'POST',
        path = "/players",
        body = { player_name = test_player_name }
      })

      local new_user = Players.find_by({ player_name = test_player_name })
      assert.are_not.equals(nil, new_user)
      assert.are.equal(201, response.status)
      assert.are.same(new_user, response.body)
    end)
  end)
end)


require 'spec.spec_helper'

local PostgreSql = require 'db.postgresql'
local Players = require 'app.models.players'

local function clean_db()
  PostgreSql:execute("TRUNCATE TABLE players;")
end

describe("Players Model", function()
  local test_player_name = 'Captain Kirk'

  before_each(function()
    clean_db()
  end)

  after_each(function()
    clean_db()
  end)

  it("creates a player", function()
    local test_player = Players.create { player_name = test_player_name }
    assert.are.same(test_player_name, test_player.player_name)
    assert.are.same('number', type(test_player.id))

    local fetched_players = PostgreSql:execute 'SELECT * FROM players;'
    assert.are.equal(test_player_name, fetched_players[1].player_name)
    assert.are.equal(test_player.id, fetched_players[1].id)
  end)
  
  it("populates multiple test players", function()
    local player_count = 10
    local test_players = {}
    
    for i=1,player_count do
      table.insert(test_players, Players.create { player_name = test_player_name .. ' ' .. i })
    end
    
    assert.are.same(player_count, #test_players)
  
    local fetched_players = PostgreSql:execute 'SELECT * FROM players;'
    assert.are.equal(player_count, #fetched_players)
  end)

  pending("deletes player by id")
  pending("finds player by player_name")
  pending("selects players with a 'where' constraint")
  pending("deletes players with a 'where' constraint")
  pending("list player details with teams the player belongs to included")
end)


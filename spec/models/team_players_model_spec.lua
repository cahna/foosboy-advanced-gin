require 'spec.spec_helper'

local PostgreSql = require 'db.postgresql'
local TeamPlayers = require 'app.models.team_players'
local Teams = require 'app.models.teams'
local Players = require 'app.models.players'

local function clean_db()
  PostgreSql:execute("DELETE FROM team_players CASCADE;")
  PostgreSql:execute("DELETE FROM teams;")
  PostgreSql:execute("DELETE FROM players;")
end

local function setup_test_data(team_rosters)
  for team_name,roster in pairs(team_rosters) do
    Teams.create { team_name = team_name }
    for i,player_name in ipairs(roster) do
      Players.create { player_name = player_name }
    end
  end
end

describe("Players Model", function()
  local test_team_rosters = { 
    star_trek = { 'Captain Kirk', 'Mr. Spock' },
    nana_batman = { 'Batman', 'Robin' },
    go_west = { 'Louis', 'Clark' },
    one_player = { 'God of Foos' }
  }
  
  before_each(function()
    clean_db()
    setup_test_data(test_team_rosters)
  end)

  after_each(function()
    clean_db()
  end)

  it("hello world", function() 
    assert.is_truthy(true)
  end)

  pending("add players to teams")
  pending("remove players from teams")
end)


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

describe("TeamPlayers (or roster) Model", function()
  after_each(function()
    clean_db()
  end)

  it("can add players to teams", function()
    local team = Teams.create { team_name = 'Dynamic Duo' }
    local players = {
      Players.create { player_name = 'Batman' },
      Players.create { player_name = 'Robin' }
    }
    local rosters = {
      TeamPlayers.create { player_id = players[1].id, team_id = team.id },
      TeamPlayers.create { player_id = players[2].id, team_id = team.id }
    }

    for i,roster in ipairs(rosters) do
      assert.are_same('number', type(roster.id))
      assert.are_same(roster.player_id, players[i].id)
      assert.are_same(roster.team_id, team.id)
    end
  end)

  pending("remove players from teams")
end)


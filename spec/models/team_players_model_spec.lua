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

  it("can add players to teams, but not more than once", function()
    local players = {
      Players.create { player_name = 'Batman' },
      Players.create { player_name = 'Robin' }
    }
    local team = Teams.create { team_name = 'Dynamic Duo' }

    local _roster_spot = { player_id = players[1].id, team_id = team.id } 
    local roster_spot = TeamPlayers.create(_roster_spot)

    assert.are_same(_roster_spot.player_id, roster_spot.player_id)
    assert.are_same(_roster_spot.team_id, roster_spot.team_id)
  end)

  pending("remove players from teams")
end)


require 'spec.spec_helper'


local PostgreSql = require 'db.postgresql'
local Players = require 'app.models.players'
local Teams = require 'app.models.teams'
local TeamPlayers = require 'app.models.team_players'

local function clean_db()
  PostgreSql:execute("DELETE FROM players;")
end

local function add_player_to_team(test_player, test_team)
--  TeamPlayers.create { player_id = test_player.id, team_id = test_team.id } 
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
    it("adds a new player filtering out unaccepted params", function()
      local test_player_name = 'test user'
      local response = hit({
        method = 'POST',
        path = "/players",
        body = { 
          player_name = test_player_name, 
          id = 123, 
          nonexistent_param = 'non-existent' 
        }
      })

      local new_player = Players.find_by({ player_name = test_player_name })
      assert.are_not.equals(nil, new_player)
      assert.are.equal(201, response.status)
      assert.are.same(new_player, response.body)
      assert.are.not_equals(123, new_player.id)
      assert.are.not_equals('non-existent', new_player.nonexistent_param)
    end)
  end)
 
  describe("#update", function()
    local test_player
    local test_team

    before_each(function()
      test_player = Players.create { player_name = 'test player' }
      team_team = Teams.create { team_name = 'test team' }
    end)

    after_each(function()
      test_player = nil
    end)
      
    it("adds a player to a team", function()
      local test_player_name = 'test user'
      local response = hit({
        method = 'PATCH',
        path = "/players/" .. test_player.id,
        body = { 
          team_id = test_team.id
        }
      })

      assert.are.equal(201, response.status)

      local new_roster_spot = TeamPlayers.find_by({ player_id = test_player.id, team_id = test_team.id })

      assert(new_roster_spot)
    end)
  end)

  describe("#show", function()
    local test_player
    local test_team

    before_each(function()
      test_player = Players.create { player_name = 'test player' }
      team_team = Teams.create { team_name = 'test team' }
    end)

    after_each(function()
      test_player = nil
    end)

    describe("when the player can be found", function()
      it("shows a player", function()
        local response = hit({
          method = 'GET',
          path = "/players/" .. test_player.id
        })

        assert.are.equal(200, response.status)
        assert.are.same(test_player.player_name, response.body.player_name)
        assert.are.same(test_player.id, response.body.id)
      end)
    end)

    describe("when showing a player with ?fetch=recursive", function()
      local test_player
      local test_team

      before_each(function()
        test_player = Players.create { player_name = 'test player' }
        team_team = Teams.create { team_name = 'test team' }
      end)

      after_each(function()
        test_player = nil
      end)

      it("fetches an empty list of teams for the player with ?fetch=recursive", function()
        local response = hit({
          method = 'GET',
          path = "/players/" .. test_player.id,
          uri_params = { fetch = "recursive" }
        })

        assert.are.equal(200, response.status)
        assert.are.same({}, response.body.teams)
      end)

      describe("when the player belongs to one or more teams", function()
        before_each(function()
          add_player_to_team(test_player, test_team)
        end)

        it("fetches a list of teams for the player with ?fetch=recursive", function()
          local response = hit({
            method = 'GET',
            path = "/players/" .. test_player.id,
            uri_params = { fetch = "recursive" }
          })

          assert.are.equal(200, response.status)
          assert.is_true(#response.body.teams > 0)
        end)
      end)
    end)
    
    describe("when the player cannot be found", function()
      it("shows a player", function()
        local response = hit({
          method = 'GET',
          path = "/players/123"
        })

        assert.are.equal(404, response.status)
        assert.are.same({}, response.body)
      end)
    end)
  end)
end)


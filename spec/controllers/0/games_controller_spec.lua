require 'spec.spec_helper'

local PostgreSql = require 'db.postgresql'
local Games = require 'app.models.games'

local function clean_db()
  PostgreSql:execute("DELETE FROM games;")
end

describe("GamesController", function()
  after_each(function()
    clean_db()
  end)

  describe("#index", function()
    local test_winning_team, test_losing_team
      
    before(function()
      test_winning_team = Teams.create { team_name = 'Test Winning Team' }
      test_losing_team = Teams.create { losing_name = 'Test Losing Team' }
    end)

    it("successfully records the result of a game between 2 teams", function()
      local response = hit({
        method = 'POST',
        path = "/games",
        body = {
          winning_team_id = test_winning_team.id,
          winning_team_score = 3,
          losing_team_id = test_losing_team.id,
          losing_team_score = 3
        }
      })

      assert.are.equal(200, response.status)
    end)

--    it("shows the list of games", function()
--      local response = hit({
--        method = 'GET',
--        path = "/games"
--      })
--
--      assert.are.equal(200, response.status)
--
--      assert.are.same(test_game1.game_name, response.body[1].game_name)
--      assert.are.same(test_game2.game_name, response.body[2].game_name)
--      assert(response.body[1].date_created)
--      assert(response.body[2].date_created)
--      assert(response.body[1].id)
--      assert(response.body[2].id)
--    end)
--  end)
--  
--  describe("#create", function()
--    it("adds a new game filtering out unaccepted params", function()
--      local test_game_name = 'test game name'
--      local response = hit({
--        method = 'POST',
--        path = "/games",
--        body = { 
--          game_name = test_game_name, 
--          id = 123, 
--          nonexistent_param = 'non-existent' 
--        }
--      })
--
--      local new_game = Games.find_by({ game_name = test_game_name })
--      assert.are_not.equals(nil, new_game)
--      assert.are.equal(201, response.status)
--      assert.are.same(new_game.game_name, response.body.game_name)
--      assert.are.not_equals(123, new_game.id)
--      assert.are.not_equals('non-existent', new_game.nonexistent_param)
--    end)
--  end)
--  
--  describe("#show", function()
--    describe("when the game can be found", function()
--      local test_game
--
--      before_each(function()
--        test_game = Games.create { game_name = 'test game' }
--      end)
--
--      after_each(function()
--        test_game = nil
--      end)
--
--      it("shows a game", function()
--        local response = hit({
--          method = 'GET',
--          path = "/games/" .. test_game.id
--        })
--
--        assert.are.equal(200, response.status)
--        assert.are.same(test_game.game_name, response.body.game_name)
--        assert.are.same(test_game.id, response.body.id)
--        assert(response.body.date_created)
--      end)
--    end)
--    
--    describe("when the game cannot be found", function()
--      it("shows a game", function()
--        local response = hit({
--          method = 'GET',
--          path = "/games/123"
--        })
--
--        assert.are.equal(404, response.status)
--        assert.are.same({}, response.body)
--      end)
--    end)
  end)
end)


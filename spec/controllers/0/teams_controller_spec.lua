require 'spec.spec_helper'


local PostgreSql = require 'db.postgresql'
local Teams = require 'app.models.teams'

local function clean_db()
  PostgreSql:execute("TRUNCATE TABLE teams;")
end

describe("TeamsController", function()
  before_each(function()
    clean_db()
  end)

  after_each(function()
    clean_db()
  end)

  describe("#index", function()
    local captain_kirk, mr_spock

    before_each(function()
      test_team1 = Teams.create { team_name = 'Captain Kirks Team' }
      test_team2 = Teams.create { team_name = 'Mr Spocks Team' }
    end)

    after_each(function()
      test_team1 = nil
      teat_team2 = nil
    end)

    it("shows the list of teams", function()
      local response = hit({
        method = 'GET',
        path = "/teams"
      })

      assert.are.equal(200, response.status)

      assert.are.same(test_team1.team_name, response.body[1].team_name)
      assert.are.same(test_team2.team_name, response.body[2].team_name)
      assert(response.body[1].date_created)
      assert(response.body[2].date_created)
      assert(response.body[1].id)
      assert(response.body[2].id)
    end)
  end)
  
  describe("#create", function()
    it("adds a new team filtering out unaccepted params", function()
      local test_team_name = 'test team name'
      local response = hit({
        method = 'POST',
        path = "/teams",
        body = { 
          team_name = test_team_name, 
          id = 123, 
          nonexistent_param = 'non-existent' 
        }
      })

      local new_team = Teams.find_by({ team_name = test_team_name })
      assert.are_not.equals(nil, new_team)
      assert.are.equal(201, response.status)
      assert.are.same(new_team.team_name, response.body.team_name)
      assert.are.not_equals(123, new_team.id)
      assert.are.not_equals('non-existent', new_team.nonexistent_param)
    end)
  end)
  
  describe("#show", function()
    describe("when the team can be found", function()
      local test_team

      before_each(function()
        test_team = Teams.create { team_name = 'test team' }
      end)

      after_each(function()
        test_team = nil
      end)

      it("shows a team", function()
        local response = hit({
          method = 'GET',
          path = "/teams/" .. test_team.id
        })

        assert.are.equal(200, response.status)
        assert.are.same(test_team.team_name, response.body.team_name)
        assert.are.same(test_team.id, response.body.id)
        assert(response.body.date_created)
      end)
    end)
    
    describe("when the team cannot be found", function()
      it("shows a team", function()
        local response = hit({
          method = 'GET',
          path = "/teams/123"
        })

        assert.are.equal(404, response.status)
        assert.are.same({}, response.body)
      end)
    end)
  end)
end)


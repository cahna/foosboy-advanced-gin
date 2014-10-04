require 'spec.spec_helper'

local PostgreSql = require 'db.postgresql'
local Teams = require 'app.models.teams'

local function clean_db()
  PostgreSql:execute("DELETE FROM teams;")
end

describe("Teams Model", function()
  local test_team_name = 'The A Team'

  after_each(function()
    clean_db()
  end)

  it("creates a team", function()
    local test_team = Teams.create { team_name = test_team_name }
    assert.are.same(test_team_name, test_team.team_name)
    assert.are.same('number', type(test_team.id))

    local fetched_teams = PostgreSql:execute 'SELECT * FROM teams;'
    assert.are.equal(test_team_name, fetched_teams[1].team_name)
    assert.are.equal(test_team.id, fetched_teams[1].id)
  end)
  
  it("populates multiple test teams", function()
    local team_count = 10
    local test_teams = {}
    
    for i=1,team_count do
      table.insert(test_teams, Teams.create { team_name = test_team_name .. ' ' .. i })
    end
    
    assert.are.same(team_count, #test_teams)
  
    local fetched_teams = PostgreSql:execute 'SELECT * FROM teams;'
    assert.are.equal(team_count, #fetched_teams)
  end)

  pending("deletes team by id")
  pending("finds team by team_name")
  pending("selects teams with a 'where' constraint")
  pending("deletes teams with a 'where' constraint")
  pending("list team details with teams the team belongs to included")
end)


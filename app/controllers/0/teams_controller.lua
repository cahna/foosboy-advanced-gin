
local TeamsController = {}

function TeamsController:index()
  local Teams = require 'app.models.teams'
  local all_teams = Teams.all()

  return 200, all_teams
end

function TeamsController:create()
  local Teams = require 'app.models.teams'
  local params = self:accepted_params({ 'team_name' }, self.request.body)
  local new_team = Teams.create(params)

  return 201, new_team
end

function TeamsController:view()
  local Teams = require 'app.models.teams'
  local params = self:accepted_params({ 'team_id' }, self.params)
  local team = Teams.find_by { id = params.team_id }

  if team then
    return 200, team
  end

  return 404
end

return TeamsController


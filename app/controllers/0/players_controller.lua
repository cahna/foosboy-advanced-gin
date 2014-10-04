
local PlayersController = {}

function PlayersController:index()
  local Players = require 'app.models.players'
  
  local all_players = Players.all()

  return 200, all_players
end

function PlayersController:create()
  local Players = require 'app.models.players'
  
  local body = self:accepted_params({ 'player_name' }, self.request.body)
  local new_player = Players.create(body)

  return 201, new_player
end

function PlayersController:view()
  local Players = require 'app.models.players'

  local params = self:accepted_params({ 'player_id' }, self.params)
  local uri_params = self:accepted_params({ 'fetch' }, self.request.uri_params)
  local player

  if uri_params.fetch == 'recursive' then
    player = Players.by_id_recursive(params.player_id)
  else
    player = Players.find_by { id = params.player_id }
  end
  
  if player then
    return 200, player
  end

  return 404
end

function PlayersController:update()
  local Players = require 'app.models.players'
  local Teams = require 'app.models.teams'
  local TeamPlayers = require 'app.models.team_players'

  local body = self:accepted_params({ 'team_id' }, self.request.body)
  local params = self:accepted_params({ 'player_id' }, self.params)

  local player = Players.find_by { id = params.player_id }

  if player then
    local team = Teams.find_by { id = body.team_id }
    if team then
      local roster_spot = TeamPlayers.find_by { team_id = body.team_id, player_id = params.player_id }
      if roster_spot then  
        player.teams = { team.id }
        return 302, player
      end

      roster_spot = TeamPlayers.create { team_id = body.team_id, player_id = params.player_id }
      if roster_spot then
        player.teams = { team.id }
        return 200, player
      end
    end
  end
  
  return 404
end

return PlayersController


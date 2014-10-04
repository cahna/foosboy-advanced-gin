
local PlayersController = {}

function PlayersController:index()
  local Players = require 'app.models.players'
  
  local all_players = Players.all()

  return 200, all_players
end

function PlayersController:create()
  local Players = require 'app.models.players'
  
  local params = self:accepted_params({ 'player_name' }, self.request.body)
  local new_player = Players.create(params)

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

return PlayersController


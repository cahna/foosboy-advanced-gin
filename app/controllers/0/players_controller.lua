
local PlayersController = {}

function PlayersController:index()
  local Players = require 'app.models.players'
  local all_players = Players.all()

  return 200, all_players
end

function PlayersController:create()
  local Players = require 'app.models.players'
  local new_player = Players.create(self.request.body)
  return 201, new_player
end

return PlayersController



local PlayersController = {}

function PlayersController:index()
  local Players = require 'app.models.players'
  local all_players = Players.all()

  return 200, all_players
end

return PlayersController


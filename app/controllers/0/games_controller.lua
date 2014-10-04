
local GamesController = {}

function GamesController:index()
  local Games = require 'app.models.games'
  local all_games = Games.all()
  return 200, all_games
end

function GamesController:create()
  local Games = require 'app.models.games'
  local filter_only = { 
    'winning_team_id', 
    'winning_team_score',
    'losing_team_id',
    'losing_team_score'
  }
  local body = self:accepted_params(filter_only, self.request.body)
  local new_game = Games.create(body)

  return 201, new_game
end

function GamesController:view()
  local Games = require 'app.models.games'
  local params = self:accepted_params({ 'game_id' }, self.params)
  local game = Games.find_by { id = params.game_id }

  if game then
    return 200, game
  end

  return 404
end

return GamesController



local PostgreSql = require 'db.postgresql'
local SqlOrm = require 'gin.db.sql.orm'

local PlayersORM = SqlOrm.define_model(PostgreSql, 'players')

function PlayersORM.by_id_recursive(player_id)
  local player = PlayersORM.find_by({ id = player_id })

  assert(player, 'failed to find player by id')

  -- TODO: Get this from package.loaded? Good idea?
  local TeamPlayersORM = require 'app.models.team_players'
  local team_list = TeamPlayersORM.find_by({ player_id = player.id })

  player.teams = team_list and team_list or {}

  return player
end

return PlayersORM


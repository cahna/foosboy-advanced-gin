
local PostgreSql = require 'db.postgresql'
local SqlOrm = require 'gin.db.sql.orm'

local PlayersORM = SqlOrm.define_model(PostgreSql, 'players')

function PlayersORM:by_id_recursive(player_id)
  local player = self.find_by({ id = player_id })

  -- TODO: Get this from package.loaded? Good idea?
  local TeamPlayersORM = require 'app.models.team_players'
  local team_ids = TeamsORM.find_by({ player_id = player.id })
  
end

return PlayersORM


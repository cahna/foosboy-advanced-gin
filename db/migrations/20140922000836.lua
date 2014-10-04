local SqlMigration = {}

-- specify the database used in this migration (needed by the Gin migration engine)
SqlMigration.db = require 'db.postgresql'

function SqlMigration.up()
    SqlMigration.db:execute([[
      CREATE TABLE players (
        id SERIAL PRIMARY KEY,
        player_name varchar(64) NOT NULL,
        UNIQUE (player_name)
      );
    ]])
      
    SqlMigration.db:execute([[
      CREATE TABLE teams (
        id SERIAL PRIMARY KEY,
        team_name VARCHAR(64) NOT NULL,
        date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (team_name)
      );
    ]])
      
    SqlMigration.db:execute([[
      CREATE TABLE team_players (
        team_id INTEGER references teams(id),
        player_id INTEGER references players(id),
        CONSTRAINT team_id_player_id PRIMARY KEY (team_id, player_id)
      );
    ]])
end

function SqlMigration.down()
    SqlMigration.db:execute("DROP TABLE team_players CASCADE;")
    SqlMigration.db:execute("DROP TABLE teams;")
    SqlMigration.db:execute("DROP TABLE players;")
end

return SqlMigration

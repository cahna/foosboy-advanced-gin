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
        id SERIAL PRIMARY KEY,
        team_id INTEGER references teams(id),
        player_id INTEGER references players(id),
        CONSTRAINT team_id_player_id UNIQUE (team_id, player_id)
      );
    ]])
    
    SqlMigration.db:execute([[
      CREATE TABLE games  (
        id SERIAL PRIMARY KEY,
        winning_team_id INTEGER references teams(id),
        winning_team_score INTEGER NOT NULL,
        losing_team_id INTEGER references teams(id),
        losing_team_score INTEGER NOT NULL DEFAULT 0,
        date_played TIMESTAMP DEFAULT now(),
        CONSTRAINT teams_must_be_different CHECK (winning_team_id <> losing_team_id),
        CONSTRAINT winner_has_highest_score CHECK (winning_team_score > losing_team_score)
      );
    ]])
end

function SqlMigration.down()
    SqlMigration.db:execute("DROP TABLE team_players CASCADE;")
    SqlMigration.db:execute("DROP TABLE games CASCADE;")
    SqlMigration.db:execute("DROP TABLE teams;")
    SqlMigration.db:execute("DROP TABLE players;")
end

return SqlMigration

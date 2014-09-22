local SqlMigration = {}

-- specify the database used in this migration (needed by the Gin migration engine)
SqlMigration.db = require 'db.postgresql'

function SqlMigration.up()
    -- Run your migration
    SqlMigration.db:execute([[
      CREATE TABLE players (
        id SERIAL PRIMARY KEY,
        player_name varchar(64) NOT NULL,
        UNIQUE (player_name)
      );
    ]])
end

function SqlMigration.down()
    -- Run your rollback
    SqlMigration.db:execute([[
      DROP TABLE players;
    ]])
end

return SqlMigration

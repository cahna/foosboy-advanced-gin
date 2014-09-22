local SqlMigration = {}

-- specify the database used in this migration (needed by the Gin migration engine)
SqlMigration.db = require 'db.postgresql'

function SqlMigration.up()
    -- Run your migration
    SqlMigration.db:execute([[
      CREATE TABLE teams (
        id SERIAL PRIMARY KEY,
        team_name VARCHAR(64) NOT NULL,
        date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (team_name)
      );
    ]])
end

function SqlMigration.down()
    -- Run your rollback
    SqlMigration.db:execute([[
      DROP TABLE teams;
    ]])
end

return SqlMigration

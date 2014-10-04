{
  {
    players = {
      {
        numeric_precision = 32,
        is_nullable = "NO",
        column_name = "id",
        data_type = "integer",
        column_default = "nextval('players_id_seq'::regclass)"
      },
      {
        is_nullable = "NO",
        column_name = "player_name",
        character_maximum_length = 64,
        data_type = "character varying"
      }
    }
  },
  {
    team_players = {
      {
        numeric_precision = 32,
        is_nullable = "NO",
        column_name = "id",
        data_type = "integer",
        column_default = "nextval('team_players_id_seq'::regclass)"
      },
      {
        is_nullable = "YES",
        column_name = "team_id",
        data_type = "integer",
        numeric_precision = 32
      },
      {
        is_nullable = "YES",
        column_name = "player_id",
        data_type = "integer",
        numeric_precision = 32
      }
    }
  },
  {
    teams = {
      {
        numeric_precision = 32,
        is_nullable = "NO",
        column_name = "id",
        data_type = "integer",
        column_default = "nextval('teams_id_seq'::regclass)"
      },
      {
        is_nullable = "NO",
        column_name = "team_name",
        character_maximum_length = 64,
        data_type = "character varying"
      },
      {
        datetime_precision = 6,
        is_nullable = "YES",
        column_name = "date_created",
        data_type = "timestamp without time zone",
        column_default = "now()"
      }
    }
  },
  {
    games = {
      {
        numeric_precision = 32,
        is_nullable = "NO",
        column_name = "id",
        data_type = "integer",
        column_default = "nextval('games_id_seq'::regclass)"
      },
      {
        is_nullable = "YES",
        column_name = "winning_team_id",
        data_type = "integer",
        numeric_precision = 32
      },
      {
        is_nullable = "NO",
        column_name = "winning_team_score",
        data_type = "integer",
        numeric_precision = 32
      },
      {
        is_nullable = "YES",
        column_name = "losing_team_id",
        data_type = "integer",
        numeric_precision = 32
      },
      {
        numeric_precision = 32,
        is_nullable = "NO",
        column_name = "losing_team_score",
        data_type = "integer",
        column_default = "0"
      },
      {
        datetime_precision = 6,
        is_nullable = "YES",
        column_name = "date_played",
        data_type = "timestamp without time zone",
        column_default = "now()"
      }
    }
  }
}
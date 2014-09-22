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
  }
}
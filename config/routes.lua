local routes = require 'gin.core.routes'

-- define version
local v0 = routes.version(0)

-- define routes
v0:GET   ("/",                    {  controller  =  "pages",    action  =  "root"    })
v0:GET   ("/players",             {  controller  =  "players",  action  =  "index"   })
v0:POST  ("/players",             {  controller  =  "players",  action  =  "create"  })
v0:GET   ("/players/:player_id",  {  controller  =  "players",  action  =  "view"    })
v0:PATCH ("/players/:player_id",  {  controller  =  "players",  action  =  "update"  })
v0:GET   ("/teams",               {  controller  =  "teams",    action  =  "index"   })
v0:POST  ("/teams",               {  controller  =  "teams",    action  =  "create"  })
v0:GET   ("/teams/:team_id",      {  controller  =  "teams",    action  =  "view"    })
v0:GET   ("/games",               {  controller  =  "games",    action  =  "index"   })
v0:POST  ("/games",               {  controller  =  "games",    action  =  "create"  })
v0:GET   ("/games/:game_id",      {  controller  =  "games",    action  =  "view"    })

return routes

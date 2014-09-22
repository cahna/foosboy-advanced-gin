local routes = require 'gin.core.routes'

-- define version
local v0 = routes.version(0)

-- define routes
v0:GET   ("/",                    {  controller  =  "pages",    action  =  "root"    })
v0:GET   ("/players",             {  controller  =  "players",  action  =  "index"   })
v0:POST  ("/players",             {  controller  =  "players",  action  =  "create"  })
v0:GET   ("/players/:player_id",  {  controller  =  "players",  action  =  "view"    })

return routes

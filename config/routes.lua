local routes = require 'gin.core.routes'

-- define version
local v1 = routes.version(1)

-- define routes
v1:GET("/", { controller = "pages", action = "root" })

return routes

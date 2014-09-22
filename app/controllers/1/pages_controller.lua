local PagesController = {}

function PagesController:root()
    return 200, { message = "Hello world from Gin!" }
end

return PagesController

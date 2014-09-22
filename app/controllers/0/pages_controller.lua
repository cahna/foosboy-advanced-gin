local PagesController = {}

function PagesController:root()
    return 200, { message = "Hello world from Foosboy Advanced!" }
end

return PagesController

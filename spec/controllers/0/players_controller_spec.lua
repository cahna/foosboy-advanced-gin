require 'spec.spec_helper'

describe("PlayersController", function()
    describe("#index", function()
        it("shows the list of players", function()
            local response = hit({
                method = 'GET',
                path = "/players"
            })

            assert.are.equal(200, response.status)
            assert.are.same({}, response.body)
        end)
    end)
end)


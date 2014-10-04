
foosboy-advanced-gin
====================

Foosboy Advanced - Foosball statistics tracking worthless-micro-service built with Lua, openresty, and Gin.io

[![Build Status](https://drone.io/github.com/cahna/foosboy-advanced-gin/status.png)](https://drone.io/github.com/cahna/foosboy-advanced-gin/latest)

## TODO

- [ ] Domain model
    - [ ] TeamPlayers
        - [X] Add player to team
        - [ ] Remove player from team (No need for now)
    - [ ] Teams
        - [ ] ?fetch=recursive fetches the players (or just player_ids) for a team (No need for now)
    - [ ] Games
        - [ ] Model: winning team, losing team, max score, winning team score, losing team score
        - [ ] Tests
        - [ ] Controller
    - [ ] Series
        - [ ] Model: 
        - [ ] Tests
        - [ ] Controller
    - [ ] Users
        - [ ] Model/Controller/Tests
        - [ ] User can register with email and password
        - [ ] User account can be tied to one - and only one - player_id to track performance
        - [ ] User account is tied to a Google/GitHub/OtherOAuth-implemented site
        - [ ] Implement security?

## Development

1. Update `apiary.apib` with any API changes that need to be implemented.
2. Write tests to cover feature/update. Run them against the apiary.io mock server with your changes. They should pass.
3. Run tests locally. They should fail.
4. Write code to pass local tests (hopefully without needed to change test code). Refactor as needed once tests are passing.
5. Commit to a new feature branch, push, and submit pull-request.


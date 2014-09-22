foosboy-advanced-gin
====================

Foosboy Advanced - Foosball statistics tracking worthless-micro-service built with Lua, openresty, and Gin.io

## Development

This is simply an outline of the workflow I've chosen to try out for this project as an experiment:

1. Update `apiary.apib` with _any_ API changes that need to be implemented.

2. Write tests to cover feature/update. Run them against the apiary.io mock server with your changes. They should pass.

3. Run tests locally. They should fail.

4. Write code to pass local tests (hopefully without needed to change test code). Refactor as needed once tests are passing.

5. Commit and push to kickoff CI pipeline. Wait to commit anything new until CI build/test/deploy succeeds.


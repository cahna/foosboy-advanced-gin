-------------------------------------------------------------------------------------------------------------------
-- Define all of your application errors in here. They should have the format:
--
-- local Errors = {
--     [1000] = { status = 400, message = "My Application error.", headers = { ["X-Header"] = "header" } },
-- }
--
-- where:
--     '1000'                is the error number that can be raised from controllers with `self:raise_error(1000)
--     'status'  (required)  is the http status code
--     'message' (required)  is the error description
--     'headers' (optional)  are the headers to be returned in the response
-------------------------------------------------------------------------------------------------------------------

local Errors = {
  -- Controller errors 1000-1999
  [1000] = { status = 400, message = "Foosboy Advanced application error." },
  [1401] = { status = 401, message = 'Unauthorized.' },
  [1403] = { status = 403, message = 'Forbidden.' },
  [1404] = { status = 404, message = 'Not Found.' },
  [1500] = { status = 500, message = 'Server Error.' }
}

return Errors

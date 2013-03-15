-- sample code to check username/password and get some information of the user
-- sessions_controller#auth is the related rails method

-- tries to authenticate the user with the given username/password and calls
-- the function fn() with either the user data if successful, or nil if not
local url = 'http://localhost:3000/mta-auth.json'
function authenticate(username, password, fn)
  callRemote(url,
    function(result)
      fn(result ~= 'ERROR' and result or nil)
    end,
    username, password
  )
end

addCommandHandler('auth',
  function(player, command, username, password)
    -- check the username and password given
    authenticate(username, password, function(user)
      -- successfully logged in?
      if user then
        -- dump all variables we got (id, name and admin level for example)
        outputDebugString('Got user:')
        for k, v in pairs(user) do
          outputDebugString('  ' .. tostring(k) .. ' = ' .. tostring(v))
        end
      else
        outputDebugString('No successful login')
      end
    end)
  end
)

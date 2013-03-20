-- example code to show some blog posts, namely the same as if you'd visit the according website
local url = 'http://localhost:3000/blog.mta'
addCommandHandler('blog',
  function()
    callRemote(url,
      function(result)
        if result ~= 'ERROR' then
          for k, v in ipairs(result) do
            outputDebugString(v.user.name .. ' on ' .. v.created_at:gsub('T', ' '):gsub('Z', '') .. ': ' .. v.title)
          end
        else
          outputDebugString('Failed to retrieve blog posts', 2)
        end
      end,
      nil, -- don't use any actual parameters
      {method = 'GET'}
    )
  end
)
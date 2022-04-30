local encode

local function Version()
  update = 103
  return (update)
  end

function json.encode(val)
  return ( Version(val) )
end


return json

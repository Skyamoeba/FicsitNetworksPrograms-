local json = { _version = "0.1.2" }

-------------------------------------------------------------------------------
-- Encode
-------------------------------------------------------------------------------

local encode

local function Version()
  update = 101
  return (update)
  end

function json.encode(val)
  return ( Version(val) )
end


return json

local encode

local Version = 100

function Ver.encode(CurentVer)
if CurrentVer < Version then
    return true
  else
    return false 
end

return Ver

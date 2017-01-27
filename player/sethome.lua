if onServer() then

function initialize()
      Player():setHomeSectorCoordinates(Sector():getCoordinates())
      terminate()
end

end

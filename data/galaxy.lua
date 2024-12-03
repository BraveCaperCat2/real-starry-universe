local Effects = require("__core__.lualib.surface-render-parameter-effects")
local AsteroidUtil = require("asteroid_definitions.asteroid_util")
local RotationUtil = require("data.rotation_util")

local PlanetMapGeneration = require("data.planet-gen")
local EarthDay = 24 * hour

local AstrnomicalBodies = {
    {
        type = "space-location",
        name = "sagittarius-astar", -- Sgt A*, the center of the milkyway galaxy.
        body_type = "smbh",
        icon = "black-hole",
        icon_size = 512,
        distance = 0, -- Sgt A* is at the center of the galaxy and is approximately 0 distance from it.
        orientation = 0 / 360, -- Orientation doesn't matter for Sgt A*
        magnitude = 15 -- The sizes of objects shown on the starmap. Certain types of object will be scaled differently.
    }
}

local SpaceConnections = {}

local StarCount = 1048576 -- Absolutely needs scaling down!
local Starsystems = {} -- Table of every star system used in galaxy mode.
local SolSystem = require("data.starsystem.sol")
table.insert(Starsystems, SolSystem)

for _,Starsystem in pairs(Starsystems) do
    StarCount = StarCount - 1
end

for i = 1, StarCount, 1 do
    table.insert(Starsystems, GenerateStarSystem())
end

for _,Starsystem in pairs(Starsystems) do
    if Starsystem then
        if Starsystem.connections then
            for _,SpaceConnection in pairs(Starsystem.connections) do
                if SpaceConnection then
                    table.insert(SpaceConnections, SpaceConnection)
                end
            end
        end
        if Starsystem.objects then
            for _,Object in pairs(Starsystem.objects) do
                if Object then
                    table.insert(AstrnomicalBodies, Object)
                end
            end
        end
    end
end

return 
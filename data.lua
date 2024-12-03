local function config(name)
    return settings.startup["rsu_" .. name]
end

local Data = {}

if config("galaxy-mode") then
    Data = require("data.galaxy")
else
    Data = require("data.starsystem.sol")
end

-- require("test.runall") -- Testing for all custom functions.
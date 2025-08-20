local placeholder_png = "__real-starry-universe__/graphics/planet.png"


local planet_technologies = {}
-- local PlanetTechnologies = {
--     { "sol", "太阳轨道", { "planet-discovery-mercury", "space-platform-thruster" }, true },
--     { "mercury", "水星", { "planet-discovery-venus", "space-platform-thruster" }, false },
--     { "venus", "金星", { "planet-discovery-luna", "space-platform-thruster" }, false },
--     { "earth", "地球", { "space-platform-thruster" }, false },
--     { "luna", "月球", { "planet-discovery-earth", "space-platform-thruster" }, false },
--     { "mars", "火星", { "planet-discovery-luna", "space-platform-thruster" }, false },
--     { "phobos", "火卫一", { "planet-discovery-mars", "space-platform-thruster" }, true },
--     { "deimos", "火卫二", { "planet-discovery-mars", "space-platform-thruster" }, true },
--     { "asteroid-belt-inner", "内小行星带", { "planet-discovery-mars", "space-platform-thruster" }, false },
--     { "jupiter", "木星", { "planet-discovery-asteroid-belt-inner", "space-platform-thruster" }, false },
--     { "saturn", "土星", { "planet-discovery-jupiter", "space-platform-thruster" }, false },
--     { "uranus", "天王星", { "planet-discovery-saturn", "space-platform-thruster" }, false },
--     { "neptune", "海王星", { "planet-discovery-uranus", "space-platform-thruster" }, false },
--     { "pluto", "冥王星", { "planet-discovery-neptune", "space-platform-thruster" }, false },
--     { "asteroid-belt-outer", "柯伊伯带", { "planet-discovery-pluto", "space-platform-thruster" }, false }
-- }

-- Reconstruct the planets array from planet.lua.
local planets = {}

for _, planet in pairs(data.raw["planet"]) do
    if planet.mod == "rsu" then
        table.insert(planets, planet)
    end
end
for _, space_location in pairs(data.raw["space-location"]) do
    if space_location.mod == "rsu" then
        table.insert(planets, space_location)
    end
end

-- Complex barycenter logic to determine if an object is part of a binary, trinary, etc. system and make a technology to unlock all objects in that system.
for i, planet in pairs(planets) do
    if planet then
        if planet.object_properties then
            if planet.object_properties.type == "barycenter" then
                local barycenter_objects = {}
                local has_edge = false
                local barycenter_edge
                for j, object in pairs(planets) do
                    if object then
                        if object.object_properties then
                            if object.object_properties.parent_object == planet.name then
                                if object.object_properties.type == "edge" then
                                    has_edge = true
                                    barycenter_edge = object
                                end
                                object.index_temp = j -- Used to allow soft removal of the object from the planets array.
                                table.insert(barycenter_objects, table.deepcopy(object))
                            end
                        end
                    end
                end
                local effects = {{
                    type = "unlock-space-location",
                    space_location = planet.name,
                    use_icon_overlay_constant = false,
                    hidden = true
                }}
                local icons = {}
                local edge_found = false
                local prerequisites = {"space-platform-thruster"}

                local object_count = table_size(barycenter_objects)
                if has_edge then
                    object_count = object_count - 1
                end

                if object_count < 2 then
                    error("Multi-object system \"" .. planet.name .. "-system" .. "\" contains less than 2 objects!")
                end

                local locales = {"technology-description.barycenter-discovery-fallback-" .. object_count, {"", {"space-location-name." .. planet.name}, {"rsu-object-type-name." .. planet.object_properties.barycenter_type}, "rsu-object-type-name.followup-word"}}

                for j = 1, 4, 1 do
                    ::restart::
                    local object_index
                    if edge_found then
                        object_index = j + 1
                    else
                        object_index = j
                    end

                    if object_index > object_count then
                        break
                    end

                    local object = barycenter_objects[object_index]
                    if object then
                        if object.object_properties.type == "edge" then
                            edge_found = true
                            goto restart
                        end

                        local object_id
                        if edge_found then
                            object_id = j - 1
                        else
                            object_id = j
                        end

                        if object_count == 2 then
                            table.insert(icons, {
                                icon = object.icon,
                                icon_size = object.icon_size or 512,
                                scale = 1 / ( ( object.icon_size or 512 ) / (64 * 0.33300000000000001) ),
                                shift = {
                                    -- x = 6 * math.pow( -1, object_id ),
                                    -- y = 6 * math.pow( -1, object_id )
                                    x = 6 * math.pow( -1, j ),
                                    y = 6 * math.pow( -1, j )
                                }
                            })
                        elseif object_count == 3 then
                            local shift = {}
                            -- if object_id == 0 then
                            if j == 1 then
                                shift = {
                                    x = 0,
                                    y = -6,
                                }
                            -- elseif object_id == 1 then
                            elseif j == 2 then
                                shift = {
                                    x = 6,
                                    y = 6
                                }
                            -- elseif object_id == 2 then
                            elseif j == 3 then
                                shift = {
                                    x = -6,
                                    y = 6
                                }
                            end
                            table.insert(icons, {
                                icon = object.icon,
                                icon_size = object.icon_size or 512,
                                scale = 1 / ( ( object.icon_size or 512 ) / (64 * 0.33300000000000001) ),
                                shift = shift
                            })
                        elseif object_count == 4 then
                            local shift = {}
                            -- if object_id == 0 then
                            if j == 1 then
                                shift = {
                                    x = -6,
                                    y = -6
                                }
                            -- elseif object_id == 1 then
                            elseif j == 2 then
                                shift = {
                                    x = 6,
                                    y = -6
                                }
                            -- elseif object_id == 2 then
                            elseif j == 3 then
                                shift = {
                                    x = 6,
                                    y = 6
                                }
                            -- elseif object_id == 3 then
                            elseif j == 4 then
                                shift = {
                                    x = -6,
                                    y = 6
                                }
                            end
                            table.insert(icons, {
                                icon = object.icon,
                                icon_size = object.icon_size or 512,
                                scale = 1 / ( ( object.icon_size or 512 ) / (64 * 0.33300000000000001) ),
                                shift = shift
                            })
                        end
                        table.insert(effects, {
                                type = "unlock-space-location",
                                space_location = object.name,
                                use_icon_overlay_constant = false
                        })
                        table.insert(locales, {"space-location-name." .. object.name})
                    end
                end

                for _, barycenter_object in pairs(barycenter_objects) do
                    table.remove(planets, barycenter_object.index_temp)
                end

                table.remove(planets, i)

                table.insert(icons, {
                    scale = 1 / ( ( planet.icon_size or 512 ) / (64 * 0.33300000000000001) ),
                    icon = planet.icon,
                    icon_size = planet.icon_size or 512,
                })
                if has_edge and barycenter_edge.prerequisite then
                    table.insert(prerequisites, barycenter_edge.prerequisite)
                else
                    table.insert(prerequisites, planet.prerequisite)
                end
                log(serpent.block(icons))
                data:extend({
                    {
                        type = "technology",
                        name = "planet-discovery-" .. planet.name .. "-system",
                        icons = icons,
                        essential = true,
                        effects = effects,
                        prerequisites = prerequisites,
                        unit = {
                            count = 10,
                            ingredients = {
                                { "automation-science-pack", 1 },
                            },
                            time = 60
                        },
                        localised_name = {"?", {"technology-name.planet-discovery-" .. planet.name .. "-system"}, {"technology-name.planet-discovery-fallback", {"space-location-name." .. planet.name}}},
                        localised_description = {"?", {"technology-description.planet-discovery-" .. planet.name .. "-system"}, locales},
                    }
                })
            end
        end
    end
end

-- Loop through each planet and make a technology.
for _, planet in pairs(planets) do
    if planet then
        if data.raw["technology"]["planet-discovery-" .. planet.name] == nil and data.raw["technology"]["moon-discovery-" .. planet.name] == nil then -- Compatibility check to not duplicate planet or moon discovery technologies.
            local planet_technology = {}
            planet_technology[1] = planet.name
            planet_technology[2] = {"space-platform-thruster"}
            if planet.prerequisite then
                table.insert(planet_technology[2], planet.prerequisite)
            end
            if planet.icon then
                planet_technology[3] = planet.icon
            else
                planet_technology[3] = placeholder_png
            end

            if planet.icon_size then
                planet_technology[4] = planet.icon_size
            else
                planet_technology[4] = 512
            end

            table.insert(planet_technologies, planet_technology)
        end
    end
end

---@diagnostic disable-next-line: redefined-local
for i, tech in ipairs(planet_technologies) do
    local planet_name = tech[1]
    local planet_description = tech[2]
    local prerequisites = tech[3]
    local IconIsBlank = tech[4]
    local Icon = IconIsBlank and placeholder_png or "__real-starry-universe__/graphics/" .. planet_name .. ".png"

    data:extend({
        {
            type = "technology",
            name = "planet-discovery-" .. planet_name,
            icon = Icon, -- 替换为行星对应的图标路径
            icon_size = 512,
            essential = true,
            effects = {
                {
                    type = "unlock-space-location",
                    space_location = planet_name,
                    use_icon_overlay_constant = true
                }
            },
            prerequisites = prerequisites,
            unit = {
                count = 10,
                ingredients = {
                    { "automation-science-pack", 1 },
                },
                time = 60
            }
        }
    })
end

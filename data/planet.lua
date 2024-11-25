local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions") -- The original asteroid spawn definitions from Space Age. Should be replaced as soon as possible to allow custom spawn definitions.
-- local asteroid_util = require("asteroid_definitions.asteroid_util") -- New asteroid spawn definitions for when there's new definitions. It isn't ready yet.
local planet_catalogue_gleba = require("__space-age__.prototypes.planet.procession-catalogue-gleba")

local planet_map_gen = require("data.planet-map-gen")
local day = 24 * hour

local planets = {
    {
        type = "planet",
        name = "mercury", -- 水星
        icon = "__real-starry-universe__/graphics/mercury.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/mercury.png",
        starmap_icon_size = 512,
        gravity_pull = 3.7, -- 水星表面重力 (相对值)
        distance = 5.8, -- 距离星系中心 以15为一个AU，约 0.39 AU
        orientation = 0.1, -- 与星系中心角度
        magnitude = 0.383, -- Mercury (水星)
        map_gen_settings = planet_map_gen.mercury(),
        surface_properties = {
            -- Mercury (水星)
            ["day-night-cycle"] = 58.7 * day, -- 水星昼夜周期：58.7个地球日
            ["magnetic-field"] = 1, -- 极弱的磁场
            ["solar-power"] = 500, -- 接收太阳能最多
            pressure = 0, -- 无明显大气压
            gravity = 3.7, -- 重力较小
        },
    },
    {
        type = "planet",
        name = "venus", -- 金星
        icon = "__real-starry-universe__/graphics/venus.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/venus.png",
        starmap_icon_size = 512,
        gravity_pull = 8.87,
        distance = 10.8, -- 0.72 AU
        orientation = 0.2,
        magnitude = 0.949, -- Venus (金星)
        map_gen_settings = planet_map_gen.venus(),
        surface_properties = {
            -- Venus (金星)
            ["day-night-cycle"] = 243 * day, -- 金星昼夜周期：243个地球日
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 90, -- 高温和厚大气层影响太阳能
            pressure = 920000, -- 极高的大气压（单位：Pa）
            gravity = 8.87, -- 类似于地球的重力
        },
    },
    {
        type = "planet",
        name = "earth", -- 地球
        icon = "__real-starry-universe__/graphics/earth.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/earth.png",
        starmap_icon_size = 512,
        gravity_pull = 9.8,
        distance = 15, -- 1 AU
        orientation = 0.315,
        magnitude = 1,
        map_gen_settings = planet_map_gen.normal(),
        surface_properties = {
            -- Earth (地球)
            ["day-night-cycle"] = 1 * day, -- 地球昼夜周期：1个地球日
            ["magnetic-field"] = 100, -- 强磁场保护
            ["solar-power"] = 100, -- 标准太阳能基准
            pressure = 1000, -- 1个大气压
            gravity = 9.8, -- 地球重力
        },
    },
    {
        type = "planet",
        name = "luna",
        icon = "__real-starry-universe__/graphics/luna.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/luna.png",
        starmap_icon_size = 512,
        gravity_pull = 1.62, -- 月球的重力
        distance = 15.5, -- 距离地球非常近
        orientation = 0.33, -- 地球轨道附近
        magnitude = 0.273, -- Luna (月球)
        map_gen_settings = planet_map_gen.luna(), -- 使用月球专属生成方法
        surface_properties = {
            -- Luna (月球)
            ["day-night-cycle"] = 30 * day, -- 月球昼夜周期：27.3个地球日
            ["magnetic-field"] = 1, -- 极弱磁场
            ["solar-power"] = 136, -- 太阳能较高
            pressure = 0, -- 无大气
            gravity = 1.62, -- 重力远小于地球
        },
    },
    {
        type = "planet",
        name = "mars", -- 火星
        icon = "__real-starry-universe__/graphics/mars.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/mars.png",
        starmap_icon_size = 512,
        gravity_pull = 3.71,
        distance = 22.8, -- 1.52 AU
        orientation = 0.35,
        magnitude = 0.532, -- Mars (火星)
        map_gen_settings = planet_map_gen.mars(),
        surface_properties = {
            -- Mars (火星)
            ["day-night-cycle"] = 1.03 * day, -- 火星昼夜周期：接近地球
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 43, -- 较远离太阳，太阳能效率低
            pressure = 6, -- 极低的大气压（单位：Pa）
            gravity = 3.71, -- 重力较低
        },
    },
    {
        type = "space-location",
        name = "asteroid-belt-inner",
        -- icon = "__real-starry-universe__/graphics/asteroid-belt-inner.png", -- Currently, there is no image for asteroid-belt-inner.
        icon = "__real-starry-universe__/graphics/jupiter.png", -- As there is no special image yet, the inner asteroid belt is going to use the jupiter icon.
        icon_size = 512,
        -- starmap_icon = "__real-starry-universe__/graphics/asteroid-belt-inner.png", -- Again, there is no image for asteroid-belt-inner.
        starmap_icon = "__real-starry-universe__/graphics/jupiter.png", -- Again, as there is no special image yet, the inner asteroid belt is going to use the jupiter icon.
        starmap_icon_size = 512,
        gravity_pull = 0.0000137200167, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)
        distance = 27, -- 2.7 AU (centre of the inner asteroid belt)
        orientation = 185 / 360,
        magnitude = 1,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        surface_properties = {
            -- Inner Asteroid Belt (Between Mars and Jupiter)
            ["day-night-cycle"] = 0.37681889586 * day, -- Aproximate day-night cycle for a specific asteroid (which will right now represnent all asteroids)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 13.717, -- Percentage of solar power compared to that on earth? Seems to fit with the data of jupiter and mars, being about in between.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.0000137200167, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)
        },
    },
    {
        type = "planet",
        name = "jupiter", -- 木星
        icon = "__real-starry-universe__/graphics/jupiter.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/jupiter.png",
        starmap_icon_size = 512,
        gravity_pull = 24.79,
        distance = 77.8, -- 5.2 AU
        orientation = 0.45,
        magnitude = 11.209, -- Jupiter (木星)
        map_gen_settings = planet_map_gen.jupiter(),
        surface_properties = {
            -- Jupiter (木星)
            ["day-night-cycle"] = 0.41 * day, -- 木星昼夜周期：10小时
            ["magnetic-field"] = 20000, -- 极强磁场
            ["solar-power"] = 3.7, -- 距太阳远，太阳能效率非常低
            pressure = 200000000, -- 压力极高（单位：Pa）
            gravity = 24.79, -- 极高重力
        },
    },
    {
        type = "planet",
        name = "saturn", -- 土星
        icon = "__real-starry-universe__/graphics/saturn.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/saturn.png",
        starmap_icon_size = 512,
        gravity_pull = 10.44,
        distance = 143.3, -- 9.58 AU
        orientation = 0.55,
        magnitude = 9.449, -- Saturn (土星)
        map_gen_settings = planet_map_gen.saturn(),
        surface_properties = {
            -- Saturn (土星)
            ["day-night-cycle"] = 0.45 * day, -- 土星昼夜周期：10.7小时
            ["magnetic-field"] = 580, -- 中等磁场
            ["solar-power"] = 1.1, -- 远离太阳，效率极低
            pressure = 100000000, -- 大气压极高（单位：Pa）
            gravity = 10.44, -- 类似木星的重力
        },
    },
    {
        type = "planet",
        name = "uranus", -- 天王星
        icon = "__real-starry-universe__/graphics/uranus.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/uranus.png",
        starmap_icon_size = 512,
        gravity_pull = 8.87,
        distance = 287.7, -- 19.22 AU
        orientation = 0.7,
        magnitude = 4.007, -- Uranus (天王星)
        map_gen_settings = planet_map_gen.uranus(),
        surface_properties = {
            -- Uranus (天王星)
            ["day-night-cycle"] = 0.72 * day, -- 天王星昼夜周期：17小时
            ["magnetic-field"] = 50, -- 弱磁场
            ["solar-power"] = 0.3, -- 距太阳非常远
            pressure = 80000000, -- 大气压较高（单位：Pa）
            gravity = 8.69, -- 类似地球的重力
        },
    },
    {
        type = "planet",
        name = "neptune", -- 海王星
        icon = "__real-starry-universe__/graphics/neptune.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/neptune.png",
        starmap_icon_size = 512,
        gravity_pull = 11.15,
        distance = 450.3, -- 30.05 AU
        orientation = 0.85,
        magnitude = 3.883, -- Neptune (海王星)
        map_gen_settings = planet_map_gen.neptune(),
        surface_properties = {
            -- Neptune (海王星)
            ["day-night-cycle"] = 0.67 * day, -- 海王星昼夜周期：16小时
            ["magnetic-field"] = 25, -- 与地球相似的磁场
            ["solar-power"] = 0.1, -- 极低的太阳能
            pressure = 90000000, -- 高大气压（单位：Pa）
            gravity = 11.15, -- 稍高于地球的重力
        },
    },
    {
        type = "planet",
        name = "pluto",
        icon = "__real-starry-universe__/graphics/pluto.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/pluto.png",
        starmap_icon_size = 512,
        gravity_pull = 0.62,
        distance = 592, -- 39.52 AU
        orientation = 0.8,
        magnitude = 0.186, -- Pluto (冥王星)
        map_gen_settings = planet_map_gen.pluto(),
        surface_properties = {
            -- Pluto (冥王星)
            ["day-night-cycle"] = 6.39 * day, -- 冥王星昼夜周期：6.39个地球日
            ["magnetic-field"] = 0, -- 无磁场
            ["solar-power"] = 0.05, -- 几乎没有太阳能
            pressure = 0.1, -- 极其稀薄的大气压
            gravity = 0.62, -- 极低重力
        },
    },
    {
        type = "planet",
        name = "asteroid-belt-outer",
        -- icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- Currently, there is no image for asteroid-belt-outer.
        icon = "__real-starry-universe__/graphics/pluto.png", -- As there is no special image yet, the inner asteroid belt is going to use the pluto icon.
        icon_size = 512,
        -- starmap_icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- Again, there is no image for asteroid-belt-outer.
        starmap_icon = "__real-starry-universe__/graphics/pluto.png", -- Again, as there is no special image yet, the inner asteroid belt is going to use the pluto icon.
        starmap_icon_size = 512,
        gravity_pull = 0.0000517472925, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        distance = 600, -- 40 AU (centre of the outer asteroid belt)
        orientation = 0.8,
        magnitude = 1,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        surface_properties = {
            -- Outer Asteroid Belt (Between Neptune and Solar System Edge)
            ["day-night-cycle"] = 0.28449826615 * day, -- Aproximate day-night cycle for asteroids in the outer asteroid belt (also known as kuiper belt)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 0.8625, -- Percentage of solar power compared to that on earth? Seems to fit with the data of pluto, being around the same.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.0000517472925, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        },
    },
}

data:extend(planets)

local space_connections = {
    {
        type = "space-connection",
        name = "mercury-venus", -- 水星到金星
        subgroup = "planet-connections",
        from = "mercury",
        to = "venus",
        order = "a[mercury]-b[venus]",
        length = 5.0, -- 水星到金星的距离，比例单位
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.small_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.1, b = 0.3 },
            particle_color = { r = 0.6, g = 0.4, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "venus-earth", -- 金星到地球
        subgroup = "planet-connections",
        from = "venus",
        to = "earth",
        order = "b[venus]-c[earth]",
        length = 4.2,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.medium_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.4 },
            particle_color = { r = 0.4, g = 0.7, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "nauvis-earth", -- nauvis到地球
        subgroup = "planet-connections",
        from = "nauvis",
        to = "earth",
        order = "b[venus]-c[earth]",
        length = 4.2,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.medium_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.4 },
            particle_color = { r = 0.4, g = 0.7, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "earth-luna",
        subgroup = "planet-connections",
        from = "earth",
        to = "luna",
        order = "z[a]",
        length = 15, -- 非常近的距离
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.8, g = 0.8, b = 0.9 },
            particle_color = { r = 0.9, g = 0.9, b = 1.0 }
        }
    },
    {
        type = "space-connection",
        name = "earth-mars", -- 地球到火星
        subgroup = "planet-connections",
        from = "earth",
        to = "mars",
        order = "c[earth]-d[mars]",
        length = 7.6,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.large_asteroids),
        space_effects = {
            background_color = { r = 0.1, g = 0.3, b = 0.2 },
            particle_color = { r = 0.5, g = 0.2, b = 0.4 }
        }
    },
    {
        type = "space-connection",
        name = "mars-asteroid-belt-inner", -- Mars to the inner asteroid belt
        subgroup = "planet-connections",
        from = "mars",
        to = "asteroid-belt-inner",
        order = "d[mars]-e[asteroid-belt-inner]",
        length = 55.0,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "asteroid-belt-inner-jupiter", -- The inner asteroid belt to jupiter.
        subgroup = "planet-connections",
        from = "asteroid-belt-inner",
        to = "jupiter",
        order = "e[asteroid-belt-inner]-f[jupiter]",
        length = 55.0,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "jupiter-saturn", -- 木星到土星
        subgroup = "planet-connections",
        from = "jupiter",
        to = "saturn",
        order = "f[jupiter]-g[saturn]",
        length = 65.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.4, b = 0.3 },
            particle_color = { r = 0.5, g = 0.2, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "saturn-uranus", -- 土星到天王星
        subgroup = "planet-connections",
        from = "saturn",
        to = "uranus",
        order = "g[saturn]-h[uranus]",
        length = 144.0,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "uranus-neptune", -- 天王星到海王星
        subgroup = "planet-connections",
        from = "uranus",
        to = "neptune",
        order = "h[uranus]-i[neptune]",
        length = 162.6,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.3, b = 0.5 },
            particle_color = { r = 0.3, g = 0.5, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "neptune-asteroid-belt-outer",
        subgroup = "planet-connections",
        from = "neptune",
        to = "asteroid-belt-outer",
        order = "i[neptune]-j[asteroid-belt-outer]",
        length = 300,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.7, g = 0.4, b = 0.9 },
            particle_color = { r = 0.5, g = 0.6, b = 0.8 }
        }
    },
    {
        type = "space-connection",
        name = "asteroid-belt-outer-pluto",
        subgroup = "planet-connections",
        from = "asteroid-belt-outer",
        to = "pluto",
        order = "j[asteroid-belt-outer]-k[pluto]",
        length = 300,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.7, g = 0.4, b = 0.9 },
            particle_color = { r = 0.5, g = 0.6, b = 0.8 }
        }
    },
}

for i, v in ipairs(space_connections) do
    v.length = v.length * 100
end

data:extend(space_connections)

local planets = {
    { "mercury", "水星", { "planet-discovery-venus", "space-platform-thruster" } },
    { "venus", "金星", { "planet-discovery-luna", "space-platform-thruster" } },
    { "earth", "地球", { "space-platform-thruster" } },
    { "luna", "月球", { "planet-discovery-earth", "space-platform-thruster" } },
    { "mars", "火星", { "planet-discovery-luna", "space-platform-thruster" } },
    { "asteroid-belt-inner", "内小行星带", { "planet-discovery-mars", "space-platform-thruster" } },
    { "jupiter", "木星", { "planet-discovery-asteroid-belt-inner", "space-platform-thruster" } },
    { "saturn", "土星", { "planet-discovery-jupiter", "space-platform-thruster" } },
    { "uranus", "天王星", { "planet-discovery-saturn", "space-platform-thruster" } },
    { "neptune", "海王星", { "planet-discovery-uranus", "space-platform-thruster" } },
    { "pluto", "冥王星", { "planet-discovery-neptune", "space-platform-thruster" } },
    { "asteroid-belt-outer", "柯伊伯带", { "planet-discovery-pluto", "space-platform-thruster" } }
}

for i, planet in ipairs(planets) do
    local planet_name = planet[1]
    local planet_description = planet[2]
    local prerequisites = planet[3]

    data:extend({
        {
            type = "technology",
            name = "planet-discovery-" .. planet_name,
            icon = "__real-starry-universe__/graphics/" .. planet_name .. ".png", -- 替换为行星对应的图标路径
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


-- 定义灵石矿种类
local kuang = {
    { "iron-ore" },
    { "copper-ore" },
    { "stone" },
    { "coal" },
    { "uranium-ore" },
    { "crude-oil" }
}


-- 循环为每个星球添加自动放置控制和设置
for _, planet in ipairs(planets) do
    local planet_name = planet[1]
    -- 为每个星球添加自动放置控制

    for _, item in ipairs(kuang) do
        local autoplace_control_name = item[1]
        -- 为每个星球添加自动放置控制
        data.raw.planet[planet_name].map_gen_settings.autoplace_controls[autoplace_control_name] = {
            order = "a[" .. autoplace_control_name .. "]",
            frequency = 1,
            size = 1,
            richness = 1,
            distribution = "uniform",
            starting_area_size = 1,
            starting_area_order = "a[ore]",
            has_starting_area = false
        }
        -- 为每个星球添加自动放置设置
        data.raw.planet[planet_name].map_gen_settings.autoplace_settings.entity.settings[autoplace_control_name] = {
            name = autoplace_control_name,
            minimum_required = 0,
            maximum = 10
        }
    end
end

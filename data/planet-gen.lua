local MapGeneration = {}

-- Simple nauvis-like planet.
function MapGeneration.normal()
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    return map_gen_setting
end

-- Simple vulcanus-like planet.
function MapGeneration.lava_volcanic()
    local map_gen_setting = table.deepcopy(data.raw.planet.vulcanus.map_gen_settings)

    return map_gen_setting
end

-- Simple gleba-like planet.
function MapGeneration.swamp_lush()
    local map_gen_setting = table.deepcopy(data.raw.planet.gleba.map_gen_settings)

    return map_gen_setting
end

-- Simple fulgora-like planet.
function MapGeneration.oil_wasteland()
    local map_gen_setting = table.deepcopy(data.raw.planet.fulgora.map_gen_settings)

    return map_gen_setting
end

-- Simple aquilo-like planet.
function MapGeneration.frozen_icebergs()
    local map_gen_setting = table.deepcopy(data.raw.planet.aquilo.map_gen_settings)

    return map_gen_setting
end

return MapGeneration
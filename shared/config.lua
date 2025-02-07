Config = {}

Config.Debug                = true                  --Wether or not to enable debug prints. WARNING: This will spam your console. Debug prints are very extensive.
Config.Locale               = 'en'                  --Locale to use. Check locales.lua to add your locale or check the available ones.
Config.CustomNotification   = false                 --Wether or not to use custom notification. If set to true, check functions.lua.
Config.CustomTextUI         = false                 --Wether or not to use custom textui. If set to true, check functions.lua. Only matters if Config.InteractionMethod is set to 'textui'.
Config.InteractionMethod    = 'target'              --Interaction method. Possible values: 'textui' | 'target'. WARNING: 'target' requires ox_target
Config.InteractionSize      = 2                     --Size of interaction zones.
Config.InteractionDistance  = 2                     --Maximum distance to interact with things from.
Config.HouseKeyPrice        = 2000                  --Price to buy a house key.
Config.KeyItem              = 'socialhousekey'      --Name of a 'key' item. Set to false to disable.
Config.PaymentMethod        = 'money'               --How should players pay? Possible values: 'bank' | 'money' | 'black_money'
Config.StashWeight          = 250 * 1000            --Weight in grams of a player's private stash.
Config.StashSlots           = 32                    --Available slots for a player's private stash.
Config.Appearance           = 'fivem-appearance'    --Your appearance resource (needed for wardrobes). Possible values: 'fivem-appearance' ('illenium-appearance' compatibility WIP)
Config.Marker = {                                   --Parameters of markers drawn if Config.InteractionMethod is set to 'textui'.
    type = 25,                                  --Marker type. Check https://docs.fivem.net/docs/game-references/markers/
    coords = vector3(0.0, 0.0, 0.0),            --You can ignore this.
    width = 1.0,
    height = 1.0,
    color = {r = 0, g = 255, b = 0, a = 100},
    direction = vector3(0.0, 0.0, 0.0),
    rotation = vector3(0.0, 0.0, 0.0),
}
Config.SellerPed = {
    position    = vector4(-836.9821, -273.708, 37.80737, 143.7542),
    model       = 'a_m_m_business_01',
    distance    = 160,
    blip        = {
        active      = true,
        sprite      = 475,
        color       = 5,
        size        = 0.8,
        name        = 'House seller'
    }
}

Config.Houses = {
    ['popularhouse1'] = {
        label    = 'House 1',
        desc     = 'Social house at 1A First Street',
        position    = vector3(-360.5021, 21.28589, 47.85898),
        blip        = {
            active      = true,
            sprite      = 40,
            color       = 2,
            size        = 0.8,
            name        = 'Popular house'
        },
        iplType     = 'standard'
    },
    ['popularhouse2'] = {
        label    = 'House 2',
        desc     = 'Social house at 2A Second Street',
        position    = vector3(-903.800598, -225.122833, 40.025150),
        blip        = {
            active      = true,
            sprite      = 40,
            color       = 2,
            size        = 0.8,
            name        = 'Popular house'
        },
        iplType     = 'test2'
    },
    --[[
    --Template
    ['template'] = {
        label    = 'Template house',
        desc     = 'Template social house at 1 Template Street',
        position    = vector3(0, 0, 0),
        blip        = {
            active      = true,
            sprite      = 40,
            color       = 2,
            size        = 0.8,
            name        = 'Template'
        },
        iplType     = 'template'
    },
    ]]
}

Config.Ipls = {
    ['standard'] = {
        exitCoords      = vector3(266.02584, -1007.537, -101.0087),
        stashCoords     = vector3(265.8941, -999.1276, -99.00867),
        wardrobeCoords  = vector3(259.61526, -1004.039, -99.00855),
    },
    ['test2'] = { --Legion square parking lot, for testing purposes
        exitCoords      = vector3(232.342438, -797.145691, 30.569149),
        stashCoords     = vector3(234.342438, -795.145691, 30.569149),
        wardrobeCoords  = vector3(236.342438, -793.145691, 30.569149),
    },
    --[[
    --Template
    ['template'] = {
        exitCoords      = vector3(0, 0, 0),
        stashCoords     = vector3(0, 0, 0),
        wardrobeCoords  = vector3(0, 0, 0),
    }
    ]]
}
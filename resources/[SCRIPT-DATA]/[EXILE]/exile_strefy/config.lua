Config       = {}

Config.Prefix = 'zone_'

Config.TimeBeforeNextTake = 10
Config.RequiredPlayers = 0
Config.Timer = 450

Config.Rewards = {
    money = 100000,
    times = {
        { hour = 18, minute = 00 },
        { hour = 19, minute = 00 },
    },
}

Config.Marker = {
    draw      = 30.0,
    type      = 6,
    rotation  = { x = 90.0, y = 0.0, z = 0.0 },
    size      = { x = 8.0, y = 5.0, z = 8.0 },
    color     = { r = 0, g = 0, b = 0, a = 150 },
}

Config.Blip = {
    ['zones'] = {
        sprite = 148,
        colour = 59,
        alpha  = 50,
        scale  = 2.5,
    }
}

Config.Text3D = {
    draw        = 15.0,
    scale       = 95,
    font        = { r = 255, g = 255, b = 255, a = 255 },
    background  = { r = 0, g = 0, b = 0, a = 90 },
} 


Config.Zones = {
  --  {
    --    coords = vector3(2722.65, 1362.74, 23.7),
      --  blip = {
    --        sprite = 484,
   --         colour = 50,
    --    },
    --    label = 'Strefa 1',
    --    goodlabel = 'Elektrownia',
    --},
    -- {
    --     coords = vector3(-140.097, -2222.2219, 7.1),
    --     blip = {
    --         sprite = 484,
    --         colour = 50,
    --     },
    --     label = 'Strefa 1',
    --     goodlabel = 'Doki',
    -- },
    {
        coords = vector3(2369.41,2523.88, 45.80),
        blip = {
            sprite = 484,
            colour = 50,
        },
        label = 'Strefa 2',
        goodlabel = 'Minilosty',
    }, 
    {
        coords = vector3(1903.7933, 4923.085, 47.9931),
        blip = {
            sprite = 484,
            colour = 50,
        },
        label = 'Strefa 3',
        goodlabel = 'Onil',
    },
  --  {
   --     coords = vector3(3319.0085, 5170.8438, 17.8033),
   --     blip = {
    --        sprite = 484,
     --       colour = 50,
     --   },
      --  label = 'Strefa 4',
       -- goodlabel = 'Latarnia',

  --  },
    {
        coords = vector3(2861.1672, 1490.5844, 28.9781),
        blip = {
            sprite = 484,
            colour = 50,
        },
        label = 'Strefa 4',
        goodlabel = 'Elektrownia',
    },
--     {
--         coords = vector3(1661.3604, 0.817, 165.3682),
--         blip = {
--             sprite = 484,
--             colour = 50,
--         },
--         label = 'Strefa 6',
--         goodlabel = 'Tama',
    -- },
    {
        coords = vector3(58.7509, 3714.7256, 38.9949),
        blip = {
            sprite = 484,
            colour = 50,
        },
        label = 'Strefa 1',
        goodlabel = 'Losty',
    }
}
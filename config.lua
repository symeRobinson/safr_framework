config = {
    departments = {
        ['safr'] = {name = 'San Andreas Fire Rescue', color = ''}
    },
    subdivisions = {
        ['safr_fiu'] = {parent = 'safr', name = 'Fire Investigation Unit', color = ''},
        ['safr_ems'] = {parent = 'safr', name = 'Emergency Medical Service', color = ''},
        ['safr_suppression'] = {parent = 'safr', name = 'Fire Suppression', color = ''}
    },
    units = {
        -- Station 1
        ['e11'] = {spawnCode = 'FD01', name = 'Engine 11', color = {255, 0, 0}, subDivision = 'safr_suppression'}, -- Red for Fire Suppression
        ['m11'] = {spawnCode = 'FD20', name = 'Medic 11', color = {0, 0, 255}, subDivision = 'safr_ems'}, -- Blue for EMS
        ['t11'] = {spawnCode = 'FD10', name = 'Tower 11', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['br11'] = {spawnCode = 'FD02', name = 'Brush 11', color = {34, 139, 34}, subDivision = 'safr_suppression'}, -- Green for Brush Units
        ['sq11'] = {spawnCode = 'FD13', name = 'Heavy Squad 11', color = {255, 255, 0}, subDivision = 'safr_suppression'}, -- Yellow for Rescue
        ['r11'] = {spawnCode = 'FD12', name = 'Rescue 11', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        
        -- Station 2
        ['p21'] = {spawnCode = 'FD03', name = 'Pumper 21', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m21'] = {spawnCode = 'FD20', name = 'Medic 21', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['t21'] = {spawnCode = 'FD18', name = 'Truck 21', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['br21'] = {spawnCode = 'FD02', name = 'Brush 21', color = {34, 139, 34}, subDivision = 'safr_suppression'},
        ['r21'] = {spawnCode = 'FD12', name = 'Rescue 21', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        
        -- Station 3
        ['e31'] = {spawnCode = 'FD04', name = 'Engine 31', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m31'] = {spawnCode = 'FD20', name = 'Medic 31', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['t31'] = {spawnCode = 'FD10', name = 'Tower 31', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['br31'] = {spawnCode = 'FD02', name = 'Brush 31', color = {34, 139, 34}, subDivision = 'safr_suppression'},
        ['r31'] = {spawnCode = 'FD12', name = 'Rescue 31', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        
        -- Station 4
        ['e41'] = {spawnCode = 'FD04', name = 'Engine 41', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m41'] = {spawnCode = 'FD20', name = 'Medic 41', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['br41'] = {spawnCode = 'FD02', name = 'Brush 41', color = {34, 139, 34}, subDivision = 'safr_suppression'},
        ['r41'] = {spawnCode = 'FD12', name = 'Rescue 41', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        ['haz41'] = {spawnCode = 'FD15', name = 'Hazmat 41', color = {255, 165, 0}, subDivision = 'safr_suppression'}, -- Orange for Hazmat
        
        -- Station 5
        ['e51'] = {spawnCode = 'FD01', name = 'Engine 51', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m51'] = {spawnCode = 'FD20', name = 'Medic 51', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['sq51'] = {spawnCode = 'FD13', name = 'Squad 51', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        ['bc51'] = {spawnCode = 'FD11', name = 'Battalion Chief 51', color = {255, 255, 255}, subDivision = 'safr'}, -- White for Command
        
        -- Station 6
        ['e61'] = {spawnCode = 'FD01', name = 'Engine 61', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['p61'] = {spawnCode = 'FD03', name = 'Pumper 61', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m61'] = {spawnCode = 'FD20', name = 'Medic 61', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['br61'] = {spawnCode = 'FD02', name = 'Brush 61', color = {34, 139, 34}, subDivision = 'safr_suppression'},
        
        -- Station 7
        ['e71'] = {spawnCode = 'FD01', name = 'Engine 71', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m71'] = {spawnCode = 'FD20', name = 'Medic 71', color = {0, 0, 255}, subDivision = 'safr_ems'},
        ['r71'] = {spawnCode = 'FD12', name = 'Rescue 71', color = {255, 255, 0}, subDivision = 'safr_suppression'},
        
        -- Station 8
        ['e81'] = {spawnCode = 'FD01', name = 'Engine 81', color = {255, 0, 0}, subDivision = 'safr_suppression'},
        ['m81'] = {spawnCode = 'FD20', name = 'Medic 81', color = {0, 0, 255}, subDivision = 'safr_ems'},
    },
    stationLocations = {
        ['station_one'] = {
            name = "Station 1",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e11', 'm11', 't11', 'br11', 'sq11', 'r11'
            }
        },
        ['station_two'] = {
            name = "Station 2",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'p21', 'm21', 'tr21', 'br21', 'r21'
            }
        },
        ['station_three'] = {
            name = "Station 3",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e31', 'm31', 't31', 'br31', 'r31'
            }
        },
        ['station_four'] = {
            name = "Station 4",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e41', 'm41', 'br41', 'r41', 'haz41'
            }
        },
        ['station_five'] = {
            name = "Station 5",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e51', 'm51', 'sq51', 'bc51'
            }
        },
        ['station_six'] = {
            name = "Station 6",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e61', 'p61', 'm61', 'br61'
            }
        },
        ['station_seven'] = {
            name = "Station 7",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e71', 'm71', 'r71'
            }
        },
        ['station_eight'] = {
            name = "Station 8",
            spawnLocations = {}, 
            npcLocation = {}, 
            lockerLocation = {}, 
            paLocation = {}, 
            vehSpots = {},
            assignedUnits = {
                'e81', 'm81'
            }
        }
    }
}

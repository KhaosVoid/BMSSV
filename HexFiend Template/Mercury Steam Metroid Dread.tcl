# Mercury Steam Metroid Dread savegame parser
# Use with HexFiend - https://hexfiend.com

little_endian

if [catch {

# Type-Value schema
proc parse_tv {} {
    set type_id [hex 8]
    switch $type_id {
        
        0x0C500CA1F3B54C26 {
            # NavMesh Occluders (2D array)
            set num_records [uint32 "NavMesh Occluders"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "NavMesh Occluder $i" {
                    sectionvalue [cstr "utf8"]
                    set num_nmo [uint32 "Number of subrecords"]
                    for { set j 0 } { $j < $num_nmo } { incr j } {
                        parse_tv
                    }
                }
            }
        }
        
        0x1296854B5C530FAF {
            # MiniMapAreaFirstPoint
            float "Point 1 X"
            float "Point 1 Y"
        }
        
        0x145D990A588908BB {
            # NavMesh Occluder flag
            entry "FLAG 145D" ""
        }
        
        0x1792BC17AD716D8D {
            # MiniMap Visibility
            set num_records [uint32 "Number of Records"]
            for { set i 0 } { $i < $num_records } { incr i } {
                uint32 "Index $i"
                cstr "utf8" "DefString $i"
            }
        }
        
        0x1A9241A8743F4CAB {
            # NavMesh Occluder flag
            entry "FLAG 1A92" ""
        }
        
        0x1D492D17D698EA76 {
            # MiniMap Tiles (3D array)
            set num_records [uint32 "Number of Tiles"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "Tile $i" {
                    sectionvalue [cstr "utf8"]
                    set num_points [uint32 "Number of Points"]
                    for { set j 0 } { $j < $num_points } { incr j } {
                        section "Point $j" {
                            set num_props [uint32 "Number of Properties"]
                            for { set k 0 } { $k < $num_props } { incr k } {
                                parse_tv
                            }
                        }
                    }
                }
            }
        }
        
        0x1D4F060F133F1E29 {
            # UInt32 or Int32?
            uint32 "Numeric 1D"
        }
        
        0x1DCF8BB14CF6E63A {
            # NavMesh Occluder flag
            entry "FLAG 1DCF" ""
        }

        0x1ED58C7641EFCC2C {
            # NavMesh Occluder flag
            entry "FLAG 1ED5" ""
        }

        0x22B16B436D9EC80D {
            # List of SaveDataGroups
            set num_records [uint32 "Number of SDGs"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "SaveDataGroup $i" {
                    sectionvalue [cstr "utf8"]
                    parse_tv
                }
            }
        }
        
        0x256582A39FB5119F {
            # NavMesh Occluder flag
            entry "FLAG 2565" ""
        }

        0x2567850CE806D4F8 {
            # Door state?
            uint32 "Numeric 25"
        }

        0x25E09478B1D26ACF {
            # List of Strings
            set num_strings [uint32 "Number of Strings"]
            for { set i 0 } { $i < $num_strings } { incr i } {
                cstr "utf8" "String $i"
            }
        }

        0x2B1A8B33DE7B0C6A {
            # Boolean
            int8 -hex "Boolean"
        }
        
        0x2F6D2F820BE625FA {
            # NavMesh Occluder flag
            entry "FLAG 2F6D" ""
        }
        
        0x31B88BF33548DE26 {
            # SubareaSetup String
            cstr "utf8" "Subarea String"
        }
        
        0x31D90A80FF583FC1 {
            # Mission Log Item Identifier
            cstr "utf8" "Identifier"
        }
        
        0x40BAA540D530AA25 {
            # NavMesh Occluder flag
            entry "FLAG 40BA" ""
        }
        
        0x427DA2B93E7204DE {
            # NavMesh Occluder flag
            entry "FLAG 427D" ""
        }
        
        0x48C4218C5F995970 {
            # Footer?
            uint32 "Footer Value"
        }

        0x4DE61CA471BEDCD2 {
            # Mission Log Item
            set num_logs [uint32 "Number of Logs"]
            for { set i 0 } { $i < $num_logs } { incr i } {
                section "MissionLog $i" {
                    set num_records [uint32 "Count"]
                    for { set j 0 } { $j < $num_records } { incr j } {
                        parse_tv
                    }
                }
            }
        }

        0x518AD65EBA597493 {
            # Float
            float "Numeric (float)"
        }
        
        0x6C83AF6F9CA85C5A {
            # Root item (userdata.bmssv)
            section "Header" {
                uint16 "Version1?"
                uint16 "Version2?"
            }
            parse_tv
        }
        
        0x6FF3E71C57D6839C {
            # NavMesh Occluder flag
            entry "FLAG 6FF3" ""
        }
        
        0x72CFCC424A228498 {
            # Mission Log Item Unknown Value
            uint32 "Unknown Value 72"
        }

        0x79C2F775BD2B3138 {
            # MiniMap Custom Marker Value
            uint32 "Unknown Value 79"
        }
        
        0x79F31B83386F08A1 {
            # MiniMap Custom Marker Value
            uint32 "Numeric 79"
        }

        0x7A64BDD1A5B7F7BF {
            # MiniMap Tile Payload
            uint32 "Numeric 7A"
        }

        0x7EC5E3B4F43F8724 {
            # List of UInt32
            set num_ints [uint32 "Number of Numbers"]
            for { set i 0 } { $i < $num_ints } { incr i } {
                uint32 "Numeric $i"
            }
        }
        
        0x7BABC0C8085511C2 {
            # NavMesh Occluder flag
            entry "FLAG 7BAB" ""
        }
        
        0x8DC2E7510FAB1F45 {
            # NavMesh Occluder flag
            entry "FLAG 8DC2" ""
        }
        
        0x8EF51A47A8CCA255 {
            # Mission Log Item List of Pages
            set num_records [uint32 "Number of Pages"]
            for { set i 0 } { $i < $num_records } { incr i } {
                cstr "utf8" "Page $i"
            }
        }
        
        0x966FEB6FA3517B49 {
            # MiniMap Tile Payload
            float "Point 96"
        }
        
        0x9A714C5BDFE4E50F {
            # MiniMapGlobalIconPoint
            float "Point X"
            float "Point Y"
        }
        
        0xA086BDADD2CF1BE8 {
            # MiniMap Tile Payload
            uint32 "Point A0"
        }
        
        0xAA8881F44964F0C2 {
            # Last CheckPoint Offset - Unknown Value
            float "Point X?"
            float "Point Y?"
            uint32 "Numeric?"
            #hex 12 "Unknown Payload"
            ###########################################################
            ### TODO
            ###########################################################
        }
        
        0xACCD3DDFD3D4567A {
            # Last CheckPoint Offset - Unknown Value
            hex 12 "Unknown Payload"
            ###########################################################
            ### TODO
            ###########################################################
        }
        
        0xAFE3B5CB55A6025B {
            # NavMesh Occluder flag
            entry "FLAG AFE3" ""
        }
        
        0xB7C1F0A2F08B8870 {
            # Last CheckPoint Offset - Value
            cstr "utf8" "Area Name"
        }
        
        0xBD1406456F93A3F7 {
            # SaveDataGroup
            set num_records [uint32 "Number of Containers"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "Container $i" {
                    parse_tv
                }
            }
        }

        0xBDAA54365AE550F4 {
            # Minimap Area Box
            set num_records [uint32 "Number of Points"]
            for { set i 0 } { $i < $num_records } { incr i } {
                parse_tv
            }
        }
        
        0xBF450D514E81EB1B {
            # MiniMap Custom Markers
            set num_records [uint32 "Number of Markers"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "Marker $i" {
                    uint32 "Index"
                    set num_subs [uint32 "Number of Properties"]
                    for { set j 0 } { $j < $num_subs } { incr j } {
                        parse_tv
                    }
                }
            }
        }
        
        0xBF8FE251F17EAD25 {
            # Last CheckPoint Offset
            set num_records [uint32 "Number of Records"]
            for { set i 0 } { $i < $num_records } { incr i } {
                parse_tv
            }
        }
        
        0xBFE26B06920280B2 {
            # MiniMap Custom Marker Name
            cstr "utf8" "Name"
        }
        
        0xC897DE38447F5CF2 {
            # WATER_VOLUMES / LAVA_VOLUMES
            set num_records [uint32 "Number of Records"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "Volume $i" {
                    sectionvalue [cstr "utf8"]
                    set num_props [uint32 "Number of Properties"]
                    for { set j 0 } { $j < $num_props } { incr j } {
                        parse_tv
                    }
                }
            }
        }
        
        0xCADF3A163B607F5B {
            # Occluder Vignettes
            set num_records [uint32 "Number of Records"]
            for { set i 0 } { $i < $num_records } { incr i } {
                cstr "utf8" "Vignette $i"
                int8 -hex "Boolean"
            }
        }
        
        0xCBC5EA0BB5426634 {
            # SaveDataGroup container
            set num_records [uint32 "Number of Records"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "Record $i" {
                    parse_tv
                }
            }
        }
        
        0xD0BE2F66278BC819 {
            # Root item (common.bmssv, pkprfl.bmssv, samus.bmssv)
            section "Header" {
                uint16 "Version1?"
                uint16 "Version2?"
            }
            parse_tv
        }
        
        0xD1A8336890B4BBDD {
            # MiniMap Custom Icon Value
            float "Point X"
            float "Point Y"
        }
        
        0xD4A5EC5A593AE24D {
            # MiniMapAreaSecondPoint
            float "Point 2 X"
            float "Point 2 Y"
        }

        0xD6AC6CD794D87CB9 {
            # UInt32 or Int32?
            uint32 -hex "Numeric D6"
        }
        
        0xDBEC65DF4FDE1A6D {
            # NavMesh Occluder flag
            entry "FLAG DBEC" ""
        }
        
        0xE0D4E713F7819779 {
            # String (null-terminated)
            cstr "utf8" "String E0"
        }

        0xE926F01F5C4070D0 {
            # MiniMapGlobalIconName
            cstr "utf8" "Icon Name"
        }
        
        0xE9E090C528ECE3C4 {
            # Last CheckPoint Offset - Value
            uint32 -hex "Numeric E9"
        }

        0xED21C62C3C8D27D7 {
            # SaveDataContainer (Array)
            set num_records [uint32 "Number of Entries"]
            for { set i 0 } { $i < $num_records } { incr i } {
                section "SaveDataEntry $i" {
                    sectionvalue [cstr "utf8"]
                    parse_tv
                }
            }
        }

        0xF058F869AB5A36F9 {
            # Minimap Global Icon Item (3D array)
            set num_maps [uint32 "Number of Maps"]
            for { set i 0 } { $i < $num_maps } { incr i } {
                section "Map $i" {
                    sectionvalue [cstr "utf8"]
                    set num_icons [uint32 "Number of Icons"]
                    for { set j 0 } { $j < $num_icons } { incr j } {
                        section "Icon $j" {
                            set num_records [uint32 "Count"]
                            for { set k 0 } { $k < $num_records } { incr k } {
                                parse_tv
                            }
                        }
                    }
                }
            }
        }
        
        0xF3A3EBFFF0077303 {
            # MiniMap Custom Marker
            uint32 "Numeric F3"
        }

        0xF46AD97DC54A9259 {
            # NavMesh Item Collider Offset
            uint32 "X Offset?"
            uint32 "Y Offset?"
        }

        0xF6EA0DBA9BF734BF {
            # String, null-terminated
            cstr "utf8" "String F6"
        }
        
        0xF9304C6C1D1D55FA {
            # MiniMap Tile payload
            float "Point F9"
        }
        
        0xF99B092157337B0D {
            # MiniMap LastPlayerPos
            hex 12 "Unknown"
            ###########################################################
            ### TODO
            ###########################################################
            
        }
        
        default {
            entry "Unknown type" $type_id
            hex 4 "Maybe payload?"
        }
    }
}

# Run the initial parsing
parse_tv

}] {
    entry "ERROR:" $errorInfo
}

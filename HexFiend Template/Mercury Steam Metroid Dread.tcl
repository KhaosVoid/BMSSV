# Mercury Steam Metroid Dread savegame parser
# Use with HexFiend - https://hexfiend.com

little_endian

if [catch {

# Type-Value schema
proc parse_tv {} {
    set type_id [hex 8]
    switch $type_id {
        
        0x0C500CA1F3B54C26 {
            # TEnabledOccluderCollidersMap
            section "TEnabledOccluderCollidersMap" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "TEnabledOccluderCollider $i" {
                        sectionvalue [cstr "utf8"]
                        set num_nmo [uint32 "Number of subrecords"]
                        for { set j 0 } { $j < $num_nmo } { incr j } {
                            parse_tv
                        }
                    }
                }
            }
        }
        
        0x1296854B5C530FAF {
            # Min (MiniMap Area)
            float "Min X"
            float "Min Y"
        }
        
        0x145D990A588908BB {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 145D"
        }
        
        0x1792BC17AD716D8D {
            # minimapGrid::TMinimapVisMap
            section "TMinimapVisMap" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    uint32 "TMinimapVisMap $i"
                    cstr "utf8" "DefString $i"
                }
            }
        }
        
        0x19DDE2116944802A {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 19DD"
        }
        
        0x1A9241A8743F4CAB {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 1A92"
        }
        
        0x1D492D17D698EA76 {
            # CBreakableTileGroupComponent::TActorTileStatesMap
            section "TActorTileStatesMap" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
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
        }
        
        0x1D4F060F133F1E29 {
            # int
            int32 "int"
        }
        
        0x1DCF8BB14CF6E63A {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 1DCF"
        }

        0x1ED58C7641EFCC2C {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 1ED5"
        }

        0x20D3D5E61247C339 {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 20D3"
        }

        0x22B16B436D9EC80D {
            # hashSections
            section "hashSections" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "hashSection $i" {
                        sectionvalue [cstr "utf8"]
                        parse_tv
                    }
                }
            }
        }
        
        0x256582A39FB5119F {
            # collision
            move -8
            entry "FLAG" "collision" 8
            move 8
        }

        0x2567850CE806D4F8 {
            # CDoorLifeComponent::SState
            uint32 "CDoorLifeComponent::SState"
        }

        0x25E09478B1D26ACF {
            # base::global::CRntVector<base::global::CStrId>
            # List of Strings
            section "CRntVector<CStrId>" {
                set num_strings [uint32]
                sectionvalue "$num_strings entries"
                for { set i 0 } { $i < $num_strings } { incr i } {
                    cstr "utf8" "CStrId $i"
                }
            }
        }

        0x2B1A8B33DE7B0C6A {
            # bool
            int8 -hex "bool"
        }
        
        0x2F6D2F820BE625FA {
            # collision_closed
            move -8
            entry "FLAG" "collision_closed" 8
            move 8
        }
        
        0x31B88BF33548DE26 {
            # base::global::TRntString256
            cstr "utf8" "TRntString256"
        }
        
        0x31D90A80FF583FC1 {
            # sLabelText
            cstr "utf8" "sLabelText"
        }
        
        0x40BAA540D530AA25 {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 40BA"
        }
        
        0x427DA2B93E7204DE {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 427D"
        }
        
        0x48C4218C5F995970 {
            # dctDeltaValues
            uint32 "dctDeltaValues"
        }

        0x4DE61CA471BEDCD2 {
            # GUI::CMissionLog::TMissionLogEntries
            section "TMissionLogEntries" {
                set num_logs [uint32]
                sectionvalue "$num_logs entries"
                for { set i 0 } { $i < $num_logs } { incr i } {
                    section "MissionLogEntry $i" {
                        set num_records [uint32 "Count"]
                        for { set j 0 } { $j < $num_records } { incr j } {
                            parse_tv
                        }
                    }
                }
            }
        }

        0x518AD65EBA597493 {
            # float
            float "float"
        }
        
        0x6C83AF6F9CA85C5A {
            # CBlackboard (userdata.bmssv)
            section "CBlackboard" {
                uint16 "Version?"
                set num_records [uint16]
                sectionvalue "$num_records entries"
            }
            for { set i 0 } { $i < $num_records } { incr i } {
                section "CBlackboard $i" {
                    parse_tv
                }
            }
        }
        
        0x6FF3E71C57D6839C {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 6FF3"
        }
        
        0x72CFCC424A228498 {
            # eEntryType (Mission Log Item)
            uint32 "eEntryType"
        }

        0x79C2F775BD2B3138 {
            # nTargetSlot (MiniMap Custom Marker)
            uint32 "nTargetSlot"
        }
        
        0x79F31B83386F08A1 {
            # eType (MiniMap Custom Marker)
            uint32 "eType"
        }

        0x7A64BDD1A5B7F7BF {
            # uState (MiniMap Tiles)
            uint32 "uState"
        }

        0x7BABC0C8085511C2 {
            # trapblockfinal
            move -8
            entry "FLAG" "trapblockfinal" 8
            move 8
        }
        
        0x7EC5E3B4F43F8724 {
            # base::global::CRntVector<EMapTutoType>
            section "CRntVector<EMapTutoType>" {
                set num_ints [uint32]
                sectionvalue "$num_ints entries"
                for { set i 0 } { $i < $num_ints } { incr i } {
                    uint32 "EMapTutoType $i"
                }
            }
        }
        
        0x8DC2E7510FAB1F45 {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG 8DC2"
        }
        
        0x8EF51A47A8CCA255 {
            # vCaptionsIds (Mission Log Item)
            section "vCaptionIds" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    cstr "utf8" "vCaptionId $i"
                }
            }
        }
        
        0x966FEB6FA3517B49 {
            # fY
            float "fY"
        }
        
        0x9A714C5BDFE4E50F {
            # vIconPos (MiniMap Global Icon)
            float "vIconPos X"
            float "vIconPos Y"
        }
        
        0xA086BDADD2CF1BE8 {
            # eTileType (MiniMap Tile)
            uint32 "eTileType"
        }
        
        0xAA8881F44964F0C2 {
            # vOffsetPos (Last CheckPoint Offset)
            float "vOffsetPos X"
            float "vOffsetPos Y"
            float "vOffsetPos Z"
        }
        
        0xACCD3DDFD3D4567A {
            # vOffsetAng (Last CheckPoint Offset)
            float "vOffsetAng X"
            float "vOffsetAng Y"
            float "vOffsetAng Z"
        }
        
        0xAFE3B5CB55A6025B {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG AFE3"
        }
        
        0xB7C1F0A2F08B8870 {
            # strCheckpointID (Last CheckPoint Offset)
            cstr "utf8" "strCheckpointID"
        }
        
        0xBD1406456F93A3F7 {
            # CBlackboard::CSection
            section "CBlackboard:CSection" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "CSection $i" {
                        parse_tv
                    }
                }
            }
        }

        0xBDAA54365AE550F4 {
            # base::spatial::CAABox2D (MiniMap Area)
            section "CAABox2D" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    parse_tv
                }
            }
        }
        
        0xBF450D514E81EB1B {
            # CMinimapManager::TCustomMarkerDataMap
            section "TCustomMarkerDataMap" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "TCustomMarkerDataMap $i" {
                        uint32 "Index"
                        set num_subs [uint32 "Number of Properties"]
                        for { set j 0 } { $j < $num_subs } { incr j } {
                            parse_tv
                        }
                    }
                }
            }
        }
        
        0xBF8FE251F17EAD25 {
            # TCheckpointOffset
            section "TCheckpointOffset" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    parse_tv
                }
            }
        }
        
        0xBFE26B06920280B2 {
            # sTargetID (MiniMap Custom Marker)
            cstr "utf8" "sTargetID"
        }
        
        0xC897DE38447F5CF2 {
            # base::global::CRntSmallDictionary<base::global::CStrId, base::spatial::CAABox2D> (Water-/Lava-Volumes)
            section "CRntSmallDictionary<CStrId, CAABox2D>" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "CRntSmallDict $i" {
                        sectionvalue [cstr "utf8"]
                        set num_props [uint32 "Number of Properties"]
                        for { set j 0 } { $j < $num_props } { incr j } {
                            parse_tv
                        }
                    }
                }
            }
        }
        
        0xCADF3A163B607F5B {
            # base::global::CRntSmallDictionary<base::global::CStrId, bool> (Occluder Vignettes)
            section "CRntSmallDictionary<CStrId, bool>" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "CRntSmallDict $i" {
                        sectionvalue [cstr "utf8"]
                        int8 -hex "Boolean"
                    }
                }
            }
        }
        
        0xCBC5EA0BB5426634 {
            # Root
            section "Root" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "Root $i" {
                        parse_tv
                    }
                }
            }
        }
        
        0xD0742138FC74EC08 {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG D074"
        }

        0xD0BE2F66278BC819 {
            # CGameBlackboard (common.bmssv, pkprfl.bmssv, samus.bmssv)
            section "CGameBlackboard" {
                uint16 "Version?"
                set num_records [uint16]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "CGameBlackboard $i" {
                        parse_tv
                    }
                }
            }
        }
        
        0xD1A8336890B4BBDD {
            # vPos (MiniMap Custom Marker)
            float "vPos X"
            float "vPos Y"
        }
        
        0xD4A5EC5A593AE24D {
            # Max (MiniMap Area)
            float "Max X"
            float "Max Y"
        }

        0xD6AC6CD794D87CB9 {
            # unsigned
            uint32 "unsigned"
        }
        
        0xDBEC65DF4FDE1A6D {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG DBEC"
        }
        
        0xE0D4E713F7819779 {
            # base::global::CRntString
            cstr "utf8" "CRntString"
        }
        
        0xE48BC693150E464F {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG E48B"
        }

        0xE926F01F5C4070D0 {
            # sIconID (MiniMap Global Icon)
            cstr "utf8" "sIconID"
        }
        
        0xE9E090C528ECE3C4 {
            # ??? Last CheckPoint Offset - Value
            uint32 -hex "Numeric E9"
        }

        0xEC6670556EB06377 {
            # ??? NavMesh Occluder flag
            move -8
            hex 8 "FLAG EC66"
        }

        0xED21C62C3C8D27D7 {
            # dctProps
            section "dctProps" {
                set num_records [uint32]
                sectionvalue "$num_records entries"
                for { set i 0 } { $i < $num_records } { incr i } {
                    section "dctProp $i" {
                        sectionvalue [cstr "utf8"]
                        parse_tv
                    }
                }
            }
        }

        0xF058F869AB5A36F9 {
            # CMinimapManager::TGlobalMapIcons
            section "CMinimapManager::TGlobalMapIcons" {
                set num_maps [uint32]
                sectionvalue "$num_maps entries"
                for { set i 0 } { $i < $num_maps } { incr i } {
                    section "TGlobalMapIcon $i" {
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
        }
        
        0xF3A3EBFFF0077303 {
            # nMarkerID (MiniMap Custom Marker)
            uint32 "nMarkerID"
        }

        0xF46AD97DC54A9259 {
            # base::math::CVector2D
            section "CVector2D" {
                float "X"
                float "Y"
            }
        }

        0xF6EA0DBA9BF734BF {
            # base::global::CStrId
            cstr "utf8" "CStrId"
        }
        
        0xF9304C6C1D1D55FA {
            # fX (MiniMap Tile)
            float "fX"
        }
        
        0xF99B092157337B0D {
            # base::math::CVector3D (LastPlayerPos)
            section "CVector3D" {
                float "X"
                float "Y"
                float "Z"
            }
            ###########################################################
            ### TODO
            ###########################################################
            
        }
        
        default {
            entry "### Unknown ###" $type_id
            hex 4 "### Value ###"
        }
    }
}

# Run the initial parsing
parse_tv

}] {
    entry "ERROR:" $errorInfo
}

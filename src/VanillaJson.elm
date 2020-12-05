module VanillaJson exposing (encodeCharacter)

import Character
    exposing
        ( Character(..)
        , CharacterClass(..)
        , CharacterStat(..)
        , Item(..)
        , StatHolder
        , classToString
        , itemToString
        )
import Dict exposing (Dict)
import Json.Encode exposing (object, string)


encodeCharacter : Character -> Json.Encode.Value
encodeCharacter (Character character) =
    object
        [ ( "Class", string (Character.classToString character.class) )
        , ( "Name", string (Maybe.withDefault "" character.name) )
        , ( "Experience", Json.Encode.int character.experience )
        , ( "StatPoints", Json.Encode.int character.statPoints )
        , ( "Gold", Json.Encode.int character.gold )
        , ( "Stats", encodeStats character.stats )
        , ( "Inventory", Json.Encode.list string (encodeInventory character.inventory) )
        ]


encodeInventory : List Item -> List String
encodeInventory inventory =
    inventory
        |> List.map Character.itemToString


encodeStats : Dict String StatHolder -> Json.Encode.Value
encodeStats stats =
    stats
        |> Dict.toList
        |> List.map statEntryToJson
        |> Json.Encode.object


statEntryToJson : ( String, StatHolder ) -> ( String, Json.Encode.Value )
statEntryToJson ( key, statHolder ) =
    ( key, Json.Encode.int statHolder.value )

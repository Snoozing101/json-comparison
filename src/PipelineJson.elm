module PipelineJson exposing (decodeCharacter, decodeCharacterStat, decodeClass, decodeInventory, decodeName, decodeStatHolder, encodeCharacter)

import Character
    exposing
        ( Character(..)
        , CharacterClass(..)
        , CharacterStat(..)
        , Item(..)
        , StatHolder
        , classToString
        , getCharacterStatOrder
        , itemToString
        , makeCharacter
        , stringToCharacterStat
        , stringToItem
        )
import Dict exposing (Dict)
import Json.Decode
import Json.Decode.Pipeline exposing (required)
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


decodeCharacter : Json.Decode.Decoder Character
decodeCharacter =
    Json.Decode.succeed Character.makeCharacter
        |> required "Class" decodeClass
        |> required "Name" decodeName
        |> required "Stats" decodeStatHolder
        |> required "Experience" Json.Decode.int
        |> required "StatPoints" Json.Decode.int
        |> required "Gold" Json.Decode.int
        |> required "Inventory" decodeInventory


decodeClass : Json.Decode.Decoder CharacterClass
decodeClass =
    Json.Decode.string
        |> Json.Decode.andThen
            (\class ->
                case class of
                    "Wanderer" ->
                        Json.Decode.succeed Wanderer

                    "Cleric" ->
                        Json.Decode.succeed Cleric

                    "Magician" ->
                        Json.Decode.succeed Magician

                    "Warrior" ->
                        Json.Decode.succeed Warrior

                    "Barbarian" ->
                        Json.Decode.succeed Barbarian

                    _ ->
                        Json.Decode.fail <| "Unknown class: '" ++ class ++ "'"
            )


decodeName : Json.Decode.Decoder (Maybe String)
decodeName =
    Json.Decode.nullable Json.Decode.string


decodeStats : Json.Decode.Decoder (Dict String String)
decodeStats =
    Json.Decode.dict Json.Decode.string


decodeCharacterStat : Json.Decode.Decoder CharacterStat
decodeCharacterStat =
    Json.Decode.string
        |> Json.Decode.andThen
            (\stat ->
                case stat of
                    "Strength" ->
                        Json.Decode.succeed Strength

                    "Vitality" ->
                        Json.Decode.succeed Vitality

                    "Agility" ->
                        Json.Decode.succeed Agility

                    "Intelligence" ->
                        Json.Decode.succeed Intelligence

                    "Luck" ->
                        Json.Decode.succeed Luck

                    "Aura" ->
                        Json.Decode.succeed Aura

                    "Morality" ->
                        Json.Decode.succeed Morality

                    _ ->
                        Json.Decode.fail <| "Unknown stat: '" ++ stat ++ "'"
            )


decodeStatHolder : Json.Decode.Decoder (Dict String StatHolder)
decodeStatHolder =
    Json.Decode.map (Dict.map transformStat) (Json.Decode.dict Json.Decode.int)


transformStat : String -> Int -> StatHolder
transformStat statString value =
    let
        stat =
            Character.stringToCharacterStat statString

        order =
            Character.getCharacterStatOrder stat
    in
    StatHolder stat value order


decodeInventory : Json.Decode.Decoder (List Item)
decodeInventory =
    Json.Decode.map (List.map Character.stringToItem) (Json.Decode.list Json.Decode.string)

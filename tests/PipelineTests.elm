module PipelineTests exposing (all)

import Character
    exposing
        ( Character(..)
        , CharacterClass(..)
        , CharacterStat(..)
        , Item(..)
        )
import Dict
import Expect
import Json.Decode
import Json.Encode
import PipelineJson exposing (decodeCharacter, decodeCharacterStat, decodeClass, decodeInventory, decodeName, decodeStatHolder, encodeCharacter)
import Test exposing (Test, describe, test)
import Utils


all : Test
all =
    describe "Testing core JSON encodeing & decoding"
        [ test "Encode a Character type to JSON" <|
            \_ ->
                let
                    newCharacter =
                        Utils.initCharacter

                    jsonCharacterString =
                        Utils.initJsonCharacterString
                in
                Expect.equal (Json.Encode.encode 0 (PipelineJson.encodeCharacter newCharacter)) jsonCharacterString
        , test "Decode a Class" <|
            \_ ->
                let
                    jsonString =
                        "{\"Class\":\"Barbarian\"}"

                    classDecoder =
                        Json.Decode.field "Class" PipelineJson.decodeClass
                in
                Expect.equal (Json.Decode.decodeString classDecoder jsonString) (Ok Barbarian)
        , test "Decode a Name to Maybe String" <|
            \_ ->
                let
                    jsonString =
                        "{\"Name\":\"Bilbo\"}"

                    nameDecoder =
                        Json.Decode.field "Name" PipelineJson.decodeName
                in
                Expect.equal (Json.Decode.decodeString nameDecoder jsonString) (Ok (Just "Bilbo"))
        , test "Decode a CharacterStat" <|
            \_ ->
                let
                    string =
                        "\"Strength\""
                in
                Expect.equal (Json.Decode.decodeString PipelineJson.decodeCharacterStat string) (Ok Strength)
        , test "Decode a StatHolder" <|
            \_ ->
                let
                    jsonString =
                        "{\"Intelligence\":12}"

                    statHolder =
                        Character.makeStatDictEntry Intelligence 12

                    result =
                        Dict.fromList [ statHolder ]
                in
                Expect.equal (Json.Decode.decodeString PipelineJson.decodeStatHolder jsonString) (Ok result)
        , test "Decode multiple StatHolders" <|
            \_ ->
                let
                    jsonString =
                        """
                        {
                            "Strength": 8,
                            "Vitality": 10,
                            "Intelligence": 19,
                            "Luck": 2,
                            "Aura": 16,
                            "Morality": 12
                        }
                        """

                    result =
                        Dict.fromList
                            [ Character.makeStatDictEntry Strength 8
                            , Character.makeStatDictEntry Vitality 10
                            , Character.makeStatDictEntry Intelligence 19
                            , Character.makeStatDictEntry Luck 2
                            , Character.makeStatDictEntry Aura 16
                            , Character.makeStatDictEntry Morality 12
                            ]
                in
                Expect.equal (Json.Decode.decodeString PipelineJson.decodeStatHolder jsonString) (Ok result)
        , test "Decode inventory" <|
            \_ ->
                let
                    jsonString =
                        """
                            ["Shield"]
                        """

                    result =
                        [ Shield ]
                in
                Expect.equal (Json.Decode.decodeString PipelineJson.decodeInventory jsonString) (Ok result)
        , test "Decode a Character" <|
            \_ ->
                Expect.equal (Json.Decode.decodeString PipelineJson.decodeCharacter Utils.initJsonCharacterString) (Ok Utils.initCharacter)
        ]

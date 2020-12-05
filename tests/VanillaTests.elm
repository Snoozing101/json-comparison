module VanillaTests exposing (all)

import Character
    exposing
        ( Character(..)
        , CharacterClass(..)
        , CharacterStat(..)
        , Item(..)
        )
import Expect
import Json.Encode
import Test exposing (Test, describe, test)
import Utils
import VanillaJson exposing (encodeCharacter)


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
                Expect.equal (Json.Encode.encode 0 (VanillaJson.encodeCharacter newCharacter)) jsonCharacterString
        ]

module VanillaTests exposing (all)

import Dict
import Expect
import Json.Encode
import Test exposing (Test, describe, test)
import VanillaJson exposing (Character(..), CharacterClass(..), CharacterStat(..), Item(..), StatHolder, encodeCharacter)



-- TODO: Refactor out all the character stuff to it's own module.
-- TODO: Add ability to decode


all : Test
all =
    describe "Testing core JSON encodeing & decoding"
        [ test "Encode a Character type to JSON" <|
            \_ ->
                let
                    newCharacter =
                        initCharacter

                    jsonCharacterString =
                        initJsonCharacterString
                in
                Expect.equal (Json.Encode.encode 0 (VanillaJson.encodeCharacter newCharacter)) jsonCharacterString
        ]



-- Helper functions


initCharacter : Character
initCharacter =
    Character
        { class = Wanderer
        , name = Just "Bilbo"
        , stats =
            Dict.fromList
                [ makeStatDictEntry Strength 11 0
                , makeStatDictEntry Vitality 6 1
                , makeStatDictEntry Agility 10 2
                , makeStatDictEntry Intelligence 12 3
                , makeStatDictEntry Luck 9 4
                , makeStatDictEntry Aura 9 5
                , makeStatDictEntry Morality 4 6
                ]
        , experience = 7
        , statPoints = 22
        , gold = 429
        , inventory =
            [ ShortSword
            , Shield
            , Torch
            , Ring
            , Potions
            ]
        }


makeStatDictEntry : CharacterStat -> Int -> Int -> ( String, StatHolder )
makeStatDictEntry stat value order =
    let
        statString =
            characterStatToString stat
    in
    ( statString, { stat = stat, value = value, order = order } )


characterStatToString : CharacterStat -> String
characterStatToString stat =
    case stat of
        Strength ->
            "Strength"

        Vitality ->
            "Vitality"

        Agility ->
            "Agility"

        Intelligence ->
            "Intelligence"

        Luck ->
            "Luck"

        Aura ->
            "Aura"

        Morality ->
            "Morality"


initJsonCharacterString : String
initJsonCharacterString =
    "{\"Class\":\"Wanderer\",\"Name\":\"Bilbo\",\"Experience\":7,\"StatPoints\":22,\"Gold\":429,\"Stats\":{\"Agility\":10,\"Aura\":9,\"Intelligence\":12,\"Luck\":9,\"Morality\":4,\"Strength\":11,\"Vitality\":6},\"Inventory\":[\"Short Sword\",\"Shield\",\"Torch\",\"Ring\",\"Potions\"]}"

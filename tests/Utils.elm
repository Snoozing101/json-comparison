module Utils exposing (initCharacter, initJsonCharacterString)

import Character exposing (Character(..), CharacterClass(..), CharacterStat(..), Item(..))
import Dict exposing (Dict)


initCharacter : Character
initCharacter =
    Character
        { class = Wanderer
        , name = Just "Bilbo"
        , stats =
            Dict.fromList
                [ Character.makeStatDictEntry Strength 11
                , Character.makeStatDictEntry Vitality 6
                , Character.makeStatDictEntry Agility 10
                , Character.makeStatDictEntry Intelligence 12
                , Character.makeStatDictEntry Luck 9
                , Character.makeStatDictEntry Aura 9
                , Character.makeStatDictEntry Morality 4
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


initJsonCharacterString : String
initJsonCharacterString =
    "{\"Class\":\"Wanderer\",\"Name\":\"Bilbo\",\"Experience\":7,\"StatPoints\":22,\"Gold\":429,\"Stats\":{\"Agility\":10,\"Aura\":9,\"Intelligence\":12,\"Luck\":9,\"Morality\":4,\"Strength\":11,\"Vitality\":6},\"Inventory\":[\"Short Sword\",\"Shield\",\"Torch\",\"Ring\",\"Potions\"]}"

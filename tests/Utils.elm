module Utils exposing(initCharacter, initJsonCharacterString)

import Character exposing (Character(..), CharacterClass(..), CharacterStat(..), Item(..))
import Dict exposing(Dict)

initCharacter : Character
initCharacter =
    Character
        { class = Wanderer
        , name = Just "Bilbo"
        , stats =
            Dict.fromList
                [ Character.makeStatDictEntry Strength 11 0
                , Character.makeStatDictEntry Vitality 6 1
                , Character.makeStatDictEntry Agility 10 2
                , Character.makeStatDictEntry Intelligence 12 3
                , Character.makeStatDictEntry Luck 9 4
                , Character.makeStatDictEntry Aura 9 5
                , Character.makeStatDictEntry Morality 4 6
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

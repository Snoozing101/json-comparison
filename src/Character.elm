module Character exposing
    ( Character(..)
    , CharacterClass(..)
    , CharacterStat(..)
    , Item(..)
    , StatHolder
    , characterStatToString
    , classToString
    , getCharacterStatOrder
    , itemToString
    , makeStatDictEntry
    , stringToCharacterStat
    , stringToItem
    )

import Dict exposing (Dict)


type Character
    = Character
        { class : CharacterClass
        , name : Maybe String
        , stats : Dict String StatHolder
        , experience : Int
        , statPoints : Int
        , gold : Int
        , inventory : List Item
        }


type CharacterClass
    = Wanderer
    | Cleric
    | Magician
    | Warrior
    | Barbarian


type alias StatHolder =
    { stat : CharacterStat
    , value : Int
    , order : Int
    }


type CharacterStat
    = Strength
    | Vitality
    | Agility
    | Intelligence
    | Luck
    | Aura
    | Morality


type Item
    = TwoHandedSword
    | BroardSword
    | ShortSword
    | Axe
    | Mace
    | Flail
    | Dagger
    | Gauntlet
    | HeavyArmour
    | ChainArmour
    | LeatherArmour
    | HeavyRobe
    | GoldHelmet
    | Headpiece
    | Shield
    | Torch
    | Necronomicon
    | Scrolls
    | Ring
    | MysticAmulet
    | Sash
    | Cloak
    | HealingSalve
    | Potions


itemToString : Item -> String
itemToString item =
    case item of
        TwoHandedSword ->
            "2 Handed Sword"

        BroardSword ->
            "Broardsword"

        ShortSword ->
            "Short Sword"

        Axe ->
            "Axe"

        Mace ->
            "Mace"

        Flail ->
            "Flail"

        Dagger ->
            "Dagger"

        Gauntlet ->
            "Gauntlet"

        HeavyArmour ->
            "Heavy Armour"

        ChainArmour ->
            "Chain Armour"

        LeatherArmour ->
            "Leather Armour"

        HeavyRobe ->
            "Heavy Robe"

        GoldHelmet ->
            "Gold Helmet"

        Headpiece ->
            "Headpiece"

        Shield ->
            "Shield"

        Torch ->
            "Torch"

        Necronomicon ->
            "Necronomicon"

        Scrolls ->
            "Scrolls"

        Ring ->
            "Ring"

        MysticAmulet ->
            "Mystic Amulet"

        Sash ->
            "Sash"

        Cloak ->
            "Cloak"

        HealingSalve ->
            "Healing Salve"

        Potions ->
            "Potions"


classToString : CharacterClass -> String
classToString class =
    case class of
        Wanderer ->
            "Wanderer"

        Cleric ->
            "Cleric"

        Magician ->
            "Magician"

        Warrior ->
            "Warrior"

        Barbarian ->
            "Barbarian"


makeStatDictEntry : CharacterStat -> Int -> ( String, StatHolder )
makeStatDictEntry stat value =
    let
        statString =
            characterStatToString stat

        order =
            getCharacterStatOrder stat
    in
    ( statString, { stat = stat, value = value, order = order } )


getCharacterStatOrder : CharacterStat -> Int
getCharacterStatOrder stat =
    case stat of
        Strength ->
            0

        Vitality ->
            1

        Agility ->
            2

        Intelligence ->
            3

        Luck ->
            4

        Aura ->
            5

        Morality ->
            6


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


stringToCharacterStat : String -> CharacterStat
stringToCharacterStat stat =
    case stat of
        "Strength" ->
            Strength

        "Vitality" ->
            Vitality

        "Agility" ->
            Agility

        "Intelligence" ->
            Intelligence

        "Luck" ->
            Luck

        "Aura" ->
            Aura

        "Morality" ->
            Morality

        _ ->
            Strength


stringToItem : String -> Item
stringToItem item =
    case item of
        "TwoHandedSword" ->
            TwoHandedSword

        "BroardSword" ->
            BroardSword

        "Short Sword" ->
            ShortSword

        "Axe" ->
            Axe

        "Mace" ->
            Mace

        "Flail" ->
            Flail

        "Dagger" ->
            Dagger

        "Gauntlet" ->
            Gauntlet

        "HeavyArmour" ->
            HeavyArmour

        "ChainArmour" ->
            ChainArmour

        "LeatherArmour" ->
            LeatherArmour

        "HeavyRobe" ->
            HeavyRobe

        "GoldHelmet" ->
            GoldHelmet

        "Headpiece" ->
            Headpiece

        "Shield" ->
            Shield

        "Torch" ->
            Torch

        "Necronomicon" ->
            Necronomicon

        "Scrolls" ->
            Scrolls

        "Ring" ->
            Ring

        "MysticAmulet" ->
            MysticAmulet

        "Sash" ->
            Sash

        "Cloak" ->
            Cloak

        "HealingSalve" ->
            HealingSalve

        "Potions" ->
            Potions

        _ ->
            Potions

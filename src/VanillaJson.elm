module VanillaJson exposing (Character(..), CharacterClass(..), CharacterStat(..), Item(..), StatHolder, encodeCharacter)

import Dict exposing (Dict)
import Json.Encode exposing (object, string)


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


encodeCharacter : Character -> Json.Encode.Value
encodeCharacter (Character character) =
    object
        [ ( "Class", string (classToString character.class) )
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
        |> List.map itemToString


encodeStats : Dict String StatHolder -> Json.Encode.Value
encodeStats stats =
    stats
        |> Dict.toList
        |> List.map statEntryToJson
        |> Json.Encode.object


statEntryToJson : ( String, StatHolder ) -> ( String, Json.Encode.Value )
statEntryToJson ( key, statHolder ) =
    ( key, Json.Encode.int statHolder.value )


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

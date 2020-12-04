# Comparison of JSON encoders & decoders in Elm

These are 3 implementations of JSON encoders & decoders all doing the same thing,
but implemented in different ways so I can get a feel for the differences
between the methods.

The methods are:

    1. Vanilla - Using just what comes with the [standard JSON library](https://package.elm-lang.org/packages/elm/json/latest/)
    2. Pipeline - Adding [JSON pipeline library from NoRedInk](https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/latest/Json.Decode.Pipeline)
    3. Codec - Using the [Codec library from miniBill](https://package.elm-lang.org/packages/miniBill/elm-codec/latest/)

There is no UI to this, all experimentation is done with the unit tests using
[elm-test](https://github.com/elm-explorations/test).

## Types used for testing

Implementations should be able to successfully encode & decode the Character
type from & to JSON. This should be sufficiently complex to get a good feel for
the libraries & how they can be used.

```elm
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
```

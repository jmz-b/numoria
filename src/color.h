// Copyright (c) 1981-86 Robert A. Koeneke
// Copyright (c) 1987-94 James E. Wilson
//
// This work is free software released under the GNU General Public License
// version 2.0, and comes with ABSOLUTELY NO WARRANTY.
//
// See LICENSE and AUTHORS for more information.

#pragma once

// Types used by the color routines
typedef struct {
  int16_t i;     // allocation order
  int16_t slot;  // xterm 256-colour slot (16-255); see scripts/256colres.pl
} Color_t;

// NUMORIA_COLOR_LIST(X) expands X(name, index) for every named colour.
// Use it to generate constants, string tables, etc. without duplication.
#define NUMORIA_COLOR_LIST(X) \
    /* Greys */ \
    X(White                    , 0) \
    X(Light_Grey_High          , 1) \
    X(Light_Grey_Low           , 2) \
    X(Medium_Grey_High         , 3) \
    X(Medium_Grey_Low          , 4) \
    X(Dark_Grey_High           , 5) \
    X(Dark_Grey_Low            , 6) \
    X(Black                    , 7) \
    /* Standard */ \
    X(Light_Red                , 8) \
    X(Light_Green              , 9) \
    X(Light_Yellow             , 10) \
    X(Light_Blue               , 11) \
    X(Light_Orange             , 12) \
    X(Light_Purple             , 13) \
    X(Red                      , 14) \
    X(Green                    , 15) \
    X(Yellow                   , 16) \
    X(Blue                     , 17) \
    X(Orange                   , 18) \
    X(Purple                   , 19) \
    /* Now a Major Motion Picture */ \
    X(Dark_Red                 , 20) \
    X(Dark_Green               , 21) \
    X(Dark_Yellow              , 22) \
    X(Dark_Blue                , 23) \
    X(Dark_Orange              , 24) \
    X(Dark_Purple              , 25) \
    X(Cream                    , 26) \
    /* Amulets */ \
    X(Amber                    , 27) \
    X(Driftwood                , 28) \
    X(Coral                    , 29) \
    X(Agate                    , 30) \
    X(Ivory                    , 31) \
    X(Obsidian                 , 32) \
    X(Bone                     , 33) \
    X(Brass                    , 34) \
    X(Bronze                   , 35) \
    X(Pewter                   , 36) \
    X(Tortoise_Shell           , 37) \
    /* Metals */ \
    X(Aluminum                 , 38) \
    X(Cast_Iron                , 39) \
    X(Chromium                 , 40) \
    X(Copper                   , 41) \
    X(Gold                     , 42) \
    X(Iron                     , 43) \
    X(Magnesium                , 44) \
    X(Molybdenum               , 45) \
    X(Nickel                   , 46) \
    X(Rusty                    , 47) \
    X(Silver                   , 48) \
    X(Steel                    , 49) \
    X(Tin                      , 50) \
    X(Titanium                 , 51) \
    X(Tungsten                 , 52) \
    X(Zirconium                , 53) \
    X(Zinc                     , 54) \
    /* Monsters */ \
    X(Dirt                     , 55) \
    X(Leprous                  , 56) \
    X(Flesh                    , 57) \
    /* Well mine is. Your milage may vary */ \
    X(Disenchanting            , 58) \
    X(Rotting                  , 59) \
    X(Clay                     , 60) \
    X(Stone                    , 61) \
    X(Fire                     , 62) \
    X(Water                    , 63) \
    X(Earth                    , 64) \
    X(Air                      , 65) \
    X(Frost                    , 66) \
    X(Glowing                  , 67) \
    X(Gelatinous               , 68) \
    X(Umber                    , 69) \
    X(Crystal                  , 70) \
    /* Mushrooms */ \
    X(Brown                    , 71) \
    X(Ecru                     , 72) \
    X(Furry                    , 73) \
    X(Plaid                    , 74) \
    /* A very tricky Color to define as RGB */ \
    X(Slimy                    , 75) \
    X(Tan                      , 76) \
    X(Wooden                   , 77) \
    X(Wrinkled                 , 78) \
    /* Potions */ \
    X(Icky_Green               , 79) \
    X(Light_Brown              , 80) \
    X(Clear                    , 81) \
    X(Azure                    , 82) \
    X(Bubbling                 , 83) \
    /* Animation needed here... */ \
    X(Chartreuse               , 84) \
    X(Cloudy                   , 85) \
    X(Crimson                  , 86) \
    X(Cyan                     , 87) \
    X(Hazy                     , 88) \
    X(Indigo                   , 89) \
    X(Magenta                  , 90) \
    X(Metallic_Blue            , 91) \
    X(Metallic_Red             , 92) \
    X(Metallic_Green           , 93) \
    X(Metallic_Purple          , 94) \
    X(Misty                    , 95) \
    X(Pink                     , 96) \
    X(Puce                     , 97) \
    X(Smoky                    , 98) \
    X(Tangerine                , 99) \
    X(Violet                   , 100) \
    X(Vermilion                , 101) \
    /* Rocks */ \
    X(Alexandrite              , 102) \
    /* Emerald Green or Deep Red?? */ \
    X(Amethyst                 , 103) \
    X(Aquamarine               , 104) \
    X(Azurite                  , 105) \
    X(Beryl                    , 106) \
    /* Emerald or Aquamarine or another? */ \
    X(Bloodstone               , 107) \
    /* Green with flecks of Red */ \
    X(Calcite                  , 108) \
    X(Carnelian                , 109) \
    X(Corundum                 , 110) \
    /* Any Color it feels like */ \
    X(Diamond                  , 111) \
    X(Emerald                  , 112) \
    X(Fluorite                 , 113) \
    /* CaF{sub}2 */ \
    X(Garnet                   , 114) \
    X(Granite                  , 115) \
    X(Jade                     , 116) \
    X(Jasper                   , 117) \
    /* Carrot */ \
    X(Lapis_Lazuli             , 118) \
    X(Magma                    , 119) \
    X(Malachite                , 120) \
    /* Me! */ \
    X(Marble                   , 121) \
    X(Moonstone                , 122) \
    X(Onyx                     , 123) \
    X(Pearl                    , 124) \
    X(Quartz                   , 125) \
    X(Quartzite                , 126) \
    X(Rhodonite                , 127) \
    X(Ruby                     , 128) \
    /* Both of these are in fact types of */ \
    X(Sapphire                 , 129) \
    /* Corundum (above)... */ \
    X(Tiger_Eye                , 130) \
    X(Topaz                    , 131) \
    X(Turquoise                , 132) \
    /* Did I mention Im doing this by hand? */ \
    X(Zircon                   , 133) \
    /* Treasures */ \
    X(Food                     , 134) \
    /* Pizza-Colored? */ \
    X(Slime                    , 135) \
    X(Leather                  , 136) \
    X(Cord                     , 137) \
    /* This is getting like a Nabakov book */ \
    X(Paper                    , 138) \
    X(Old_Parchment            , 139) \
    /* "The circus across the park is */ \
    X(Apple                    , 140) \
    /* too loud." */ \
    X(Oil                      , 141) \
    X(Magic_Light              , 142) \
    X(Mud                      , 143) \
    X(Acid                     , 144) \
    X(Pottery                  , 145) \
    X(Wine                     , 146) \
    /* Villa Maria '86 */ \
    X(Mithril                  , 147) \
    /* Woods */ \
    X(Aspen                    , 148) \
    X(Balsa                    , 149) \
    X(Banyan                   , 150) \
    X(Birch                    , 151) \
    X(Cedar                    , 152) \
    X(Cottonwood               , 153) \
    X(Cypress                  , 154) \
    X(Dogwood                  , 155) \
    X(Elm                      , 156) \
    X(Eucalyptus               , 157) \
    X(Hemlock                  , 158) \
    X(Hickory                  , 159) \
    X(Ironwood                 , 160) \
    X(Locust                   , 161) \
    X(Mahogany                 , 162) \
    X(Maple                    , 163) \
    X(Mulberry                 , 164) \
    X(Oak                      , 165) \
    X(Pine                     , 166) \
    X(Redwood                  , 167) \
    X(Rosewood                 , 168) \
    X(Spruce                   , 169) \
    X(Sycamore                 , 170) \
    X(Teak                     , 171) \
    X(Walnut                   , 172) \
    /* Spells/Magic/Breath */ \
    X(Magic_Missile            , 173) \
    X(Poison_Gas               , 174) \
    X(Holy_Orb                 , 175) \
    /* New Colors */ \
    X(Lightning                , 176) \
    X(Deep_Black               , 177) \
    X(Shadow_And_Flame         , 178)

// Generate Color_Name constants from the list.
#define NUMORIA_MAKE_COLOR_CONST(name, idx) constexpr int16_t Color_##name = (idx);
NUMORIA_COLOR_LIST(NUMORIA_MAKE_COLOR_CONST)
#undef NUMORIA_MAKE_COLOR_CONST

/* Defined as a special case... */
constexpr int16_t Color_Random = SHRT_MAX;

/* Used when initializing terminal */
constexpr int16_t MAX_COLORS = 179;

extern Color_t colors[MAX_COLORS];

/* Defined as previous values */
#define Color_Opal                 Color_Random
#define Color_Multi_Hued           Color_Random
#define Color_Iridescent           Color_Random

#define Color_Input                Color_Light_Blue
#define Color_OK                   Color_Green
#define Color_Attention            Color_Yellow
#define Color_Warning              Color_Red
#define Color_Plain_Text           Color_White
#define Color_Title                Color_White
#define Color_Sub_Title            Color_Light_Grey_High
#define Color_Field                Color_White
#define Color_Non_Applicable       Color_Dark_Grey_High
#define Color_Information          Color_Cream

#define Color_Damned               Color_Red
#define Color_Magik                Color_Green
#define Color_Empty                Color_Dark_Grey_High

#define Color_Inventory_Book       Color_Old_Parchment
#define Color_Inventory_Food       Color_Food
#define Color_Inventory_Potion     Color_Light_Blue
#define Color_Inventory_Scroll     Color_Paper
#define Color_Inventory_Wand       Color_Iron
#define Color_Inventory_Staff      Color_Wooden
#define Color_Inventory_Ring       Color_Gold
#define Color_Inventory_Amulet     Color_Cream
#define Color_Inventory_Armour     Color_Iron
#define Color_Inventory_Weapon     Color_Steel
#define Color_Inventory_Misc       Color_Light_Grey_High
#define Color_Inventory_Enchanted  Color_Green

#define Color_Floor                Color_Dark_Grey_High
#define Color_Wall                 Color_Dark_Grey_High

#define Color_Default              Color_White

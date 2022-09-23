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
  int16_t i;  // allocation order
  uint8_t R;  // The full RGB specification for the color
  uint8_t G;  // for those players with 24 bit displays
  uint8_t B;  // (lucky so-and-so's...)
} Color_t;

/* Greys */
constexpr int16_t Color_White = 0;
constexpr int16_t Color_Light_Grey_High = 1;
constexpr int16_t Color_Light_Grey_Low = 2;
constexpr int16_t Color_Medium_Grey_High = 3;
constexpr int16_t Color_Medium_Grey_Low = 4;
constexpr int16_t Color_Dark_Grey_High = 5;
constexpr int16_t Color_Dark_Grey_Low = 6;
constexpr int16_t Color_Black = 7;

/* Standard */
constexpr int16_t Color_Light_Red = 8;
constexpr int16_t Color_Light_Green = 9;
constexpr int16_t Color_Light_Yellow = 10;
constexpr int16_t Color_Light_Blue = 11;
constexpr int16_t Color_Light_Orange = 12;
constexpr int16_t Color_Light_Purple = 13;
constexpr int16_t Color_Red = 14;
constexpr int16_t Color_Green = 15;
constexpr int16_t Color_Yellow = 16;
constexpr int16_t Color_Blue = 17;
constexpr int16_t Color_Orange = 18;
constexpr int16_t Color_Purple = 19;   /* Now a Major Motion Picture */
constexpr int16_t Color_Dark_Red = 20;
constexpr int16_t Color_Dark_Green = 21;
constexpr int16_t Color_Dark_Yellow = 22;
constexpr int16_t Color_Dark_Blue = 23;
constexpr int16_t Color_Dark_Orange = 24;
constexpr int16_t Color_Dark_Purple = 25;
constexpr int16_t Color_Cream = 26;

/* Amulets */
constexpr int16_t Color_Amber = 27;
constexpr int16_t Color_Driftwood = 28;
constexpr int16_t Color_Coral = 29;
constexpr int16_t Color_Agate = 30;
constexpr int16_t Color_Ivory = 31;
constexpr int16_t Color_Obsidian = 32;
constexpr int16_t Color_Bone = 33;
constexpr int16_t Color_Brass = 34;
constexpr int16_t Color_Bronze = 35;
constexpr int16_t Color_Pewter = 36;
constexpr int16_t Color_Tortoise_Shell = 37;

/* Metals */
constexpr int16_t Color_Aluminum = 38;
constexpr int16_t Color_Cast_Iron = 39;
constexpr int16_t Color_Chromium = 40;
constexpr int16_t Color_Copper = 41;
constexpr int16_t Color_Gold = 42;
constexpr int16_t Color_Iron = 43;
constexpr int16_t Color_Magnesium = 44;
constexpr int16_t Color_Molybdenum = 45;
constexpr int16_t Color_Nickel = 46;
constexpr int16_t Color_Rusty = 47;
constexpr int16_t Color_Silver = 48;
constexpr int16_t Color_Steel = 49;
constexpr int16_t Color_Tin = 50;
constexpr int16_t Color_Titanium = 51;
constexpr int16_t Color_Tungsten = 52;
constexpr int16_t Color_Zirconium = 53;
constexpr int16_t Color_Zinc = 54;

/* Monsters */
constexpr int16_t Color_Dirt = 55;
constexpr int16_t Color_Leprous = 56;
constexpr int16_t Color_Flesh = 57;  /* Well mine is. Your milage may vary */
constexpr int16_t Color_Disenchanting = 58;
constexpr int16_t Color_Rotting = 59;
constexpr int16_t Color_Clay = 60;
constexpr int16_t Color_Stone = 61;
constexpr int16_t Color_Fire = 62;
constexpr int16_t Color_Water = 63;
constexpr int16_t Color_Earth = 64;
constexpr int16_t Color_Air = 65;
constexpr int16_t Color_Frost = 66;
constexpr int16_t Color_Glowing = 67;
constexpr int16_t Color_Gelatinous = 68;
constexpr int16_t Color_Umber = 69;
constexpr int16_t Color_Crystal = 70;

/* Mushrooms */
constexpr int16_t Color_Brown = 71;
constexpr int16_t Color_Ecru = 72;
constexpr int16_t Color_Furry = 73;
constexpr int16_t Color_Plaid = 74;  /* A very tricky Color to define as RGB */
constexpr int16_t Color_Slimy = 75;
constexpr int16_t Color_Tan = 76;
constexpr int16_t Color_Wooden = 77;
constexpr int16_t Color_Wrinkled = 78;  /* Perhaps try some rayshade textures? */

/* Potions */
constexpr int16_t Color_Icky_Green = 79;
constexpr int16_t Color_Light_Brown = 80;
constexpr int16_t Color_Clear = 81;
constexpr int16_t Color_Azure = 82;
constexpr int16_t Color_Bubbling = 83;  /* Animation needed here... */
constexpr int16_t Color_Chartreuse = 84;
constexpr int16_t Color_Cloudy = 85;
constexpr int16_t Color_Crimson = 86;
constexpr int16_t Color_Cyan = 87;
constexpr int16_t Color_Hazy = 88;
constexpr int16_t Color_Indigo = 89;
constexpr int16_t Color_Magenta = 90;
constexpr int16_t Color_Metallic_Blue = 91;
constexpr int16_t Color_Metallic_Red = 92;
constexpr int16_t Color_Metallic_Green = 93;
constexpr int16_t Color_Metallic_Purple = 94;
constexpr int16_t Color_Misty = 95;
constexpr int16_t Color_Pink = 96;
constexpr int16_t Color_Puce = 97;
constexpr int16_t Color_Smoky = 98;
constexpr int16_t Color_Tangerine = 99;
constexpr int16_t Color_Violet = 100;
constexpr int16_t Color_Vermilion = 101;

/* Rocks */
constexpr int16_t Color_Alexandrite = 102;  /* Emerald Green or Deep Red?? */
constexpr int16_t Color_Amethyst = 103;
constexpr int16_t Color_Aquamarine = 104;
constexpr int16_t Color_Azurite = 105;
constexpr int16_t Color_Beryl = 106;  /* Emerald or Aquamarine or another? */
constexpr int16_t Color_Bloodstone = 107;  /* Green with flecks of Red */
constexpr int16_t Color_Calcite = 108;
constexpr int16_t Color_Carnelian = 109;
constexpr int16_t Color_Corundum = 110;  /* Any Color it feels like */
constexpr int16_t Color_Diamond = 111;
constexpr int16_t Color_Emerald = 112;
constexpr int16_t Color_Fluorite = 113;  /* CaF{sub}2 */
constexpr int16_t Color_Garnet = 114;
constexpr int16_t Color_Granite = 115;
constexpr int16_t Color_Jade = 116;
constexpr int16_t Color_Jasper = 117;  /* Carrot */
constexpr int16_t Color_Lapis_Lazuli = 118;
constexpr int16_t Color_Magma = 119;
constexpr int16_t Color_Malachite = 120;  /* Me! */
constexpr int16_t Color_Marble = 121;
constexpr int16_t Color_Moonstone = 122;
constexpr int16_t Color_Onyx = 123;
constexpr int16_t Color_Pearl = 124;
constexpr int16_t Color_Quartz = 125;
constexpr int16_t Color_Quartzite = 126;
constexpr int16_t Color_Rhodonite = 127;
constexpr int16_t Color_Ruby = 128;  /* Both of these are in fact types of */
constexpr int16_t Color_Sapphire = 129;  /* Corundum (above)...                */
constexpr int16_t Color_Tiger_Eye = 130;
constexpr int16_t Color_Topaz = 131;
constexpr int16_t Color_Turquoise = 132;  /* Did I mention Im doing this by hand? */
constexpr int16_t Color_Zircon = 133;

/* Treasures */
constexpr int16_t Color_Food = 134;  /* Pizza-Colored? */
constexpr int16_t Color_Slime = 135;
constexpr int16_t Color_Leather = 136;
constexpr int16_t Color_Cord = 137;  /* This is getting like a Nabakov book */
constexpr int16_t Color_Paper = 138;
constexpr int16_t Color_Old_Parchment = 139;  /* "The circus across the park is      */
constexpr int16_t Color_Apple = 140;  /* too loud."                          */
constexpr int16_t Color_Oil = 141;
constexpr int16_t Color_Magic_Light = 142;
constexpr int16_t Color_Mud = 143;
constexpr int16_t Color_Acid = 144;
constexpr int16_t Color_Pottery = 145;
constexpr int16_t Color_Wine = 146;  /* Villa Maria '86 */
constexpr int16_t Color_Mithril = 147;

/* Woods */
constexpr int16_t Color_Aspen = 148;
constexpr int16_t Color_Balsa = 149;
constexpr int16_t Color_Banyan = 150;
constexpr int16_t Color_Birch = 151;
constexpr int16_t Color_Cedar = 152;
constexpr int16_t Color_Cottonwood = 153;
constexpr int16_t Color_Cypress = 154;
constexpr int16_t Color_Dogwood = 155;
constexpr int16_t Color_Elm = 156;
constexpr int16_t Color_Eucalyptus = 157;
constexpr int16_t Color_Hemlock = 158;
constexpr int16_t Color_Hickory = 159;
constexpr int16_t Color_Ironwood = 160;
constexpr int16_t Color_Locust = 161;
constexpr int16_t Color_Mahogany = 162;
constexpr int16_t Color_Maple = 163;
constexpr int16_t Color_Mulberry = 164;
constexpr int16_t Color_Oak = 165;
constexpr int16_t Color_Pine = 166;
constexpr int16_t Color_Redwood = 167;
constexpr int16_t Color_Rosewood = 168;
constexpr int16_t Color_Spruce = 169;
constexpr int16_t Color_Sycamore = 170;
constexpr int16_t Color_Teak = 171;
constexpr int16_t Color_Walnut = 172;

/* Spells/Magic/Breath */
constexpr int16_t Color_Magic_Missile = 173;
constexpr int16_t Color_Poison_Gas = 174;
constexpr int16_t Color_Holy_Orb = 175;

/* New Colors */
constexpr int16_t Color_Lightning = 176;
constexpr int16_t Color_Deep_Black = 177;
constexpr int16_t Color_Shadow_And_Flame = 178;

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

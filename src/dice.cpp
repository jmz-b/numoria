// Copyright (c) 1981-86 Robert A. Koeneke
// Copyright (c) 1987-94 James E. Wilson
//
// This work is free software released under the GNU General Public License
// version 2.0, and comes with ABSOLUTELY NO WARRANTY.
//
// See LICENSE and AUTHORS for more information.

#include "headers.h"

// generates damage for 2d6 style dice rolls
int diceRoll(Dice_t die) {
    auto sum = 0;
    for (auto i = 0; i < die.dice; i++) {
        sum += randomNumber(die.sides);
    }
    return sum;
}

// Returns max dice roll value -RAK-
int maxDiceRoll(const Dice_t &dice) {
    return dice.dice * dice.sides;
}

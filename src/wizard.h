// Copyright (c) 1981-86 Robert A. Koeneke
// Copyright (c) 1987-94 James E. Wilson
//
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

bool enterWizardMode();
void wizardCureAll();
void wizardDropRandomItems();
void wizardJumpLevel();
void wizardGainExperience();
void wizardSummonMonster();
void wizardSummonRandomMonster();
void wizardLightUpDungeon();
void wizardCharacterAdjustment();
void wizardGenerateObject();
void wizardCreateObjects();
bool wizardRequestObjectId(int &id, const std::string &label, int start_id, int end_id);
local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
EasyBuff = E:GetModule("EasyBuff");

-- Castable_AuraGroups
-- Spells that I can cast, keyed by Group
-- ids and multi ids are keyed by rank
-- Foo = {ids={1=21,2=23,3=764}},multiIds={1=42,2=191},hasMulti=true}
local Castable_AuraGroups = {};
-- Trackable_Auras
-- Spells that my class can cast, keyed by ID
-- {ids={1,23,764}},multiIds={42,191}}
-- 23 = {group="ABC",multi=false,name="Foo",rank=1}
local Trackable_Auras = nil;
-- Tracking Spells (not auras)
local Tracking_By_Texture = {};



--[[
	Aura Groups
	Used to define/access shared information about an Aura
]]--
local EasyBuff_AuraGroups = {
	-- Druid
	MOTW = {
		class 	 = "DRUID",
		name     = "Marque du fauve",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Don du fauve"
	},
	Thorns = {
		class 	 = "DRUID",
		name     = "Epines",
		selfOnly = false,
		stacks   = false,
		multi 	 = nil
	},
	OOC = {
		class 	 = "DRUID",
		name     = "Augure de clarté",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	-- Hunter
	TSA = {
		class 	 = "HUNTER",
		name     = "Aura de précision",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AOTH = {
		class 	 = "HUNTER",
		name     = "Aspect du faucon",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AOTM = {
		class 	 = "HUNTER",
		multi 	 = nil,
		name     = "Aspect du singe",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AOTW = {
		class 	 = "HUNTER",
		name     = "Aspect de la nature",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AOTC = {
		class 	 = "HUNTER",
		name     = "Aspect du guépard",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AOTP = {
		class 	 = "HUNTER",
		name     = "Aspect de la meute",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	-- Mage
	AI = {
		class 	 = "MAGE",
		name     = "Intelligence des arcanes",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Illumination des arcanes"
	},
	IceArmor = {
		class 	 = "MAGE",
		name     = "Armure de glace",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	FrostArmor = {
		class 	 = "MAGE",
		name     = "Armure de givre",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	MageArmor = {
		class 	 = "MAGE",
		name     = "Armure du mage",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	IceBarrier = {
		class 	 = "MAGE",
		name     = "Barrière de glace",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	FrostWard = {
		class 	 = "MAGE",
		name     = "Gardien de givre",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	FireWard = {
		class 	 = "MAGE",
		name     = "Gardien de feu",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	ManaShield = {
		class 	 = "MAGE",
		name     = "Bouclier de mana",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	DampenMagic = {
		class 	 = "MAGE",
		name     = "Atténuation de la magie",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	AmplifyMagic = {
		class 	 = "MAGE",
		name     = "Amplification de la magie",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	-- Paladin
	BOM = {
		class 	 = "PALADIN",
		name     = "Bénédiction de puissance",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction de puissance supérieure"
	},
	BOW = {
		class 	 = "PALADIN",
		name     = "Bénédiction de sagesse",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction de sagesse supérieure",
	},
	BOSLV = {
		class 	 = "PALADIN",
		name     = "Bénédiction de salut",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction de salut supérieure"
	},
	BOK = {
		class 	 = "PALADIN",
		name     = "Bénédiction des rois",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction des rois supérieure"
	},
	BOSNC = {
		class 	 = "PALADIN",
		name     = "Bénédiction du sanctuaire",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction du sanctuaire supérieure"
	},
	BOL = {
		class 	 = "PALADIN",
		name     = "Bénédiction de lumière",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Bénédiction de lumière supérieure"
	},
	RFury = {
		class 	 = "PALADIN",
		name     = "Fureur vertueuse",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	DevoAura = {
		class 	 = "PALADIN",
		name     = "Aura de dévotion",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	ConsAura = {
		class 	 = "PALADIN",
		name     = "Aura de concentration",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	RetAura = {
		class 	 = "PALADIN",
		name     = "Aura de vindicte",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	FireAura = {
		class 	 = "PALADIN",
		name     = "Aura de résistance au Feu",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	FrostAura = {
		class 	 = "PALADIN",
		name     = "Aura de résistance au Givre",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	ShadowAura = {
		class 	 = "PALADIN",
		name     = "Aura de résistance à l'Ombre",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	-- Priest
	FORT = {
		class 	 = "PRIEST",
		name     = "Power Word: Fortitude",
		selfOnly = false,
		stacks   = false,
		multi 	 = "Prayer of Fortitude"
	},
	SP = {
		class 	 = "PRIEST",
		name     = "Shadow Protection",
		selfOnly = false,
		stacks   = false,
		multi    = "Prayer of Shadow Protection"
	},
	InnerFire = {
		class 	 = "PRIEST",
		name     = "Inner Fire",
		selfOnly = true,
		stacks   = 20,
		multi 	 = nil
	},
	Shadowform = {
		class 	 = "PRIEST",
		name     = "Shadowform",
		selfOnly = true,
		stacks   = false,
		multi 	 = nil
	},
	TouchWeakness = {
		class 	 = "PRIEST",
		name     = "Touch of Weakness",
		selfOnly = true,
		stacks   = 1,
		multi 	 = nil
	},
	-- Rogue
	-- Shaman
	LightningShield = {
		class 	 = "SHAMAN",
		name     = "Lightning Shield",
		selfOnly = true,
		stacks   = 3,
		multi 	 = nil
	},
	WaterShield = {
		class 	 = "SHAMAN",
		name     = "Water Shield",
		selfOnly = true,
		stacks   = 3,
		multi 	 = nil
	},
	EarthShield = {
		class 	 = "SHAMAN",
		name     = "Earth Shield",
		selfOnly = true,
		stacks   = 6,
		multi 	 = nil
	},
	WaterBreathing = {
		class 	 = "SHAMAN",
		name     = "Water Breathing",
		selfOnly = false,
		stacks   = false,
		multi 	 = nil
	},
	-- Warlock
	DemonArmor = {
		class 	 = "WARLOCK",
		name	 = "Demon Armor",
		selfOnly = true,
		stacks   = false,
		multi	 = nil
	},
	ShadowWard = {
		class 	 = "WARLOCK",
		name	 = "Shadow Ward",
		selfOnly = true,
		stacks   = false,
		multi	 = nil
	},
	DetectInvis = {
		class	 = "WARLOCK",
		name	 = "Detect Invisibility",
		selfOnly = false,
		stacks   = false,
		multi    = nil
	},
	UnendingBreath = {
		class 	 = "WARLOCK",
		name	 = "Unending Breath",
		selfOnly = false,
		stacks   = false,
		multi    = nil
	},
	-- Warrior
	-- Racial
};


--[[
	Tracking Types
	Used to define/access Tracking Type info
	Keyed by Tracking Spell ID
]]--
local EasyBuff_TrackingTypes = {
	-- Hunter
	["1494"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Beasts",
		spellId  = 1494,
		texture  = 132328
	},
	["19878"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Demons",
		spellId  = 19878,
		texture  = 136217
	},
	["19879"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Dragonkin",
		spellId  = 19879,
		texture  = 134153
	},
	["19880"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Elementals",
		spellId  = 19880,
		texture  = 135861
	},
	["19882"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Giants",
		spellId  = 19882,
		texture  = 132275
	},
	["19885"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Hidden",
		spellId  = 19885,
		texture  = 132320
	},
	["19883"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Humanoids",
		spellId  = 19883,
		texture  = 135942
	},
	["19884"] = {
		class 	 = "HUNTER",
		prof     = nil,
		name     = "Track Undead",
		spellId  = 19884,
		texture  = 136142
	},
	-- Professions
	["2383"] = {
		class 	 = nil,
		prof     = EasyBuff.PROFESSIONS["Herbalism"],
		name     = "Find Herbs",
		spellId  = 2383,
		texture  = 133939
	},
	["2580"] = {
		class 	 = nil,
		prof     = EasyBuff.PROFESSIONS["Mining"],
		name     = "Find Minerals",
		spellId  = 2580,
		texture  = 136025
	}
}

--[[
	Auras
	Used to define an Aura by SpellID
]]--
local EasyBuff_Auras = {
	-- Druid: Mark of the Wild
	["1126"] = {
		rank  = 1,
		group = "MOTW"
	},
	["5232"] = {
		rank  = 2,
		group = "MOTW"
	},
	["6756"] = {
		rank  = 3,
		group = "MOTW"
	},
	["5234"] = {
		rank  = 4,
		group = "MOTW"
	},
	["8907"] = {
		rank  = 5,
		group = "MOTW"
	},
	["9884"] = {
		rank  = 6,
		group = "MOTW"
	},
	["9885"] = {
		rank  = 7,
		group = "MOTW"
	},
	["26990"] = {
		rank  = 8,
		group = "MOTW"
	},
	-- Druid: Gift of the Wild
	["21849"] = {
		rank  = 1,
		group = "MOTW",
		multi = true
	},
	["21850"] = {
		rank  = 2,
		group = "MOTW",
		multi = true
	},
	["26991"] = {
		rank  = 3,
		group = "MOTW",
		multi = true
	},
	-- Druid: Thorns
	["467"] = {
		rank  = 1,
		group = "Thorns"
	},
	["782"] = {
		rank  = 2,
		group = "Thorns"
	},
	["1075"] = {
		rank  = 3,
		group = "Thorns"
	},
	["8914"] = {
		rank  = 4,
		group = "Thorns"
	},
	["9756"] = {
		rank  = 5,
		group = "Thorns"
	},
	["9910"] = {
		rank  = 6,
		group = "Thorns"
	},
	["26992"] = {
		rank  = 7,
		group = "Thorns"
	},
	-- Druid: Omen of Clarity
	["16864"] = {
		rank = 1,
		group = "OOC"
	},
	-- Hunter: Trueshot Aura
	["19506"] = {
		rank  = 1,
		group = "TSA"
	},
	["20905"] = {
		rank  = 2,
		group = "TSA"
	},
	["20906"] = {
		rank  = 3,
		group = "TSA"
	},
	["27066"] = {
		rank  = 4,
		group = "TSA"
	},
	-- Hunter: Aspect of the Hawk
	["13165"] = {
		rank  = 1,
		group = "AOTH"
	},
	["14318"] = {
		rank  = 2,
		group = "AOTH"
	},
	["14319"] = {
		rank  = 3,
		group = "AOTH"
	},
	["14320"] = {
		rank  = 4,
		group = "AOTH"
	},
	["14321"] = {
		rank  = 5,
		group = "AOTH"
	},
	["14322"] = {
		rank  = 6,
		group = "AOTH"
	},
	["25296"] = {
		rank  = 7,
		group = "AOTH"
	},
	["27044"] = {
		rank  = 8,
		group = "AOTH"
	},
	-- Hunter: Aspect of the Monkey
	["13163"] = {
		rank  = 1,
		group = "AOTM"
	},
	-- Hunter: Improved Aspect of the Monkey
	["19549"] = {
		rank  = 2,
		group = "AOTM"
	},
	["19550"] = {
		rank  = 3,
		group = "AOTM"
	},
	["19551"] = {
		rank  = 4,
		group = "AOTM"
	},
	["24386"] = {
		rank  = 5,
		group = "AOTM"
	},
	["24387"] = {
		rank  = 6,
		group = "AOTM"
	},
	-- Hunter: Aspect of the Wild
	["20043"] = {
		rank  = 1,
		group = "AOTW"
	},
	["20190"] = {
		rank  = 2,
		group = "AOTW"
	},
	["27045"] = {
		rank  = 3,
		group = "AOTW"
	},
	-- Hunter: Aspect of the Cheetah
	["5118"] = {
		rank  = 1,
		group = "AOTC"
	},
	-- Hunter: Aspect of the Pack
	["13159"] = {
		rank  = 1,
		group = "AOTP"
	},
	-- Mage: Arcane Intellect
	["1459"] = {
		rank  = 1,
		group = "AI"
	},
	["1460"] = {
		rank  = 2,
		group = "AI"
	},
	["1461"] = {
		rank  = 3,
		group = "AI"
	},
	["10156"] = {
		rank  = 4,
		group = "AI"
	},
	["10157"] = {
		rank  = 5,
		group = "AI"
	},
	["27126"] = {
		rank  = 6,
		group = "AI"
	},
	-- Mage: Arcane Brilliance
	["23028"] = {
		rank  = 1,
		group = "AI",
		multi = true
	},
	["27127"] = {
		rank  = 2,
		group = "AI",
		multi = true
	},
	-- Mage: Ice Armor
	["7302"] = {
		rank  = 1,
		group = "IceArmor"
	},
	["7320"] = {
		rank  = 2,
		group = "IceArmor"
	},
	["10219"] = {
		rank  = 3,
		group = "IceArmor"
	},
	["10220"] = {
		rank  = 4,
		group = "IceArmor"
	},
	["27124"] = {
		rank  = 5,
		group = "IceArmor"
	},
	-- Mage: Frost Armor
	["168"] = {
		rank  = 1,
		group = "FrostArmor"
	},
	["7300"] = {
		rank  = 2,
		group = "FrostArmor"
	},
	["7301"] = {
		rank  = 3,
		group = "FrostArmor"
	},
	-- Mage: Mage Armor
	["6117"] = {
		rank  = 1,
		group = "MageArmor"
	},
	["22782"] = {
		rank  = 2,
		group = "MageArmor"
	},
	["22783"] = {
		rank  = 3,
		group = "MageArmor"
	},
	["27125"] = {
		rank  = 3,
		group = "MageArmor"
	},
	-- Mage: Ice Barrier
	["11426"] = {
		rank  = 1,
		group = "IceBarrier"
	},
	["13031"] = {
		rank  = 2,
		group = "IceBarrier"
	},
	["13032"] = {
		rank  = 3,
		group = "IceBarrier"
	},
	["13033"] = {
		rank  = 4,
		group = "IceBarrier"
	},
	["27134"] = {
		rank  = 5,
		group = "IceBarrier"
	},
	["33405"] = {
		rank  = 6,
		group = "IceBarrier"
	},
	-- Mage: Frost Ward
	["6143"] = {
		rank  = 1,
		group = "FrostWard"
	},
	["8461"] = {
		rank  = 2,
		group = "FrostWard"
	},
	["8462"] = {
		rank  = 3,
		group = "FrostWard"
	},
	["10177"] = {
		rank  = 4,
		group = "FrostWard"
	},
	["28609"] = {
		rank  = 5,
		group = "FrostWard"
	},
	["23796"] = {
		rank  = 6,
		group = "FrostWard"
	},
	-- Mage: Fire Ward
	["543"] = {
		rank  = 1,
		group = "FireWard"
	},
	["8457"] = {
		rank  = 2,
		group = "FireWard"
	},
	["8458"] = {
		rank  = 3,
		group = "FireWard"
	},
	["10223"] = {
		rank  = 4,
		group = "FireWard"
	},
	["10225"] = {
		rank  = 5,
		group = "FireWard"
	},
	["27128"] = {
		rank  = 6,
		group = "FireWard"
	},
	-- Mage: Mana Shield
	["1463"] = {
		rank  = 1,
		group = "ManaShield"
	},
	["8494"] = {
		rank  = 2,
		group = "ManaShield"
	},
	["8495"] = {
		rank  = 3,
		group = "ManaShield"
	},
	["10191"] = {
		rank  = 4,
		group = "ManaShield"
	},
	["10192"] = {
		rank  = 5,
		group = "ManaShield"
	},
	["10193"] = {
		rank  = 6,
		group = "ManaShield"
	},
	["27131"] = {
		rank  = 7,
		group = "ManaShield"
	},
	-- Mage: Dampen Magic
	["604"] = {
		rank  = 1,
		group = "DampenMagic"
	},
	["8450"] = {
		rank  = 2,
		group = "DampenMagic"
	},
	["8451"] = {
		rank  = 3,
		group = "DampenMagic"
	},
	["10173"] = {
		rank  = 4,
		group = "DampenMagic"
	},
	["10174"] = {
		rank  = 5,
		group = "DampenMagic"
	},
	["33944"] = {
		rank  = 6,
		group = "DampenMagic"
	},
	-- Mage: Amplify Magic
	["1008"] = {
		rank  = 1,
		group = "AmplifyMagic"
	},
	["8455"] = {
		rank  = 2,
		group = "AmplifyMagic"
	},
	["10169"] = {
		rank  = 3,
		group = "AmplifyMagic"
	},
	["10170"] = {
		rank  = 4,
		group = "AmplifyMagic"
	},
	["27130"] = {
		rank  = 5,
		group = "AmplifyMagic"
	},
	["33946"] = {
		rank  = 6,
		group = "AmplifyMagic"
	},
	-- Paladin: Blessing of Might
	["19740"] = {
		rank  = 1,
		group = "BOM"
	},
	["19834"] = {
		rank  = 2,
		group = "BOM"
	},
	["19835"] = {
		rank  = 3,
		group = "BOM"
	},
	["19836"] = {
		rank  = 4,
		group = "BOM"
	},
	["19837"] = {
		rank  = 5,
		group = "BOM"
	},
	["19838"] = {
		rank  = 6,
		group = "BOM"
	},
	["25291"] = {
		rank  = 7,
		group = "BOM"
	},
	["27140"] = {
		rank  = 8,
		group = "BOM"
	},
	-- Paladin: Greater Blessing of Might
	["25782"] = {
		rank  = 1,
		group = "BOM",
		multi = true
	},
	["25916"] = {
		rank  = 2,
		group = "BOM",
		multi = true
	},
	["27141"] = {
		rank  = 3,
		group = "BOM",
		multi = true
	},
	-- Paladin: Blessing of Wisdom
	["19742"] = {
		rank  = 1,
		group = "BOW"
	},
	["19850"] = {
		rank  = 2,
		group = "BOW"
	},
	["19852"] = {
		rank  = 3,
		group = "BOW"
	},
	["19853"] = {
		rank  = 4,
		group = "BOW"
	},
	["19854"] = {
		rank  = 5,
		group = "BOW"
	},
	["25290"] = {
		rank  = 6,
		group = "BOW"
	},
	["27142"] = {
		rank  = 7,
		group = "BOW"
	},
	-- Paladin: Greater Blessing of Wisdom
	["25894"] = {
		rank  = 1,
		group = "BOW",
		multi = true
	},
	["25918"] = {
		rank  = 2,
		group = "BOW",
		multi = true
	},
	["27143"] = {
		rank  = 3,
		group = "BOW",
		multi = true
	},
	-- Paladin: Blessing of Salvation
	["1038"] = {
		rank  = 1,
		group = "BOSLV"
	},
	-- Paladin: Greater Blessing of Salvation
	["25895"] = {
		rank  = 1,
		group = "BOSLV",
		multi = true
	},
	-- Paladin: Blessing of Kings
	["20217"] = {
		rank  = 1,
		group = "BOK"
	},
	-- Paladin: Greater Blessing of Kings
	["25898"] = {
		rank  = 1,
		group = "BOK",
		multi = true
	},
	-- Paladin: Blessing of Sanctuary
	["20911"] = {
		rank  = 1,
		group = "BOSNC"
	},
	["20912"] = {
		rank  = 2,
		group = "BOSNC"
	},
	["20913"] = {
		rank  = 3,
		group = "BOSNC"
	},
	["20914"] = {
		rank  = 4,
		group = "BOSNC"
	},
	["27168"] = {
		rank  = 5,
		group = "BOSNC"
	},
	-- Paladin: Greater Blessing of Sanctuary
	["25899"] = {
		rank  = 1,
		group = "BOSNC",
		multi = true
	},
	["27169"] = {
		rank  = 2,
		group = "BOSNC",
		multi = true
	},
	-- Paladin: Blessing of Light
	["19977"] = {
		rank  = 1,
		group = "BOL"
	},
	["19978"] = {
		rank  = 2,
		group = "BOL"
	},
	["19979"] = {
		rank  = 3,
		group = "BOL"
	},
	["27144"] = {
		rank  = 4,
		group = "BOL"
	},
	-- Paladin: Greater Blessing of Light
	["25890"] = {
		rank  = 1,
		group = "BOL",
		multi = true
	},
	["27145"] = {
		rank  = 2,
		group = "BOL",
		multi = true
	},
	-- Paladin: Righteous Fury
	["25780"] = {
		rank  = 1,
		group = "RFury"
	},
	-- Paladin: Devotion Aura
	["465"] = {
		rank  = 1,
		group = "DevoAura"
	},
	["10290"] = {
		rank  = 2,
		group = "DevoAura"
	},
	["643"] = {
		rank  = 3,
		group = "DevoAura"
	},
	["10291"] = {
		rank  = 4,
		group = "DevoAura"
	},
	["1032"] = {
		rank  = 5,
		group = "DevoAura"
	},
	["10292"] = {
		rank  = 6,
		group = "DevoAura"
	},
	["10293"] = {
		rank  = 7,
		group = "DevoAura"
	},
	["27149"] = {
		rank  = 8,
		group = "DevoAura"
	},
	-- Paladin: Concentration Aura
	["19746"] = {
		rank  = 1,
		group = "ConsAura"
	},
	-- Paladin: Retribution Aura
	["7294"] = {
		rank  = 1,
		group = "RetAura"
	},
	["10298"] = {
		rank  = 2,
		group = "RetAura"
	},
	["10299"] = {
		rank  = 3,
		group = "RetAura"
	},
	["10300"] = {
		rank  = 4,
		group = "RetAura"
	},
	["10301"] = {
		rank  = 5,
		group = "RetAura"
	},
	["27150"] = {
		rank  = 6,
		group = "RetAura"
	},
	-- Paladin: Fire Resistance Aura
	["19891"] = {
		rank  = 1,
		group = "FireAura"
	},
	["19899"] = {
		rank  = 2,
		group = "FireAura"
	},
	["19900"] = {
		rank  = 3,
		group = "FireAura"
	},
	["27153"] = {
		rank  = 4,
		group = "FireAura"
	},
	-- Paladin: Frost Resistance Aura
	["19888"] = {
		rank  = 1,
		group = "FrostAura"
	},
	["19897"] = {
		rank  = 2,
		group = "FrostAura"
	},
	["19898"] = {
		rank  = 3,
		group = "FrostAura"
	},
	["27152"] = {
		rank  = 4,
		group = "FrostAura"
	},
	-- Paladin: Shadow Resistance Aura
	["19876"] = {
		rank  = 1,
		group = "ShadowAura"
	},
	["19895"] = {
		rank  = 2,
		group = "ShadowAura"
	},
	["19896"] = {
		rank  = 3,
		group = "ShadowAura"
	},
	["27151"] = {
		rank  = 4,
		group = "ShadowAura"
	},
	-- Priest: Power Word: Fortitude
	["1243"] = {
		rank  = 1,
		group = "FORT"
	},
	["1244"] = {
		rank  = 2,
		group = "FORT"
	},
	["1245"] = {
		rank  = 3,
		group = "FORT"
	},
	["2791"] = {
		rank  = 4,
		group = "FORT"
	},
	["10937"] = {
		rank  = 5,
		group = "FORT"
	},
	["10938"] = {
		rank  = 6,
		group = "FORT"
	},
	["25389"] = {
		rank  = 7,
		group = "FORT"
	},
	-- Priest: Prayer of Fortitude
	["21562"] = {
		rank  = 1,
		group = "FORT",
		multi = true
	},
	["21564"] = {
		rank  = 2,
		group = "FORT",
		multi = true
	},
	["25392"] = {
		rank  = 3,
		group = "FORT",
		multi = true
	},
	-- Priest: Shadow Protection
	["976"] = {
		rank  = 1,
		group = "SP"
	},
	["10957"] = {
		rank  = 2,
		group = "SP"
	},
	["10958"] = {
		rank  = 3,
		group = "SP"
	},
	["25433"] = {
		rank  = 4,
		group = "SP"
	},
	-- Priest: Prayer of Shadow Protection
	["27683"] = {
		rank  = 1,
		group = "SP",
		multi = true
	},
	["39374"] = {
		rank  = 2,
		group = "SP",
		multi = true
	},
	-- Priest: Inner Fire
	["588"] = {
		rank  = 1,
		group = "InnerFire"
	},
	["7128"] = {
		rank  = 2,
		group = "InnerFire"
	},
	["602"] = {
		rank  = 3,
		group = "InnerFire"
	},
	["1006"] = {
		rank  = 4,
		group = "InnerFire"
	},
	["10951"] = {
		rank  = 5,
		group = "InnerFire"
	},
	["10952"] = {
		rank  = 6,
		group = "InnerFire"
	},
	["25431"] = {
		rank  = 7,
		group = "InnerFire"
	},
	-- Priest: Touch of Weakness
	["2652"] = {
		rank  = 1,
		group = "TouchWeakness"
	},
	["19261"] = {
		rank  = 2,
		group = "TouchWeakness"
	},
	["19262"] = {
		rank  = 3,
		group = "TouchWeakness"
	},
	["19264"] = {
		rank  = 4,
		group = "TouchWeakness"
	},
	["19265"] = {
		rank  = 5,
		group = "TouchWeakness"
	},
	["19266"] = {
		rank  = 6,
		group = "TouchWeakness"
	},
	["25461"] = {
		rank  = 7,
		group = "TouchWeakness"
	},
	-- Priest: Shadowform
	["15473"] = {
		rank  = 1,
		group = "Shadowform"
	},
	-- Shaman: Lightning Shield
	["324"] = {
		rank = 1,
		group = "LightningShield"
	},
	["325"] = {
		rank = 2,
		group = "LightningShield"
	},
	["905"] = {
		rank = 3,
		group = "LightningShield"
	},
	["945"] = {
		rank = 4,
		group = "LightningShield"
	},
	["8134"] = {
		rank = 5,
		group = "LightningShield"
	},
	["10431"] = {
		rank = 6,
		group = "LightningShield"
	},
	["10432"] = {
		rank = 7,
		group = "LightningShield"
	},
	["25469"] = {
		rank = 8,
		group = "LightningShield"
	},
	["25472"] = {
		rank = 9,
		group = "LightningShield"
	},
	-- Shaman: Earth Shield
	["974"] = {
		rank = 1,
		group = "EarthShield"
	},
	["32593"] = {
		rank = 2,
		group = "EarthShield"
	},
	["32594"] = {
		rank = 3,
		group = "EarthShield"
	},
	-- Shaman: Water Shield
	["24398"] = {
		rank = 1,
		group = "WaterShield"
	},
	["33736"] = {
		rank = 2,
		group = "WaterShield"
	},
	-- Shaman: Water Breathing
	["131"] = {
		rank = 1,
		group = "WaterBreathing"
	},
	-- Warlock: Demon Armor
	["706"] = {
		rank  = 1,
		group = "DemonArmor"
	},
	["1086"] = {
		rank  = 2,
		group = "DemonArmor"
	},
	["11733"] = {
		rank  = 3,
		group = "DemonArmor"
	},
	["11734"] = {
		rank  = 4,
		group = "DemonArmor"
	},
	["11735"] = {
		rank  = 5,
		group = "DemonArmor"
	},
	["27260"] = {
		rank  = 6,
		group = "DemonArmor"
	},
	-- Warlock: Shadow Ward
	["6229"] = {
		rank  = 1,
		group = "ShadowWard"
	},
	["11739"] = {
		rank  = 2,
		group = "ShadowWard"
	},
	["11740"] = {
		rank  = 3,
		group = "ShadowWard"
	},
	["28610"] = {
		rank  = 4,
		group = "ShadowWard"
	},
	-- Warlock: Detect Invisibility
	["132"] = {
		rank  = 1,
		group = "DetectInvis"
	},
	["2970"] = {
		rank  = 2,
		group = "DetectInvis"
	},
	["11743"] = {
		rank  = 3,
		group = "DetectInvis"
	},
	-- Warlock: Unending Breath
	["5697"] = {
		rank  = 1,
		group = "UnendingBreath"
	}
};


--[[
	Init Auras
	Initialize the Castable and Trackable Auras for the current player
]]--
function EasyBuff:InitAuras()
	EasyBuff:Debug("EasyBuff:InitAuras", 1);
	local bookTabs = GetNumSpellTabs();
	local totalSpells = 0;

	-- Get the Spells I can cast, and create the Trackable_Auras list.
	for bookTabIndex=1, bookTabs do
		local bookTabName, bookTabTexture, bookTabOffset, bookTabSpellCnt, _, _ = GetSpellTabInfo(bookTabIndex);
		totalSpells = totalSpells + bookTabSpellCnt;
	end

	for spellIndex=1, totalSpells do
		local spellName, spellSubName = GetSpellBookItemName(spellIndex, BOOKTYPE_SPELL);
		local testName = spellName;
		if (spellSubName ~= nil and spellSubName ~= "") then
			testName = format("%s(%s)", spellName, spellSubName);
		end
		local spellName, _, spellIcon, castTime, minRange, maxRange, spellId = GetSpellInfo(testName);
		
		-- Is this spell defined in our list of monitored Auras?
		local aura = EasyBuff_Auras[tostring(spellId)];
		if (aura) then
			local auraGroup = EasyBuff_AuraGroups[aura.group];
			if (auraGroup ~= nil) then
				if (Trackable_Auras == nil) then
					Trackable_Auras = {}
				end
				Trackable_Auras[tostring(spellId)] = {
					group = aura.group,
					multi = aura.multi,
					name = spellName,
					rank = aura.rank
				};
			end
		else
			-- Is this spell defined in our list of Tracking Types?
			local trackingType = EasyBuff_TrackingTypes[tostring(spellId)];
			if (trackingType) then
				-- Add this Tracking Type to the list of Tracking items by Texture.
				Tracking_By_Texture[trackingType.texture] = trackingType;
			end
		end
	end

	-- Create the Castable_AuraGroups list from AuraGroups for my class
	for k, v in pairs(EasyBuff_Auras) do
		if (v ~= nil) then
			-- Get the AuraGroup for this Spell.
			auraGroup = EasyBuff_AuraGroups[v.group];
			if (auraGroup ~= nil) then
				-- Get the Spell Info
				local spellName, _, spellIcon, castTime, minRange, maxRange, spellId = GetSpellInfo(k);
				-- Can I cast this spell?
				if ((auraGroup.class ~= nil and L[auraGroup.class] == EasyBuff.PLAYER_CLASS)
					or (auraGroup.prof ~= nil and EasyBuff.PlayerProfessions[auraGroup.prof])) then
					if (Castable_AuraGroups[v.group] == nil) then
						Castable_AuraGroups[v.group] = {ids={},multiIds={},hasMulti=false};
					end
					if (v.multi) then
						Castable_AuraGroups[v.group].hasMulti = true;
						Castable_AuraGroups[v.group].multiIds[v.rank] = spellId;
					else
						Castable_AuraGroups[v.group].ids[v.rank] = spellId;
					end
					Castable_AuraGroups[v.group].selfOnly = auraGroup.selfOnly;
					Castable_AuraGroups[v.group].stacks = 1;
					if (auraGroup.stacks and auraGroup.stacks > 1) then
						Castable_AuraGroups[v.group].stacks = auraGroup.stacks;
					end
				end
			end
		end
	end
end


--[[
	Get Available Aura Groups for Class & Professions
]]--
function EasyBuff:GetAvailableAuraGroups(className)
	local auras = nil;

	for k, v in pairs(EasyBuff_AuraGroups) do
		if (auras == nil) then
			auras = {};
		end
		if ((v.class == className) or (v.class == nil and EasyBuff.PlayerProfessions[v.prof] == true)) then
			auras[k] = v;
		end
	end

	return auras;
end


--[[
	Get Available Tracking Abilities
	Keyed by Texture
]]--
function EasyBuff:GetAvailableTrackingAbilities()
	return Tracking_By_Texture;
end


--[[
	Get Spell ID for Tracking Ability
]]--
function EasyBuff:GetSpellIdForTracking(textureId)
	if (Tracking_By_Texture[textureId] ~= nil) then
		return Tracking_By_Texture[textureId].spellId;
	end
	return nil;
end


--[[
	Get Tracked Spells
]]--
function EasyBuff:GetTrackedSpells()
	return Trackable_Auras;
end


--[[
	Get Tracked Spell by ID
]]--
function EasyBuff:GetTrackedSpell(id)
	local k = tostring(id);
	if (Trackable_Auras ~= nil and Trackable_Auras[k]) then
		return Trackable_Auras[k];
	end
	return nil;
end


--[[
	Get Castable Aura Group by Group Name
]]--
function EasyBuff:GetAuraGroup(groupName)
	return Castable_AuraGroups[groupName];
end


--[[
	Get Castable Group Spell
]]--
function EasyBuff:GetCastableGroupSpell(groupName, multi)
	local group = Castable_AuraGroups[groupName];
	local highestRank = 1;
	if (group ~= nil) then
		if (multi and group.hasMulti) then
			highestRank = table.getn(group.multiIds);
			return group.multiIds[highestRank];
		else
			highestRank = table.getn(group.ids);
			return group.ids[highestRank];
		end
	end
	return nil;
end


--[[
	Get Aura Group by Spell Id
]]--
function EasyBuff:GetAuraGroupBySpellId(spellId)
	local aura = EasyBuff:GetTrackedSpell(spellId);
	if (aura ~= nil) then
		return aura.group, EasyBuff:GetAuraGroup(aura.group);
	end
	return nil, nil;
end


--[[
	Get Unit Buff
	Wrapper for UnitBuff so I don't have to keep looking up the index values
]]--
function EasyBuff:UnitBuff(unit, index, filter)
	local name, icon, count, debuffType, duration, expirationTime, source, isStealable, 
  		nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod
		= UnitBuff(unit, index, filter);

	if (name == nil and spellId == nil) then
		return nil;
	end

	local a_, auraGroup = EasyBuff:GetAuraGroupBySpellId(spellId);
	local maxCount = 1;
	if (auraGroup ~= nil and auraGroup.stacks) then maxCount = auraGroup.stacks end;

	local curTime = GetTime();

	return {
		name = name,
		icon = icon,
		count = count,
		maxCount = maxCount,
		debuffType = debuffType,
		duration = duration,
		expirationTime = expirationTime,
		remainingTime = (expirationTime - curTime),
		source = source,
		isStealable = isStealable,
		nameplateShowPersonal = nameplateShowPersonal,
		spellId = spellId,
		canApplyAura = canApplyAura,
		isBossDebuff = isBossDebuff,
		castByPlayer = castByPlayer,
		nameplateShowAll = nameplateShowAll,
		timeMod = timeMod
	};
end

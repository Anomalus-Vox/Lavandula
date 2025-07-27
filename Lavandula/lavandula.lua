--Pseudocode and Resources
SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true,
    }
end
SMODS.Atlas{
    key = 'prideJ',
    path = 'prideJ.png',
    px = 71,
    py = 95,
}

SMODS.Rarity{
    key = 'Bridget',
    loc_txt = { name = 'Bridget' },
    badge_colour = G.C.DARK_EDITION,
    pools = { ["Joker"] = true },
}
SMODS.Rarity{
    key = 'Secret',
    loc_txt = { name = 'Secret' },
    badge_colour = G.C.SUITS.Spades,
    pools = { ["Joker"] = true },
}
SMODS.ObjectType{
	object_type = "ObjectType",
	key = "Lavender",
	default = "j_pride_mlmpride",
	cards = { 
        ["j_pride_lesbianpride"] = true, ["j_pride_acepride"] = true, ["j_pride_progresspride"] = true, ["j_pride_genderfluid"] = true, ["j_pride_nonbinary"] = true, ["j_pride_parade"] = true, 
        ["j_pride_fonv"] = true, ["j_pride_topsurg"] = true, ["j_pride_orchi"] = true, ["j_pride_stonewall"] = true, ["j_pride_pronouns"] = true, ["j_pride_celestialmt"] = true, 
        ["j_pride_diva"] = true, ["j_pride_lgbtqplus"] = true, ["j_pride_doublerainbow"] = true, ["j_pride_blahaj"] = true, ["j_pride_gospinny"] = true, ["j_pride_polycule"] = true, ["j_pride_rainbowcap"] = true
	}
}

SMODS.Consumable{
    key = 'estradiol',
    set = 'Spectral',
    atlas = 'prideJ',
    pos = { x = 0 , y = 6 },
    loc_txt = {
        name = "Estradiol",
        text = { "Changes all {C:attention}Kings{} in your deck to {C:attention}Queens.{}",
    "{C:inactive,E:2,s:0.6}\"Cracks eggs.\""}, -- ref to "egg" in trans culture
    },
    can_use = function(self, card) 
        return true
    end,
    use = function(self, card, area, copier)
        for k, v in pairs(G.playing_cards) do
            if next(SMODS.find_card('j_pride_genderfluid')) then
                if G.playing_cards[k]:is_face() then
                    assert(SMODS.change_base(G.playing_cards[k], nil, 'Queen'))
                end
            elseif G.playing_cards[k]:get_id() == 13 then
                assert(SMODS.change_base(G.playing_cards[k], nil, 'Queen'))
            end
        end
        for k, v in pairs(SMODS.find_card('j_egg')) do
            v:set_ability('j_pride_crackedegg')
            v:juice_up()
            v:set_cost()
        end
    end
}
SMODS.Consumable{
    key = 'testosterone',
    set = 'Spectral',
    atlas = 'prideJ',
    pos = { x = 1 , y = 6 },
    loc_txt = {
        name = "Testosterone",
        text = { "Changes all {C:attention}Queens{} in your deck to {C:attention}Kings{}.",
    "{C:inactive,E:2,s:0.6}\"Cracks eggs.\""}, -- ref to "egg" in trans culture
    },
    can_use = function(self, card) 
        return true
    end,
    use = function(self, card, area, copier)
        for k, v in pairs(G.playing_cards) do
            if next(SMODS.find_card('j_pride_genderfluid')) then
                if G.playing_cards[k]:is_face() then
                    assert(SMODS.change_base(G.playing_cards[k], nil, 'Queen'))
                end
            elseif G.playing_cards[k]:get_id() == 12 then
                assert(SMODS.change_base(G.playing_cards[k], nil, 'King'))
            end
        end
        for k, v in pairs(SMODS.find_card('j_egg')) do
            v:set_ability('j_pride_crackedegg')
            v:juice_up()
            v:set_cost()
        end
    end
}
--[[
Consumables
Estradiol: similar=strength?
	for each card in deck:
		if card.rank=king
			change card to queen
	if player.jokers includes egg
		tempvar power = egg.sellval
		destroy egg (display Cracked!)
		add crackedegg to player.jokers
		set crackedegg.sellval to power
Testosterone: similar=strength?
	for each card in deck:
		if card.rank=queen
			change card to king
	if player.jokers includes egg
		tempvar power = egg.sellval
		destroy egg (display Cracked!)
		add crackedegg to player.jokers
		set crackedegg.sellval to power
                                                    Rainbow: similar=judgment, topuptag
                                                        add (game.jokers.pool[Prideful].randomseed(smth))
]]
SMODS.Consumable{
    key = "aurora",
    set = "Tarot",
    atlas = 'prideJ',
    pos = { x = 2 , y = 6 },
    loc_txt = {
        name = "Aurora",
        text={
        "Creates a random",
        "{C:attention}Lavandula Joker{}.",
        "{C:inactive}(must have room){}",
        "{C:inactive,s:0.6}\"Localized entirely within this card?\"" -- Superintendent Chalmers, The Simpsons
        },
    },
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        if (pseudorandom("auroraborealis") < (G.GAME.probabilities.normal/150)) then
            SMODS.add_card({key = "j_pride_bridget"})
        else
        SMODS.add_card({set = "Lavender"})
        end
    end,
    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end
}
--Gay Pride: similar=runner, seeing_double
SMODS.Joker{
    key = 'mlmpride',
    loc_txt= {
        name = 'MLM Pride',
        text = {  "If your scored hand contains",
        "a {C:attention}Pair of Kings{}, gain {C:chips}+#1# Chips{}.",
        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}",
        "{C:inactive,s:0.6}\"...and they were roommates.\"" -- Vine meme
    }},
    atlas = 'prideJ',
    pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {chips = 0, add = 8}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.chips}  }
	end,
    calculate = function(self, card, context) 
        if context.before and not context.blueprint then
            local gaysintheclub = 0
            if next(SMODS.find_card('j_pride_genderfluid')) then
                for i = 1, #context.full_hand do
                    if context.full_hand[i]:is_face() then
                        gaysintheclub = gaysintheclub + 1
                    end
                end
            else
                for i = 1, #context.full_hand do
                    if context.full_hand[i]:get_id() == 13 then
                        gaysintheclub = gaysintheclub + 1
                    end
                end
            end
            if gaysintheclub > 1 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
                return {
                    message = "Gay!",
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main and (card.ability.extra.chips > 0) then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips
			}
		end
    end
}
--Lesbian Pride: similar=runner, seeing_double
SMODS.Joker{
    key = 'lesbianpride',
    loc_txt= {
        name = 'Lesbian Pride',
        text = {  "If your scored hand contains",
        "a {C:attention}Pair of Queens{}, gain {C:mult}+#1# Mult{}.",
        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
        "{C:inactive,s:0.6}\"Break out the L-word.\"" --Scott Pilgrim vs The World
    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 0 },
    rarity = 1,
    cost = 4,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 0, add = 2}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context) 
        if context.before and not context.blueprint then
            local gaysintheclub = 0
            if next(SMODS.find_card('j_pride_genderfluid')) then
                for i = 1, #context.full_hand do
                    if context.full_hand[i]:is_face() then
                        gaysintheclub = gaysintheclub + 1
                    end
                end
            else
                for i = 1, #context.full_hand do
                    if context.full_hand[i]:get_id() == 12 then
                        gaysintheclub = gaysintheclub + 1
                    end
                end
            end
            if gaysintheclub > 1 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                return {
                    message = "Gay!",
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and (card.ability.extra.mult > 0) then
			return {
				message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
				mult_mod = card.ability.extra.mult
			}
		end
    end
}
--Ace Pride: similar=perkeo, vagabond, golden_ticket
SMODS.Joker{
    key = 'acepride',
    loc_txt= {
        name = 'Ace Pride',
        text = {  "If your played hand is",
        "a {C:attention}single Ace{}, create",
        "a random {C:attention}negative{}",
        "{C:attention}consumable{}.",
        "{C:inactive,s:0.6}\"The only card I need...\"" --Ace of Spades - Motorhead
    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 0 },
    rarity = 2,
    cost = 7,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {consume = 1}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.rev, center.ability.extra.consume }  }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            local aces = 0
            local numCard = 0
            local gimme = card.ability.extra.consume
            for i = 1, #context.full_hand do
                numCard = numCard + 1
                if context.full_hand[i]:get_id() == 14 then
                    aces = aces + 1
                end
            end
            if aces == 1 and numCard == 1 then
                for j = 1, gimme do
                    local cardgen = create_card("Consumeables", G.Consumeables, nil, nil, nil, nil, nil, 'acepride')
                    cardgen:set_edition('e_negative', true)
                    cardgen:add_to_deck()
                    G.consumeables:emplace(cardgen)
                end
                return { 
                    message = "Aced!",
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end
}
--Progress Pride: similar=baseball_card, cryptid jokers?
SMODS.Joker{
    key = 'progresspride',
    loc_txt= {
        name = 'Progress Pride',
        text = { "{C:attention}Played cards{} with {C:dark_edition}editions{} grant {X:mult,C:white}X#1#{} Mult.",
        "{C:inactive,s:0.6}\"Embrace progress!\"" --viktor, LoL
    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 0 },
    rarity = 2,
    cost = 6,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult_ed = 1.5}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult_ed}  }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition then
                return {
                    xmult = card.ability.extra.xmult_ed,
					card = context.other_card
				}
            end
        end
    end
}
--Gender Fluid: similar=decimal_rank(unstable)
SMODS.Joker{
    key = 'genderfluid',
    loc_txt= {
        name = 'Gender Fluid',
        text = { "Face cards played or held in hand",
        "count as {C:attention}Jacks, Queens and Kings.{}",
        "{C:inactive,s:0.6}\"Gender has no bearing on ability.\""} -- Dark Souls
    },
    atlas = 'prideJ',
    pos = { x = 0, y = 2 },
    rarity = 3,
    cost = 10,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
}
--Binary Breaker: similar=this.genderfluid
SMODS.Joker{
    key = 'nonbinary',
    loc_txt= {
        name = 'Binary Breaker',
        text = {  "{C:attention}2{}s and {C:attention}10{}s count as {C:attention}each other.",
            "{C:inactive,s:0.6}\"Can you read between the lines of code?\"" --Codebreaker - Aviators
    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 2 },
    rarity = 3,
    cost = 8,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
}
--Parade: similar=ridethebus, runner
SMODS.Joker{
    key = 'parade',
    loc_txt= {
        name = 'Parade',
        text = {  "{C:mult}+#3# Mult{} and {C:chips}+#4# Chips{} per played hand.",
        "Resets if the played hand",
        "contains a {C:attention}Straight{} or {C:attention}Flush{}.",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult/{C:chips}+#2#{C:inactive} Chips){}",
        "{C:inactive,s:0.6}\"All together, we march on!\"" --March on! - Arknights
    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 1 },
    rarity = 1,
    cost = 5,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 0, chips = 0, multadd = 1, chipadd = 2}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult , center.ability.extra.chips, center.ability.extra.multadd, center.ability.extra.chipadd }  }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if next(context.poker_hands["Straight"]) then
                card.ability.extra.mult = 0
                card.ability.extra.chips = 0
                return {
                    message = "Straight! :(",
                    colour = G.C.MULT
                }
            elseif next(context.poker_hands["Flush"]) then
                card.ability.extra.mult = 0
                card.ability.extra.chips = 0
                return {
                    message = "Flush! :(",
                    colour = G.C.MULT
                }
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multadd
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipadd
            end
        end
        if context.joker_main and ((card.ability.extra.mult > 0) or (card.ability.extra.chips > 0)) then
            return {
				mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                message = "^_^",
                colour = G.C.DARK_EDITION
			}
        end
    end
}
--New Vegas Strip: similar=blackjack(unstable)
SMODS.Joker{
    key = 'fonv',
    loc_txt= {
        name = 'New Vegas Strip',
        text = {  "If your played cards equal {C:attention}21{},",
        "this gives {C:money}$#3#{} and gains {X:chips,C:white}X#1#{} Chips.",
        "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
        "{C:inactive,s:0.8}[Faces are 10, Aces are 1 or 11.]{}",
        "{C:inactive,s:0.6}\"The game was rigged from the start.\""} --Fallout New Vegas
    },
    atlas = 'prideJ',
    pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 7,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xbonus = 1, xadd = 0.2, rev = 3}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xadd , center.ability.extra.xbonus, center.ability.extra.rev }  }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then 
            totality = 0
            acesinhole = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 14 then
                    totality = totality + 11
                    acesinhole = acesinhole + 1
                elseif context.full_hand[i]:is_face() then
                    totality = totality + 10
                else
                    totality = totality + context.full_hand[i]:get_id()
                end
            end
            while totality > 21 and acesinhole > 0 do
                totality = totality - 10
                acesinhole = acesinhole - 1
            end
            if totality == 21 then
                card.ability.extra.xbonus = card.ability.extra.xbonus + card.ability.extra.xadd
                return {
                    dollars = 3,
                }
            end
        end
        if context.joker_main and (card.ability.extra.xbonus > 1) then
            return {
				x_chips = card.ability.extra.xbonus
			}
        end
    end
}
--Top Surgeon: similar=this.prideparade, jollyjoker?, runner
SMODS.Joker{
    key = 'topsurg',
    loc_txt= { --flavtxt "It's a weight off my chest."
        name = 'Top Surgeon',
        text = {  "{C:chips}+#1# Chips{} per played hand.",
        "Resets if the played hand",
        "contains a {C:attention}Pair{}.",
        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}",
        "{C:inactive,s:0.6}\"It's a weight off my chest.\"" --ref to top surgery/breast reduction
    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 1 },
    rarity = 1,
    cost = 5,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {chips = 0, add = 15}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.chips}  }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if next(context.poker_hands["Pair"]) then
                card.ability.extra.chips = 0
                return {
                    message = "Pair! :(",
                    colour = G.C.MULT,
                }
            else
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            end
        end
        if context.joker_main and (card.ability.extra.chips > 0) then
            return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips
			}
        end
    end
}
--Bofa-ectomy: similar=this.prideparade, jollyjoker
SMODS.Joker{
    key = 'orchi',
    loc_txt= {
        name = 'Bofa-ectomy',
        text = {  "{C:mult}+#1# Mult{} per played hand.",
        "Resets if the played hand",
        "contains a {C:attention}Pair{}.",
        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
        "{C:inactive,s:0.6}\"What's 'bofa'?\"" --bofa deez nuts hehehe gottem random person reading the code comments

    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 1 },
    rarity = 1,
    cost = 5,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 0, add = 2}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if next(context.poker_hands["Pair"]) then
                card.ability.extra.mult = 0
                return {
                    message = "Pair! :(",
                    colour = G.C.MULT,
                }
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            end
        end
        if context.joker_main and (card.ability.extra.mult > 0) then
            return {
				message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
				mult_mod = card.ability.extra.mult
			}
        end
    end
}
--Stonewall: similar=golden_ticket, crumbled_joker(celeste)
SMODS.Joker{
    key = 'stonewall',
    loc_txt= { --flavor text "Remember your roots."
        name = 'Stonewall',
        text = {  "Played {C:inactive}Stone Cards{} grant {X:chips,C:white}x#2#{} Chips and",
        "have a {C:green}#3# in #1#{} chance to be {C:attention}thrown{}.",
        "{C:inactive,s:0.6}\"Remember your roots.\"" -- stonewall was monumental to lgbtq rights

    }},
    atlas = 'prideJ',
    pos = { x = 1, y = 3 },
    rarity = 2,
    cost = 6,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {brick = 4, xchip = 1.5}}, --todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.brick , center.ability.extra.xchip, G.GAME.probabilities.normal}  }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then     
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    x_chips = card.ability.extra.xchip,
                    card = card
                }
            end
        end
        if context.cardarea == G.play and context.destroying_card then
            if SMODS.has_enhancement(context.destroy_card, 'm_stone') and pseudorandom('stonewall') < (G.GAME.probabilities.normal / card.ability.extra.brick)then
                return {
                    card = context.destroy_card,
                    message = "Yeet!",
                    colour = G.C.MULT,
                    remove = true
                }
            end
        end
    end
}
--Pronoun Pin: similar=this.progress_pride, this.diva?
SMODS.Joker{
    key = 'pronouns',
    loc_txt= {
        name = 'Pronoun Pin',
        text = {  "If a vanilla Seal will trigger, this gains {X:chips,C:white}X#1#{} Chips.",
        "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
        "{C:inactive,s:0.6}\"damn ya ass fat what's ya pronouns\"" -- meme from social media dms
    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 3 },
    rarity = 2,
    cost = 7,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xchip = 0.2, chip = 1}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xchip, center.ability.extra.chip }  }
	end,
    calculate = function(self, card, context)
        _card = card
        if context.joker_main then
            return {
                x_chips = card.ability.extra.chip
            }
        elseif context.repetition and not context.blueprint and context.cardarea == G.play and not context.other_card.debuff and context.other_card.seal == "Red" then
            card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.xchip
            SMODS.calculate_effect({message = 'X'..card.ability.extra.chip, colour = G.C.GREEN}, card)
        elseif context.individual and not context.blueprint and context.cardarea == G.play and not context.other_card.debuff and context.other_card.seal == "Gold" then
            card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.xchip
            SMODS.calculate_effect({message = 'X'..card.ability.extra.chip, colour = G.C.GREEN}, card)
        elseif context.discard and not context.blueprint and not context.other_card.debuff and context.other_card.seal == "Purple" then
            card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.xchip
            SMODS.calculate_effect({message = 'X'..card.ability.extra.chip, colour = G.C.GREEN}, card)
        elseif context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint and not context.other_card.debuff and context.other_card.seal == "Blue" then
            card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.xchip
            SMODS.calculate_effect({message = 'X'..card.ability.extra.chip, colour = G.C.GREEN}, card)
        end
    end
}
--Celestial Mountain: similar=boredom(cryptid), ytpmvelf
SMODS.Joker{
    key = 'celestialmt',
    loc_txt= {
        name = 'Celestial Mountain',
        text = {  "Other Jokers have a {C:green}#2# in #1#{}",
        "chance to {C:dark_edition,E:2}double jump{}.",
        "{C:inactive,s:0.6}\"Dedicated to those who perished on the climb.\"" -- Celeste
    }},
    atlas = 'prideJ',
    pos = { x = 0, y = 1 },
    rarity = 2,
    cost = 7,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {roll = 4}}, --todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.roll , G.GAME.probabilities.normal}  }
	end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if pseudorandom('celestialmt') < (G.GAME.probabilities.normal / card.ability.extra.roll) then
                return {
                    message = "Hop!",
                    colour = G.C.SECONDARY_SET.Planet,
                    repetitions = 1,
                    card = card,
                }
            else
                return nil, true
            end
        end
    end
}
--Diva: similar=???, midas?
SMODS.Joker{
    key = 'diva',
    loc_txt= {
        name = 'Diva',
        text = {  "Played cards used in scoring have a",
        "{C:green}#3# in #2#{} chance to gain a random {C:attention}enhancement{} and",
        "a {C:green}#3# in #1#{} to gain a random {C:dark_edition}edition{}.",
        "{C:inactive}(if they do not already have one)",
        "{C:inactive,s:0.6}\"Sparkle on!\"" --Jerma Sparkle On gif

    }},
    atlas = 'prideJ',
    pos = { x = 0, y = 3 },
    rarity = 2,
    cost = 8,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {edprob = 25, enhprob = 10}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.edprob , center.ability.extra.enhprob, G.GAME.probabilities.normal}  }
	end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and context.full_hand then
            local shakeit = (context.blueprint_card or card)
            for i, v in ipairs(context.scoring_hand) do
                --check edition randomness

                local edrand = pseudorandom('diva')
                local shinyproc = false
                if not v.edition and not v.debuff and (edrand < (G.GAME.probabilities.normal / card.ability.extra.edprob)) then
                    shinyproc = true
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if not v.edition and not v.debuff and (edrand < (G.GAME.probabilities.normal / card.ability.extra.edprob)) then
                            v:set_edition(poll_edition('diva',nil,true,true), true, true)
                            shakeit:juice_up()
                        end
                        return true
                    end,
                }))
                if shinyproc then --only display if it did above (same check with same rand)
                    SMODS.calculate_effect({message = "Shiny!", colour = G.C.SECONDARY_SET.Tarot}, v)
                end
            --same as above with enhancements
                local enhrand = pseudorandom('diva')
                local prettyproc = false
                if not next(SMODS.get_enhancements(v)) and not v.debuff and (enhrand < (G.GAME.probabilities.normal / card.ability.extra.enhprob)) then
                    prettyproc = true
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if not next(SMODS.get_enhancements(v)) and not v.debuff and (enhrand < (G.GAME.probabilities.normal / card.ability.extra.enhprob)) then
                            v:set_ability(SMODS.poll_enhancement({key = 'diva', guaranteed = true}))
                            shakeit:juice_up()
                        end
                        return true
                    end,
                }))
                if prettyproc then
                    SMODS.calculate_effect({message = "Pretty!", colour = G.C.GREEN}, v)
                end
            end
        end 
    end
}
--The Plus: similar=certificate
SMODS.Joker{
    key = 'lgbtqplus',
    loc_txt= {
        name = 'The Plus',
        text = { "On round start, adds a random {C:attention}face card{}",
        "with a random {C:dark_edition}edition{} to your hand.",
        "{C:inactive,s:0.6}\"Everyone, get in here!\"" -- grim patron, hearthstone (optional flavor text, "Merriment loves company.")
    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 3 },
    rarity = 3,
    cost = 8,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 0, add = 6}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local _rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('lgbtqplus')) 
            local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('lgbtqplus'))
            local _card = create_playing_card({
                front = G.P_CARDS[_suit..'_'.._rank],
                center = G.P_CENTERS.c_base
            }, G.hand, false,false,nil)
            _card:set_edition(poll_edition('lgbtqplus',nil,true,true), true, true)
            _card:add_to_deck()
            table.insert(G.playing_cards, _card)
            _card.states.visible = nil
            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    return true
                end
            }))
            G.hand:sort()
        end
    end
}
--Double Rainbow: similar=sock_and_buskin, this.progress_pride, ytpmvelf 
SMODS.Joker{
    key = 'doublerainbow',
    loc_txt= {
        name = 'Double Rainbow',
        text = {  "{C:dark_edition}Polychrome{} cards and jokers",
        "{C:attention}retrigger{} an additional time.",
        "{C:inactive,s:0.6}\"All the way across the sky.\"" --Double Rainbow meme

    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 3 },
    rarity = 3,
    cost = 8,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context) 
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card.edition and context.other_card.edition.key == "e_polychrome" then
                return {
                    repetitions = 1,
                    card = card,
                }
            else
                return nil, true 
            end
        elseif context.repetition and context.cardarea == (G.play or G.hand) then
            if context.other_card.edition and context.other_card.edition.key == "e_polychrome" then
                return {
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
    end
    
}
--Shark Attack: similar=glass_joker?, lcdirects(yahi)
SMODS.Joker{
    key = 'blahaj',
    loc_txt= {
        name = 'Shark Attack',
        text = { "Whenever one or more", 
                "playing cards are destroyed,",
                "gain {C:mult}+#1#{} Mult.",                     
                "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
                "{C:inactive,s:0.6}\"Blåhaj Blast!\"" --baja blast
    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 2 },
    rarity = 1,
    cost = 4,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 0, add = 6}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context) 
    if context.joker_main and (card.ability.extra.mult > 0) then
			return {
				message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
				mult_mod = card.ability.extra.mult
			}
		end
    if context.remove_playing_cards and not context.blueprint then
            for k, val in ipairs(context.removed) do
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                return {
                    message = "Nom!",
                    colour = G.C.BLUE
                }
            end
        end
    end
}
--Go Spinny: similar=wheel_of_hope(cryptid)
SMODS.Joker{
    key = 'gospinny',
    loc_txt= {
        name = 'Go Spinny',
        text = {  "This gains {X:mult,C:white}X#1#{} Mult when you",
        "play a {C:tarot}Wheel of Fortune{}.",
        "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        "{C:inactive,s:0.6,E:1}\"Speeeeeeen!\"" -- vinesauce

    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 2 },
    rarity = 1,
    cost = 5,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 1, xadd = 0.2}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xadd , center.ability.extra.xmult}  }
	end,
    calculate = function(self, card, context)
        if context.using_consumeable == true and (context.consumeable.ability.name == "The Wheel of Fortune") and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xadd
            return {
                message = "Spin!",
                colour = G.C.SECONDARY_SET.Tarot
            }
        end
        if context.joker_main and (card.ability.extra.xmult > 1) then
            return {
				x_mult = card.ability.extra.xmult,
			}
        end
    end
}
--Polycule: similar=???
SMODS.Joker{
    key = 'polycule',
    loc_txt= {
        name = 'Polycule',
        text = {  "{X:mult,C:white}X#1#{} Mult if you score {C:attention}3+ Face Cards{}",
        "that are {C:attention}unique{} in a given hand.",
        "{C:inactive,s:0.6}\"What's got us terrified that we'll really fall in love?\"", --Perils of Poly - Gaia Consort
        "{C:legendary,s:0.6} Idea: EverettDarling (\"Eclipse\")"

    }},
    atlas = 'prideJ',
    pos = { x = 0, y = 4 },
    rarity = 1,
    cost = 4,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {cardmult = 1.5}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.cardmult}  }
	end,
    calculate = function(self, card, context)
        rolodex = {}
        local function uniquity(tab, val)
            for index, value in ipairs(tab) do
                if value == val then
                    return false
                end
            end
        return true
        end
        if context.joker_main then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    carddata = ''..context.scoring_hand[i].base.suit..context.scoring_hand[i]:get_id()
                    if uniquity(rolodex, carddata) then
                        table.insert(rolodex, carddata)
                    end
                end
            end
            if #rolodex > 2 then
                return {
                    x_mult = card.ability.extra.cardmult,
                    message = "Poly!",
                    colour = G.C.SECONDARY_SET.Tarot
                } 
            end
        end
    end
}
--Rainbow Capitalism: similar=golden_ticket
SMODS.Joker{
    key = 'rainbowcap',
    loc_txt= {
        name = 'Rainbow Capitalism',
        text = {  "{C:attention}Played cards{} with {C:dark_edition}editions{} grant {C:gold}$3{}.",
                "{C:inactive,s:0.6}\"Feeling overburdened by money?\"", -- Marcus' Ammo Shop, Borderlands 2
                "{C:legendary,s:0.6} Idea: EverettDarling (\"Eclipse\")"
    }},
    atlas = 'prideJ',
    pos = { x = 1, y = 4 },
    rarity = 1,
    cost = 5,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {cardrev = 3}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.cardrev }  }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition then
                return {
                    dollars = card.ability.extra.cardrev,
					card = context.other_card
				}
            end
        end
    end
}



--[[ PATCH 1 JOKERS -- DONT FOGET TO ADD TO LAVENDER TYPE

SMODS.Joker {
    key = "gaydar",
    loc_txt= {
        name = 'Rainbow Radar',
        text = { "If a scored card has an edition, 1 in ?",
        "chance to copy it to a card held in hand. (WIP)",
        "{C:inactive,s:0.6}\"todo\""}
    },
    atlas = "prideJ",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 2,
    pools = {["Prideful"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "closet",
    loc_txt= {
        name = 'Walk-in Closet',
        text = { "Discarded cards have a 1 in ? chance to gain an edition. (WIP)",
        "{C:inactive,s:0.6}\"todo\""}
    },
    atlas = "prideJ",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 2,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "bifocals",
    loc_txt= {
        name = 'Bi-focals',
        text = { "Adds ?% of Mult to Chips, or ?% of Chips to Mult, whichever is higher.",
        "{C:inactive,s:0.6}\"todo\""}
    },
    atlas = "prideJ",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 2,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "respectexistence",
    loc_txt= {
        name = 'Respect Existence',
        text = { "If a playing card would be destroyed,",
        "copy it to your deck with a random edition (WIP)",
        "{C:inactive,s:0.6}\"Do no harm...\""}
    },
    atlas = "prideJ",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 2,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- MOVE DOWN, SECRET, CONVERTS FROM ABOVE ON 15+ CARDS W EDITION IN DECK
    key = "expectresistance",
    loc_txt= {
        name = 'Expect Resistance',
        text = { "Cards with editions cannot be debuffed.",
        "{C:inactive,s:0.6}\"...and take no shit.\""}
    },
    atlas = "prideJ"
    pos = { x = 0, y = 0 },
    rarity = "pride_Secret",
    cost = 2,
    pools = {["Prideful"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,

    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}


]]























































































-- spooli --



















-- GIGA JOKERS --

--Cracked Egg: similar=???
SMODS.Joker{
    key = 'crackedegg',
    loc_txt= {
        name = 'Cracked Egg',
        text = {  "Gains {C:money}$#4#{} of sell value at end of round.",
        "Grants {C:chips}Chips{} and {C:mult}Mult{} equal to sell value.",
        "{C:inactive}(Currently {C:gold}$#3#{C:inactive}.)",
        "{C:dark_edition,s:0.6,E:1}\"I am so proud of you!\"" -- i really am, good for you!
    }},
    atlas = 'prideJ',
    pos = { x = 1, y = 2 },
    rarity = 'pride_Secret',
    cost = 30,
    extra_value = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,

    config = { extra = {mult = 15, chips = 15, sellval = 15, uptick = 5}},
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult , center.ability.extra.chips, center.ability.extra.sellval, center.ability.extra.uptick}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.uptick
            card:set_cost()
            card.ability.extra.sellval = card.sell_cost
            card.ability.extra.mult = card.ability.extra.sellval
            card.ability.extra.chips = card.ability.extra.sellval
            return {
                message = "Euphoria Up!",
                colour = G.C.SECONDARY_SET.Tarot
            }
        end
        if context.joker_main then
            return {
				mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                message = ":D",
                colour = G.C.MONEY
			}
        end
    end
}





--bridget
SMODS.Joker{
    key = 'bridget',
    loc_txt= {
        name = 'Bridget',
        text = {  "{C:dark_edition,E:1}A girl with many names." --ref to bridget being called many different names by the fgc community

    }},
    atlas = 'prideJ',
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 50,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,


    config = { extra = {mult = 0, add = 6}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.add , center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            yourbridgetfortoday = pseudorandom_element({'j_pride_budget', 'j_pride_brisket', 'j_pride_bucket', 'j_pride_biscuit', 'j_pride_breakfast', 'j_pride_bracket', 'j_pride_blanket', 'j_pride_baguette'}, pseudoseed('bridget'))
            card:set_ability(yourbridgetfortoday)
            card:juice_up()
            card:set_cost()
        end
    end
}





--budget
SMODS.Joker{
    key = 'budget',
    loc_txt= {
        name = 'Budget',
        text = {  "Played cards have a {C:green}#3# in #1#{} chance",
        "to give {C:gold}$#2#{} when played this round."
    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 4 },
    rarity = 'pride_Bridget',
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,

    config = { extra = {prob = 2, dosh = 2}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.prob , center.ability.extra.dosh, G.GAME.probabilities.normal }  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:juice_up()
            card:set_cost()
        end
        if context.individual and context.cardarea == G.play and
            pseudorandom('budget') < G.GAME.probabilities.normal / card.ability.extra.prob then
            return {
                dollars = card.ability.extra.dosh,
            }
        end
    end
}
--brisket
SMODS.Joker{
    key = 'brisket',
    loc_txt= {
        name = 'Brisket',
        text = {  "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult for each",
        "{C:attention}remaining hand{} this round."
    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 4 },
    rarity = 'pride_Bridget',
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,

    config = { extra = {mult = 5, chips = 25}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips , center.ability.extra.mult }  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.joker_main then
            return {
                mult = G.GAME.current_round.hands_left * card.ability.extra.mult,
                chips = G.GAME.current_round.hands_left * card.ability.extra.chips
            }
        end
    end
}
--bucket
SMODS.Joker{
    key = 'bucket',
    loc_txt= {
        name = 'Bucket',
        text = {  "When you {C:mult}discard{} this round,",
        "this gains {C:chips}#2#x the chip value{}",
        "of each card discarded." ,
        "{C:inactive}(Currently {C:chips}+#1#{} Chips)" --ref to bridget being called many different names by the fgc community

    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 4 },
    rarity = 'pride_Bridget',
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
        no_collection = true,

    config = { extra = {chips = 0, selfmult = 2}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips , center.ability.extra.selfmult}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        --card:get_chip_bonus() to get chips from playing cards
        if context.discard then
            card.ability.extra.chips = card.ability.extra.chips + (context.other_card:get_chip_bonus() * card.ability.extra.selfmult)
            SMODS.calculate_effect({ message = '+'..card.ability.extra.chips, colour = G.C.Chips, card = card })
        end
        if context.joker_main then
            return {chips = card.ability.extra.chips}
        end
    end
}
--biscuit
SMODS.Joker{
    key = 'biscuit',
    loc_txt= {
        name = 'Biscuit',
        text = {  "{C:chips}+#1#{} Chips for each",
        "{C:attention}remaining hand{} this round."

    }},
    atlas = 'prideJ',
    pos = { x = 0, y = 5 },
    rarity = 'pride_Bridget', 
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
        no_collection = true,

    config = { extra = {chips = 50}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.joker_main then
            return {
                chips = G.GAME.current_round.hands_left* card.ability.extra.chips
            }
        end
    end
}
--breakfast
SMODS.Joker{
    key = 'breakfast',
    loc_txt= {
        name = 'Breakfast',
        text = {  "{X:mult,C:white}x#1#{} Mult on the",
        "{C:attention}first hand{} of this round."

    }},
    atlas = 'prideJ',
    pos = { x = 1, y = 5 },
    rarity = 'pride_Bridget', 
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
        no_collection = true,

    config = { extra = {xmult = 3}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.xmult}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.joker_main and G.GAME.current_round.hands_left == (G.GAME.round_resets.hands - 1) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
--bracket
SMODS.Joker{
    key = 'bracket',
    loc_txt= {
        name = 'Bracket',
        text = {  "Retrigger the {C:attention}last{} scored card",
        "{C:attention}thrice more{} this round."
    }},
    atlas = 'prideJ',
    pos = { x = 2, y = 5 },
    rarity = 'pride_Bridget', 
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
        no_collection = true,

    config = { extra = {redo = 3}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.redo}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
            return { repetitions = card.ability.extra.redo }
        end
    end

}
--blanket
SMODS.Joker{
    key = 'blanket',
    loc_txt= {
        name = 'Blanket',
        text = {  "{X:mult,C:white}x#1#{} Mult, but {C:attention}all playing cards{}",
        "are {E:1}face down{} this round."
    }},
    atlas = 'prideJ',
    pos = { x = 3, y = 5 },
    rarity = 'pride_Bridget', 
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,

    config = { extra = {xmult = 7}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.stay_flipped and context.to_area == G.hand then
            return { stay_flipped = true }
        end
        if context.joker_main then 
            return {xmult = card.ability.extra.xmult}
        end
    end
}
--baguette
SMODS.Joker{
    key = 'baguette',
    loc_txt= {
        name = 'Baguette',
        text = {  "{C:mult}+#1#{} Mult for each",
        "{C:attention}remaining hand{} this round."

    }},
    atlas = 'prideJ',
    pos = { x = 4, y = 5 },
    rarity = 'pride_Bridget',
    cost = 0,
    pools = {["PridefulX"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    config = { extra = {mult = 10}},--todo, lookup how to do probabilities
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult}  }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card:set_ability('j_pride_bridget')
            card:set_cost()
            card:juice_up()
        end
        if context.joker_main then
            return {
                mult = G.GAME.current_round.hands_left * card.ability.extra.mult
            }
        end
    end
}

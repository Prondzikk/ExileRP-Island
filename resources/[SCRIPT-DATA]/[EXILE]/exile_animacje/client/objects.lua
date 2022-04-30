Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Ped = {
	Active = false,
	Locked = false,
	Id = 0,
	Alive = false,
	Available = false,
	Visible = false,
	InVehicle = false,
	OnFoot = false,
	Collection = false,
	Slots = false,
}

CreateThread(function()
	while true do
		Citizen.Wait(400)

		Ped.Active = not IsPauseMenuActive()
		if Ped.Active then
			Ped.Id = PlayerPedId()
			if not IsEntityDead(Ped.Id) then
				Ped.Locked = (exports['exile_trunk']:checkInTrunk() or exports['esx_policejob']:IsCuffed())
				Ped.Alive = true
				Ped.Available = (Ped.Alive and not Ped.Locked)
				Ped.Visible = IsEntityVisible(Ped.Id)
				Ped.InVehicle = IsPedInAnyVehicle(Ped.Id, false)
				Ped.OnFoot = IsPedOnFoot(Ped.Id)

				if Ped.Available and not Ped.InVehicle and Ped.Visible then
					Ped.Collection = not IsPedFalling(Ped.Id) and not IsPedDiving(Ped.Id) and not IsPedSwimming(Ped.Id) and not IsPedSwimmingUnderWater(Ped.Id) and not IsPedInCover(Ped.Id, false) and not IsPedInParachuteFreeFall(Ped.Id) and (GetPedParachuteState(Ped.Id) == 0 or GetPedParachuteState(Ped.Id) == -1) and not IsPedBeingStunned(Ped.Id)
				else
					Ped.Collection = false
				end
				
				if Ped.Available then
					Ped.Slots = not IsPedFalling(Ped.Id) and not IsPedDiving(Ped.Id) and not IsPedSwimming(Ped.Id) and not IsPedSwimmingUnderWater(Ped.Id) and not IsPedInCover(Ped.Id, false) and not IsPedInParachuteFreeFall(Ped.Id) and (GetPedParachuteState(Ped.Id) == 0 or GetPedParachuteState(Ped.Id) == -1) and not IsPedBeingStunned(Ped.Id)
				else
					Ped.Slots = false
				end
			else
				Ped.Alive = false
				Ped.Available = false
				Ped.Visible = IsEntityVisible(Ped.Id)
				Ped.InVehicle = false
				Ped.OnFoot = true
				Ped.Collection = false
				Ped.Slots = false
			end
		end
	end
end)

function PedStatus()
	return Ped.Slots
end

Config = {}
Config.Animations = {
	{
		name  = 'interakcje',
		label = 'Obywatel - Interakcje',
		items = {
			{label = "Powitaj", keyword = "powitaj", type = "wspolne", data = { name = 'powitaj' }},		
			{label = "Piona", keyword = "piona", type = "wspolne", data = { name = 'piona' }},
			{label = "Objęcia", keyword = "obejmij", type = "wspolne", data = { name = 'obejmij'}},	
			{label = "Przytulas", keyword = "przytulas", type = "wspolne", data = { name = 'przytulas' }},
			{label = "Pocałuj", keyword = "pocaluj", type = "wspolne", data = { name = 'pocaluj' }},
			{label = "Zrób louda", keyword = "rublud", type = "wspolne", data = { name = 'rublud'}},
			{label = "Dzwoni Papuga", keyword = "anal", type = "wspolne", data = { name = 'anal' }},
			{label = "Posuwanie na stojąco", keyword = "standingsex", type = "wspolne", data = { name = 'standingsex'}}	
		}
	},
	
	{
		name = 'speaking',
		label = 'Obywatel - Wyraz Twarzy',
		items = {
			{label = "Normalny", type = "facial", data = 1, keyword = "normalny2"},
			{label = "Wkurwiony", type = "facial", data = 2, keyword = "wkurwiony2"},
			{label = "Zaangażowany", type = "facial", data = 3, keyword = "zaangazowany"},
			{label = "Skupiony", type = "facial", data = 4, keyword = "skupiony"},
			{label = "Zły", type = "facial", data = 5, keyword = "zly"},
			{label = "Zacieszony", type = "facial", data = 6, keyword = "zacieszony"},
			{label = "Szczęśliwy", type = "facial", data = 7, keyword = "szczesliwy"},
			{label = "Zdziwiony", type = "facial", data = 8, keyword = "zdziwiony"},
			{label = "Zamknięte oczy", type = "facial", data = 9, keyword = "zamknieteoczy"},
			{label = "Odczuwając ból", type = "facial", data = 10, keyword = "odczuwajacybol"}
		}
	},

	{
		name  = 'taniec',
		label = 'Tańce - Imprezowe',
		items = {
			{label = "Disco", keyword = "disco", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@uncle_disco", anim = "uncle_disco", mode = 1}},
			{label = "Impra", keyword = "impra", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^3", mode = 1}},
			{label = "Wczuta", keyword = "wczuta", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^6", mode = 1}},
			{label = "Zabawa", keyword = "zabawa", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1", mode = 1}},
			{label = "Krec tym mała", keyword = "krec", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_17_smackthat_laz", mode = 1}},
			{label = "Densjer", keyword = "densjer", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^3", mode = 1}},
			{label = "Robot", keyword = "robot", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_15_robot_laz", mode = 1}},
			{label = "Wixa", keyword = "wixa", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel", mode = 1}},
			{label = "Stepowanie", keyword = "stepowanie", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", mode = 1}},
			{label = "Boogie", keyword = "boogie", type = "anim", data = {lib = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", mode = 1}},
			{label = "Striptizerka", keyword = "striptizerka", type = "anim", data = {lib = "mp_am_stripper", anim = "lap_dance_girl", mode = 1}},
			{label = "Macarena", keyword = "macarena", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", mode = 1}},
			{label = "Taniec kurczaka", keyword = "kurczak", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@chicken_taunt", anim = "chicken_taunt", mode = 1}},
			{label = "Taniec losia", keyword = "los", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@thumb_on_ears", anim = "thumb_on_ears", mode = 1}},
			{label = "Taniec spidermana", keyword = "spiderman", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_17_spiderman_laz", mode = 1}},
			{label = "Wywijanie reka", keyword = "wywijanie", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@find_the_fish", anim = "find_the_fish", mode = 1}},
			{label = "Imprezka", keyword = "impra1", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^3", mode = 1}},
			{label = "Wczuta 1", keyword = "wczuta1", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^6", mode = 1}},
			{label = "Wczuta 2", keyword = "wczuta2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", mode = 1}},
			{label = "Wczuta 3", keyword = "wczuta3", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", mode = 1}},
			{label = "Połamaniec 1", keyword = "polamaniec1", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1", mode = 1}},
			{label = "Połamaniec 2", keyword = "polamaniec2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3", mode = 1}},
			{label = "Połamaniec 3", keyword = "polamaniec3", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6", mode = 1}},
			{label = "Węgorz", keyword = "wegorz", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^1", mode = 1}},
			{label = "Zabawa 1", keyword = "zabawa", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1", mode = 1}},
			{label = "Zabawa 2", keyword = "zabawa2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^3", mode = 1}},
			{label = "Szejker", keyword = "densjer", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^3", mode = 1}},
			{label = "Vixa 1", keyword = "wixa1", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel", mode = 1}},
			{label = "Vixa 2", keyword = "wixa2", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_turnaround_laz", mode = 1}},
			{label = "Imprezowa 1", keyword = "imprezowa1", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_female^1", mode = 1}},
			{label = "Imprezowa 2", keyword = "imprezowa2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_male^2", mode = 1}},
			{label = "Imprezowa 3", keyword = "imprezowa3", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_female^3", mode = 1}},			
			{label = "Imprezowa 4", keyword = "imprezowa4", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_17_crotchgrab_laz", mode = 1}},
			{label = "Twerk", keyword = "twerk", type = "anim", data = {lib = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", mode = 1}}
		}
	},

	{
		name = 'taniec1',
		label = 'Tańce - Własne',
		items = {
			{label = "Taniec 1", type = "anim", keyword = "ntaniec1", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", mode = 1}},
			{label = "Taniec 2", type = "anim", keyword = "ntaniec2", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", mode = 1}},
			{label = "Taniec 3", type = "anim", keyword = "ntaniec3", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", mode = 1}},
			{label = "Taniec 4", type = "anim", keyword = "ntaniec4", data = {lib = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", mode = 1}},
			{label = "Taniec 5", type = "anim", keyword = "ntaniec5", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", mode = 1}},
			{label = "Taniec 6", type = "anim", keyword = "ntaniec6", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", mode = 1}},
			{label = "Taniec 7", type = "anim", keyword = "ntaniec7", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", mode = 1}},
			{label = "Taniec 8", type = "anim", keyword = "ntaniec8", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", mode = 1}},
			{label = "Taniec 9", type = "anim", keyword = "ntaniec9", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", mode = 1}},
			{label = "Taniec 10", type = "anim", keyword = "ntaniec10", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center", mode = 1}},
			{label = "Taniec 11", type = "anim", keyword = "ntaniec11", data = {lib = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", mode = 1}},
			{label = "Taniec 12", type = "anim", keyword = "ntaniec12", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", mode = 1}},
			{label = "Taniec 13", type = "anim", keyword = "ntaniec13", data = {lib = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", mode = 1}},
			{label = "Taniec 14", type = "anim", keyword = "ntaniec14", data = {lib = "missfbi3_sniping", anim = "dance_m_default", mode = 1}},
			{label = "Taniec 15", type = "anim", keyword = "ntaniec15", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", mode = 1}},
			{label = "Taniec 16", type = "anim", keyword = "ntaniec16", data = {lib = "move_clown@p_m_zero_idles@", anim = "fidget_short_dance", mode = 1}},
			{label = "Taniec 17", type = "anim", keyword = "ntaniec17", data = {lib = "move_clown@p_m_two_idles@", anim = "fidget_short_dance", mode = 1}},
			{label = "Taniec 18", type = "anim", keyword = "ntaniec18", data = {lib = "anim@mp_player_intcelebrationfemale@the_woogie", anim = "the_woogie", mode = 1}},
			{label = "Taniec 19", type = "anim", keyword = "ntaniec19", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", mode = 1}},
			{label = "Taniec 20", type = "anim", keyword = "ntaniec20", data = {lib = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center", mode = 1}},
			{label = "Taniec 21", type = "anim", keyword = "ntaniec21", data = {lib = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", mode = 1}},
			{label = "Taniec 22", type = "anim", keyword = "ntaniec22", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", mode = 1}},
			{label = "Taniec 23", type = "anim", keyword = "ntaniec23", data = {lib = "anim@amb@nightclub@dancers@club_ambientpeds@med-hi_intensity", anim = "mi-hi_amb_club_10_v1_male^6", mode = 1}},
			{label = "Taniec 24", type = "anim", keyword = "ntaniec24", data = {lib = "amb@code_human_in_car_mp_actions@dance@bodhi@ds@base", anim = "idle_a_fp", mode = 1}},
			{label = "Taniec 25", type = "anim", keyword = "ntaniec25", data = {lib = "amb@code_human_in_car_mp_actions@dance@bodhi@rds@base", anim = "idle_b", mode = 1}},
			{label = "Taniec 26", type = "anim", keyword = "ntaniec26", data = {lib = "amb@code_human_in_car_mp_actions@dance@std@ds@base", anim = "idle_a", mode = 1}},
			{label = "Taniec 27", type = "anim", keyword = "ntaniec27", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6", mode = 1}},
			{label = "Taniec 28", type = "anim", keyword = "ntaniec28", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^6", mode = 1}},
			{label = "Taniec 29", type = "anim", keyword = "ntaniec29", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", anim = "trans_dance_facedj_hi_to_li_09_v1_male^6", mode = 1}},
			{label = "Taniec 30", type = "anim", keyword = "ntaniec30", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", anim = "trans_dance_facedj_li_to_hi_07_v1_male^6", mode = 1}},
			{label = "Taniec 31", type = "anim", keyword = "ntaniec31", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", mode = 1}},
			{label = "Taniec 32", type = "anim", keyword = "ntaniec32", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_hi_intensity", anim = "trans_dance_crowd_hi_to_li__07_v1_male^6", mode = 1}},
			{label = "Taniec 33", type = "anim", keyword = "ntaniec33", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^6", mode = 1}},
			{label = "Taniec 34", type = "anim", keyword = "ntaniec34", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^6", mode = 1}},
			{label = "Taniec 35", type = "anim", keyword = "ntaniec35", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", mode = 1}},
			{label = "Taniec 36", type = "anim", keyword = "ntaniec36", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_up", mode = 1}},
			{label = "Taniec 37", type = "anim", keyword = "ntaniec37", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^6", mode = 1}},
			{label = "Taniec 38", type = "anim", keyword = "ntaniec38", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_li_09_v1_male^6", mode = 1}},
			{label = "Taniec 39", type = "anim", keyword = "ntaniec39", data = {lib = "timetable@tracy@ig_5@idle_b", anim = "idle_e", mode = 1}},
			{label = "Taniec 40", type = "anim", keyword = "ntaniec40", data = {lib = "mini@strip_club@idles@dj@idle_04", anim = "idle_04", mode = 1}},
			{label = "Taniec 41", type = "anim", keyword = "ntaniec41", data = {lib = "special_ped@mountain_dancer@monologue_1@monologue_1a", anim = "mtn_dnc_if_you_want_to_get_to_heaven", mode = 1}},
			{label = "Taniec 42", type = "anim", keyword = "ntaniec42", data = {lib = "special_ped@mountain_dancer@monologue_4@monologue_4a", anim = "mnt_dnc_verse", mode = 1}},
			{label = "Taniec 43", type = "anim", keyword = "ntaniec43", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", mode = 1}},
			{label = "Taniec 44", type = "anim", keyword = "ntaniec44", data = {lib = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", mode = 1}},
			{label = "Taniec 45", type = "anim", keyword = "ntaniec45", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^6", mode = 1}},
			{label = "Taniec 46", type = "anim", keyword = "ntaniec46", data = {lib = "anim@amb@nightclub@dancers@dixon_entourage@", anim = "mi_dance_facedj_15_v1_male^4", mode = 1}},
			{label = "Taniec 47", type = "anim", keyword = "ntaniec47", data = {lib = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", mode = 1}},
			{label = "Taniec 48", type = "anim", keyword = "ntaniec48", data = {lib = "anim@amb@nightclub@dancers@tale_of_us_entourage@", anim = "mi_dance_prop_13_v2_male^4", mode = 1}},
			{label = "Taniec 49", type = "anim", keyword = "ntaniec49", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", mode = 1}},
			{label = "Taniec 50", type = "anim", keyword = "ntaniec50", data = {lib = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", mode = 1}},
			{label = "Taniec 51", type = "anim", keyword = "ntaniec51", data = {lib = "anim@mp_player_intcelebrationfemale@uncle_disco", anim = "uncle_disco", mode = 1}},
			{label = "Taniec 52", type = "anim", keyword = "ntaniec52", data = {lib = "anim@mp_player_intcelebrationfemale@raise_the_roof", anim = "raise_the_roof", mode = 1}},
			{label = "Taniec 53", type = "anim", keyword = "ntaniec53", data = {lib = "anim@mp_player_intcelebrationmale@cats_cradle", anim = "cats_cradle", mode = 1}},
			{label = "Taniec 54", type = "anim", keyword = "ntaniec54", data = {lib = "anim@mp_player_intupperbanging_tunes", anim = "idle_a", mode = 1}},
			{label = "Taniec 55", type = "anim", keyword = "ntaniec55", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", mode = 1}},
			{label = "Taniec 56", type = "anim", keyword = "ntaniec56", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", mode = 1}},
			{label = "Taniec 57", type = "anim", keyword = "ntaniec57", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", mode = 1}},
			{label = "Taniec 58", type = "anim", keyword = "ntaniec58", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@", anim = "trans_dance_facedj_hi_to_mi_11_v1_female^6", mode = 1}},
			{label = "Taniec 59", type = "anim", keyword = "ntaniec59", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", anim = "trans_dance_facedj_hi_to_li_07_v1_female^6", mode = 1}},
			{label = "Taniec 60", type = "anim", keyword = "ntaniec60", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^6", mode = 1}},
			{label = "Taniec 61", type = "anim", keyword = "ntaniec61", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^6", mode = 1}},
			{label = "Taniec 62", type = "anim", keyword = "ntaniec62", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_06_base_laz", mode = 1}},
			{label = "Taniec 63", type = "anim", keyword = "ntaniec63", data = {lib = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", mode = 1}},
			{label = "Taniec 64", type = "anim", keyword = "ntaniec64", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", mode = 1}},
			{label = "Taniec 65", type = "anim", keyword = "ntaniec65", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", mode = 1}},
			{label = "Taniec 66", type = "anim", keyword = "ntaniec66", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1", mode = 1}},
			{label = "Taniec 67", type = "anim", keyword = "ntaniec67", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3", mode = 1}},
			{label = "Taniec 68", type = "anim", keyword = "ntaniec68", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", mode = 1}},
			{label = "Taniec 69", type = "anim", keyword = "ntaniec69", data = {lib = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center", mode = 1}},
			{label = "Taniec 70", type = "anim", keyword = "ntaniec70", data = {lib = "anim@mp_player_intcelebrationfemale@the_woogie", anim = "the_woogie", mode = 1}},
			{label = "Taniec 71", type = "anim", keyword = "ntaniec71", data = {lib = "timetable@tracy@ig_5@idle_a", anim = "idle_a", mode = 1}},
			{label = "Taniec konia 1", keyword = "ntanieckon1", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_11_hu_shimmy_laz", mode = 1, prop = {bone = 28422, object = "ba_prop_battle_hobby_horse", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},			
			{label = "Taniec konia 2", keyword = "ntanieckon2", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_15_handup_laz", mode = 51, prop = {bone = 28422, object = "ba_prop_battle_hobby_horse", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},			
			{label = "Taniec konia 3", keyword = "ntanieckon3", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "crowddance_hi_11_handup_laz", mode = 51, prop = {bone = 28422, object = "ba_prop_battle_hobby_horse", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Taniec z Glowstickiem 1", keyword = "ntaniecglowstick1", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_railing@", anim = "ambclub_13_mi_hi_sexualgriding_laz", mode = 1, prop = {bone = 28422, object = "ba_prop_battle_glowstick_01", offset = {x = 0.07, y = 0.14, z = 0.0}, rotation = {x = -80.0, y = 20.0, z = 0.0}}}},
			{label = "Taniec z Glowstickiem 2", keyword = "ntaniecglowstick2", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_railing@", anim = "ambclub_09_mi_hi_bellydancer_laz", mode = 1, prop = {bone = 60309, object = "ba_prop_battle_glowstick_01", offset = {x = 0.07, y = 0.09, z = 0.0}, rotation = {x = -120.0, y = -20.0, z = 0.0}}}},
			{label = "Taniec z Glowstickiem 3", keyword = "ntaniecglowstick3", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_railing@", anim = "ambclub_12_mi_hi_bootyshake_laz", mode = 51, prop = {bone = 60309, object = "ba_prop_battle_glowstick_01", offset = {x = 0.07, y = 0.09, z = 0.0}, rotation = {x = -120.0, y = -20.0, z = 0.0}}}},
			{label = "Taniec Robota", keyword = "robotdance", type = "anim", data = {lib = "export@breakdance", anim = "breakdance", mode = 1}}
		}
	},

	{
		name  = 'greetings',
		label = 'Zachowanie - Pozdrowienia',
		items = {
			{label = "Machnięcię ręką", keyword = "machanie", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "Powitanie", keyword = "powitanie", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "Graba", keyword = "graba", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "Graba i klepanie po plecach", keyword = "graba2", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "Żółwik", keyword = "zolwik", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			{label = "Salut", keyword = "salut", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute", mode = 49}},
			{label = "Srodkowy palec", keyword = "fuck", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			{label = "Srodkowy palec v2", keyword = "fuck2", type = "anim", data = {lib = "mp_player_intfinger", anim = "mp_player_int_finger"}},
			{label = "Środkowy palec v3", keyword = "fuck3", type = "anim", data = {lib = "anim@mp_player_intselfiethe_bird", anim = "idle_a", mode = 49}},
			{label = "Posłanie buziaczka", keyword = "buziak", type = "anim", data = {lib = "anim@mp_player_intselfieblow_kiss", anim = "exit", mode = 48}},
			{label = "Machanie ręką", keyword = "machanie", type = "anim", data = {lib = "random@hitch_lift", anim = "come_here_idle_c", mode = 49}}
		}
	},

	{
		name  = 'humors',
		label = 'Zachowanie - Humor',
		items = {
			{label = "Tak pijemy", keyword = "takpijemy", type = "anim", data = {lib = "mp_player_inteat@pnq", anim = "loop", mode = 49}},
			{label = "Bestia", keyword = "bestia", type = "anim", data = {lib = "anim@mp_fm_event@intro", anim = "beast_transform", mode = 49}},
			{label = "Chill", keyword = "chill", type = "anim", data = {lib = "switch@trevor@scares_tramp", anim = "trev_scares_tramp_idle_tramp"}},
			{label = "Odpoczywanie 1", keyword = "odpoczywanie1", type = "anim", data = {lib = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_girl"}},
			{label = "Odpoczywanie 2", keyword = "odpoczywanie2", type = "anim", data = {lib = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_guy"}},
			{label = "Stanie 1", keyword = "stanie1", type = "anim", data = {lib = "anim@heists@heist_corona@team_idles@male_a", anim = "idle", mode = 49}},
			{label = "Stanie 2", keyword = "stanie2", type = "anim", data = {lib = "amb@world_human_hang_out_street@male_b@idle_a", anim = "idle_b", mode = 49}},
			{label = "Stanie 3", keyword = "stanie3", type = "anim", data = {lib = "friends@fra@ig_1", anim = "base_idle", mode = 49}},
			{label = "Stanie pijak 1", keyword = "staniepijak1", type = "anim", data = {lib = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd1", mode = 49}},
			{label = "Stanie pijak 2", keyword = "staniepijak2", type = "anim", data = {lib = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd2", mode = 49}},
			{label = "Gitara w powietrzu", keyword = "gitarawpowietrzu", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar", mode = 49}},
			{label = "Zobacz to", keyword = "zobaczto", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_synth", anim = "air_synth", mode = 49}},
			{label = "Tłumaczenie", keyword = "tlumaczenie", type = "anim", data = {lib = "misscarsteal4@actor", anim = "actor_berating_loop", mode = 49}},
			{label = "Trzymanie lady", keyword = "trzymanielady", type = "anim", data = {lib = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender"}},
			{label = "Rozdawanie buziaków", keyword = "rozdawaniebuziakow", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", mode = 49}},
			{label = "Skrzyżowane rece 1", keyword = "skrzyzowanerece1", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", anim = "idle_a", mode = 49}},
			{label = "Skrzyżowane rece 2", keyword = "skrzyzowanerece2", type = "anim", data = {lib = "amb@world_human_hang_out_street@male_c@idle_a", anim = "idle_b", mode = 49}},
			{label = "Skrzyżowane rece 3", keyword = "skrzyzowanerece3", type = "anim", data = {lib = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", mode = 49}},
			{label = "Skrzyżowane rece 4", keyword = "skrzyzowanerece4", type = "anim", data = {lib = "random@street_race", anim = "_car_b_lookout", mode = 49}},
			{label = "Kajdanki", keyword = "kajdanki", type = "anim", data = {lib = "mp_arresting", anim = "idle", mode = 49}},
			{label = "Klaskanie", keyword = "klaskanie", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Facepalm", keyword = "facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "Samobójstwo", keyword = "ck", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
			{label = "Skok w bok", type = "anim", data = {lib = "melee@unarmed@streamed_core_psycho", anim = "victim_psycho_rear_takedown"}},
			{label = "Jezus", keyword = "jezus", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
			{label = "Palec w dziurke", keyword = "palec", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@dock", anim = "dock"}},	
			{label = "Jesteś pierdolnięty", keyword = "pierdolniety", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@you_loco", anim = "you_loco"}},
			{label = "Jaskółka", keyword = "jaskolka", type = "anim", data = {lib = "random@peyote@bird", anim = "wakeup"}},
			{label = "Kurczak", keyword = "kurczak", type = "anim", data = {lib = "random@peyote@chicken", anim = "wakeup"}},
			{label = "Cztery łapy", keyword = "4lapy", type = "anim", data = {lib = "random@peyote@deer", anim = "wakeup"}},
			{label = "Pies", keyword = "pies", type = "anim", data = {lib = "random@peyote@dog", anim = "wakeup"}}
		}
	},

	{
		name = 'poses',
		label = 'Zachowanie - Pozy',
		items = {
			{label = "Medytowanie", keyword = "medytowanie", type = "anim", data = {lib = "rcmcollect_paperleadinout@", anim = "meditiate_idle", mode = 1}},
			{label = "Medytowanie 2", keyword = "medytowanie2", type = "anim", data = {lib = "rcmepsilonism3", anim = "base_loop", mode = 1}},
			{label = "Medytowanie 3", keyword = "medytowanie3", type = "anim", data = {lib = "rcmcollect_paperleadinout@", anim = "meditiate_idle", mode = 51}},
			{label = "Myślenie", keyword = "myslenie", type = "anim", data = {lib = "mp_cp_welcome_tutthink", anim = "b_think", mode = 1}},			
			{label = "Myślenie 2", keyword = "myslenie2", type = "anim", data = {lib = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", mode = 1}},			
			{label = "Myślenie 3", keyword = "myslenie3", type = "anim", data = {lib = "timetable@tracy@ig_8@base", anim = "base", mode = 1}},		
			{label = "Myślenie 4", keyword = "myslenie4", type = "anim", data = {lib = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", mode = 51}},			
			{label = "Opieranie się o ladę", keyword = "opieranie", type = "anim", data = {lib = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", mode = 51}},
			{label = "Opieranie się o ladę 2", keyword = "opieranie2", type = "anim", data = {lib = "amb@prop_human_bum_shopping_cart@male@idle_a", anim = "idle_c", mode = s1}},						
			{label = "Opieranie się o ladę 3", keyword = "opieranie3", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@ig1_vip@", anim = "clubvip_base_laz", mode = s1}},						
			{label = "Ochroniarz", keyword = "ochroniarz", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND"}},
			{label = "Guard", keyword = "guard", type = "anim", data = {lib = "amb@world_human_stand_guard@male@base", anim = "base", mode = 49}},
			{label = "Biodra", keyword = "biodra", type = "anim", data = {lib = "random@shop_tattoo", anim = "_idle", mode = 49}},
			{label = "Palce na biodra", keyword = "biodra2", type = "anim", data = {lib = "amb@world_human_cop_idles@female@base", anim = "base", mode = 49}},
			{label = "Biodra i pas", keyword = "biodra3", type = "anim", data = {lib = "amb@world_human_cop_idles@male@idle_b", anim = "idle_e", mode = 49}},
			{label = "Policjant", keyword = "policjant", type = "scenario", data = {anim = "WORLD_HUMAN_COP_IDLES"}},
			{label = "Cop", keyword = "cop", type = "anim", data = {lib = "amb@code_human_wander_idles_cop@male@static", anim = "static", mode = 49}},
			{label = "Bandzior", keyword = "bandzi1or", type = "scenario", data = {anim = "WORLD_HUMAN_HIKER_STANDING"}},
			{label = "Luźno", keyword = "luzno", type = "anim", data = {lib = "amb@world_human_stand_impatient@female@no_sign@base", anim = "base", mode = 1}},
			{label = "Zastanowienie", keyword = "zastanowienie", type = "anim", data = {lib = "amb@world_human_prostitute@cokehead@base", anim = "base", mode = 49}},
			{label = "Niespokojny", keyword = "niespokojny", type = "anim", data = {lib = "amb@world_human_drug_dealer_hard@male@idle_a", anim = "idle_c", mode = 1}},
			{label = "Wyzywająca", keyword = "wyzywajaca", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arm_side@idle_a", anim = "idle_b", mode = 1}},
			{label = "Nuda", keyword = "nuda", type = "loop", data = {base = {lib = "amb@world_human_hang_out_street@female_hold_arm@enter", anim = "enter", length = 3600, entering = true}, idle = {lib = "amb@world_human_hang_out_street@female_hold_arm@base", anims = {{"base", 2500}}}, finish = {lib = "amb@world_human_hang_out_street@female_hold_arm@exit", anim = "exit", length = 2500}, mode = 0}},
			{label = "Zmęczenie", keyword = "zmeczenie", type = "anim", data = {lib = "rcmfanatic3leadinoutef_3_mcs_1", anim = "fra_outofbreath_loop", mode = 1}},
			{label = "W kieszeni", keyword = "wkieszeni", type = "anim", data = {lib = "rcmjosh1", anim = "idle", mode = 49}},
			{label = "Panika", keyword = "panika", type = "anim", data = {lib = "rcmlastone1", anim = "convict_idleshort", mode = 1}},
			{label = "Zniecierpliwienie", keyword = "zniecierpliwienie", type = "anim", data = {lib = "rcmme_tracey1", anim = "nervous_loop", mode = 1}},
			{label = "Myśliciel", keyword = "mysliciel", type = "anim", data = {lib = "rcmnigel3_idles", anim = "base_nig", mode = 49}},
			{label = "Drążenie butem", keyword = "butem", type = "anim", data = {lib = "anim@mp_freemode_return@f@idle", anim = "idle_c", mode = 1}},
			{label = "T-Pose", keyword = "tpose", type = "anim", data = {lib = "custom@suspect", anim = "suspect", mode = 1}},
			{label = "Dab", keyword = "dab", type = "anim", data = {lib = "custom@dab", anim = "dab", mode = 1}},
			{label = "Cant See", keyword = "cantsee", type = "anim", data = {lib = "custom@cant_see", anim = "cant_see", mode = 1}},
			{label = "Sheeeeesh", keyword = "sheesh", type = "anim", data = {lib = "custom@sheeeeesh", anim = "sheeeeesh", mode = 1}}
			
		}
	},

	{
		name  = 'leaning',
		label = 'Zachowanie - Siadanie / Leżenie / Opieranie',
		items = {
			{label = "Menel", keyword = "menel", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
			{label = "Menel (M)", keyword = "menelm", type = "anim", data = {lib = "amb@world_human_picnic@male@base", anim = "base", mode = 1}},
			{label = "Menel (K)", keyword = "menelk", type = "anim", data = {lib = "amb@world_human_picnic@female@base", anim = "base", mode = 1}},
			{label = "Usiądź", keyword = "usiadz", type = "anim", data = {lib = "switch@michael@sitting", anim = "idle", mode = 1}},
			{label = "Usiądź przechylone", keyword = "usiadz2", type = "anim", data = {lib = "timetable@amanda@ig_7", anim = "base", mode = 1}},
			{label = "Usiądź na kanapie", keyword = "usiadz3", type = "anim", data = {lib = "timetable@maid@couch@", anim = "base", mode = 1}},
			{label = "Usiądź na kanapie v2", keyword = "usiadz4", type = "anim", data = {lib = "timetable@reunited@ig_10", anim = "base_jimmy", mode = 1}},
			{label = "Usiądź noga na noge", keyword = "usiadz5", type = "anim", data = {lib = "timetable@reunited@ig_10", anim = "base_amanda", mode = 1}},
			{label = "Usiądź zgarbiony", keyword = "usiadz6", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "base", mode = 1}},
			{label = "Usiądź na kibel", keyword = "usiadz7", type = "anim", data = {lib = "timetable@trevor@on_the_toilet", anim = "trevonlav_baseloop", mode = 1}},
			{label = "Losowe opieranie się", keyword = "lopieranie", type = "scenario", data = {anim = "WORLD_HUMAN_LEANING"}},
			{label = "Opieranie się", keyword = "opieranie", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@legs_crossed@base", anim = "base", mode = 1}},
			{label = "Opieranie się v2", keyword = "opieranie2", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@hands_together@base", anim = "base", mode = 1}},
			{label = "Opieranie się v3", keyword = "opieranie3", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@foot_up@base", anim = "base", mode = 1}},
			{label = "Opieranie się na ramionach", keyword = "opieranie4", type = "anim", data = {lib = "missstrip_club_lean", anim = "player_lean_rail_loop", mode = 1}},
			{label = "Opieranie się na rękach", keyword = "opieranie5", type = "anim", data = {lib = "mp_safehousebeer@", anim = "base_drink", mode = 1}},
			{label = "Opieranie się do tyłu", keyword = "opieranie6", type = "anim", data = {lib = "anim@amb@nightclub@gt_idle@", anim = "base", mode = 1}},
			{label = "Opieranie na ramieniu", keyword = "opieranie8", type = "anim", data = {lib = "rcmjosh2", anim = "josh_2_intp1_base", mode = 17}},
			{label = "Opieranie na ramieniu v2", keyword = "opieranie9", type = "anim", data = {lib = "timetable@mime@01_gc", anim = "idle_a", mode = 1}},
			{label = "Kucnięcie z podparciem", keyword = "zpodparciem", type = "anim", data = {lib = "misscarstealfinalecar_5_ig_3", anim = "crouchloop", mode = 1}},
			{label = "Leżenie na plecach", keyword = "lezenie", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Leżenie na plecach v2", keyword = "lezenie2", type = "anim", data = {lib = "timetable@tracy@sleep@", anim = "idle_c", mode = 1}},
			{label = "Leżenie na brzuchu", keyword = "lezenie3", type = "anim", data = {lib = "amb@world_human_sunbathe@male@front@base", anim = "base", mode = 1}},
			{label = "Leżenie na brzuchu v2", keyword = "lezenie4", type = "anim", data = {lib = "amb@world_human_sunbathe@female@front@base", anim = "base", mode = 1}},
			{label = "Leżenie na boku", keyword = "lezenie5", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_left_side@base", anim = "base", mode = 1}},
			{label = "Leżenie na boku v2", keyword = "lezenie6", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_sofa@", anim = "lowsofa_dlg_fuckedup_laz", mode = 1}},
			{label = "Leżenie na kanapie", keyword = "lezenie7", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "laying", mode = 1}},
			{label = "Kładzenie się do łóżka", keyword = "kladzenie", type = "anim", data = {lib = "mp_bedmid", anim = "f_getin_l_bighouse"}},
			{label = "Siedzenie z telefonem", keyword = "siedzenie", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle", mode = 1}},
			{label = "Siedzenie na ziemii na luzaku", keyword = "siedzenie", type = "anim", data = {lib = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", mode = 1}},
			{label = "Siedzenie na ziemii na luzaku v2", keyword = "siedzenie2", type = "anim", data = {lib = "timetable@jimmy@mics3_ig_15@", anim = "idle_a_jimmy", mode = 1}},
			{label = "Siedzenie na ziemii w zwarciu", keyword = "siedzenie3", type = "anim", data = {lib = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_fallasleep_nowork", mode = 1}},
			{label = "Siedzenie na ziemii przygnębiony", keyword = "siedzenie4", type = "anim", data = {lib = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_sleeping-noworkfemale", mode = 1}},
			{label = "Siedzenie po turecku z rękami w górze", keyword = "siedzenie3", type = "anim", data = {lib = "mp_fm_intro_cut", anim = "base_loop", mode = 1}},
			{label = "Siedzenie pod ścianą", keyword = "siedzenie6", type = "anim", data = {lib = "amb@world_human_stupor@male@idle_a", anim = "idle_b", mode = 1}},
			{label = "Siedzenie na ziemi załamany", keyword = "siedzenie7", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_dlg_longrant_laz", mode = 1}}
		}
	},

	{
		name  = 'situational',
		label = 'Zachowanie - Sytuacyjne',
		items = {
			{label = "Kłótnia 1", keyword = "klotnia1", type = "anim", data = {lib = "anim@amb@casino@brawl@fights@argue@", anim = "arguement_loop_mp_m_brawler_01"}},
			{label = "Kłótnia 2", keyword = "klotnia2", type = "anim", data = {lib = "sdrm_mcs_2-0", anim = "csb_bride_dual-0", mode = 48}},
			{label = "Zimny łokieć 1", keyword = "lokiec1", type = "anim", data = {lib = "anim@veh@lowrider@std@ds@arm@base", anim = "sit_low_lowdoor", mode = 49}},
			{label = "Zimny łokieć 2", keyword = "lokiec2", type = "anim", data = {lib = "anim@veh@lowrider@std@ds@arm@music@countrybase", anim = "base", mode = 49}},
			{label = "Zimny łokieć w aucie 1", keyword = "lokiecwaucie1", type = "anim", data = {lib = "anim@veh@lowrider@std@ds@arm@base", anim = "sit_low_lowdoor", car = true}},
			{label = "Zimny łokieć w aucie 2", keyword = "lokiecwaucie2", type = "anim", data = {lib = "anim@veh@lowrider@std@ds@arm@music@countrybase", anim = "base", car = true}},
			{label = "Środkowy", keyword = "srodkowy", type = "anim", data = {lib = "anim@mp_player_intupperfinger", anim = "idle_a_fp", mode = 49}},
			{label = "Punkt", keyword = "punkt", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_point", mode = 49}},
			{label = "Strzał", keyword = "strzal", type = "anim", data = {lib = "random@dealgonewrong", anim = "idle_a", mode = 49}},
			{label = "Nie wiem 1", keyword = "niewiem1", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_shrug_hard", mode = 49}},
			{label = "Nie wiem 2", keyword = "niewiem2", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_shrug_hard", mode = 49}},
			{label = "W góre 1", keyword = "wgore1", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_uplow@ds@", anim = "enter", mode = 49}},
			{label = "W góre 2", keyword = "wgore2", type = "anim", data = {lib = "anim@mp_player_intselfiethumbs_up", anim = "idle_a", mode = 49}},
			{label = "W góre 3", keyword = "wgore3", type = "anim", data = {lib = "anim@mp_player_intupperthumbs_up", anim = "idle_a", mode = 49}},
			{label = "Fala 1", keyword = "fala1", type = "anim", data = {lib = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b", mode = 49}},
			{label = "Fala 2", keyword = "fala2", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@wave", anim = "wave", mode = 49}},
			{label = "Fala 3", keyword = "fala3", type = "anim", data = {lib = "friends@fra@ig_1", anim = "over_here_idle_a", mode = 49}},
			{label = "Fala 4", keyword = "fala4", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_a", mode = 49}},
			{label = "Fala 5", keyword = "fala5", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_b", mode = 49}},
			{label = "Gwizdanie 1", keyword = "gwizdanie1", type = "anim", data = {lib = "taxi_hail", anim = "hail_taxi", mode = 49}},
			{label = "Gwizdanie 2", keyword = "gwizdanie2", type = "anim", data = {lib = "rcmnigel1c", anim = "hailing_whistle_waive_a", mode = 49}},
			{label = "Ukłon 1", keyword = "uklon1", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st"}},
			{label = "Ukłon 2", keyword = "uklon2", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_1st"}},
			{label = "Selfie", keyword = "selfie", type = "scenario", data = {anim = "WORLD_HUMAN_TOURIST_MOBILE"}},
			{label = "Ręce za glowe", keyword = "rece", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c", mode = 49}},
			{label = "Strach", keyword = "strach", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "Zakładnik", keyword = "zakladnik", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c", mode = 1}},
			{label = "Zakładnik z podniesionymi rękami", keyword = "zakladnik2", type = "anim", data = {lib = "random@getawaydriver", anim = "idle_a", mode = 1}},
			{label = "Chowanie się", keyword = "chowanie", type = "anim", data = {lib = "mp_am_hold_up", anim = "cower_loop"}},
			{label = "Rozpacz", keyword = "rozpacz", type = "anim", data = {lib = "mp_bank_heist_1", anim = "f_cower_01"}},
			{label = "Poddanie się na glebe", keyword = "poddanie", type = "anim", data = {lib = "mp_bank_heist_1", anim = "prone_l_front_intro", mode = 2}},
			{label = "Rozgladanie się", keyword = "rozgladanie", type = "scenario", data = {anim = "CODE_HUMAN_CROSS_ROAD_WAIT"}},
			{label = "Rozgladanie się v2", keyword = "rozgladanie2", type = "anim", data = {lib = "mp_fm_intro_cut", anim = "idle_a"}},
			{label = "Wkurzenie się", keyword = "wkurzenie", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@freakout", anim = "freakout"}},
			{label = "Wymiotowanie w aucie", keyword = "wymiotuj", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside", car = true}},
			{label = "Kibicowanie", keyword = "kibicowanie", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_b_player_b", mode = 1}},
			{label = "Kibicowanie v2", keyword = "kibicowanie2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", mode = 1}},
			{label = "Ręce do tyłu", keyword = "rece2", type = "anim", data = {lib = "anim@miss@low@fin@vagos@", anim = "idle_ped06", mode = 49}},
			{label = "Drapanie się po tyłku", keyword = "drapanie", type = "anim", data = {lib = "anim@heists@team_respawn@respawn_01", anim = "heist_spawn_01_ped_d", mode = 49}},
			{label = "Otrzepanie się", keyword = "otrzepanie", type = "anim", data = {lib = "move_m@_idles@shake_off", anim = "shakeoff_1"}},
			{label = "Otrzepanie się v2", keyword = "otrzepanie2", type = "anim", data = {lib = "move_m@_idles@wet", anim = "fidget_wet"}},
			{label = "Sprawdzanie wody pod prysznicem", keyword = "woda", type = "anim", data = {lib = "mp_safehouseshower@female@", anim = "shower_enter_into_idle"}},
			{label = "Mycie się", keyword = "mycie", type = "anim", data = {lib = "mp_safehouseshower@female@", anim = "shower_idle_a"}},
			{label = "Mycie się v2", keyword = "mycie2", type = "anim", data = {lib = "mp_safehouseshower@male@", anim = "male_shower_idle_a"}},
			{label = "Oczekiwanie", keyword = "oczekiwanie", type = "anim", data = {lib = "rcmjosh1leadinout", anim = "idle_josh"}},
			{label = "Czytanie", keyword = "czytanie", type = "anim", data = {lib = "misscarsteal4@vendor", anim = "base_customer1", mode = 1}},
			{label = "Kac", keyword = "kac", type = "anim", data = {lib = "random@peyote@generic", anim = "wakeup"}},
		}
	},

	{
		name  = 'festives',
		label = 'Zachowanie - Imprezka',
		items = {
			{label = "Klaun 1", keyword = "klaun1", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_0", mode = 1}},
			{label = "Klaun 2", keyword = "klaun2", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_1", mode = 1}},
			{label = "Klaun 3", keyword = "klaun3", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_2", mode = 1}},
			{label = "Klaun 4", keyword = "klaun4", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_3", mode = 1}},
			{label = "Klaun 5", keyword = "klaun5", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_6", mode = 1}},
			{label = "Nerwowy 1", keyword = "nerwowy1", type = "anim", data = {lib = "mp_missheist_countrybank@nervous", anim = "nervous_idle", mode = 1}},
			{label = "Nerwowy 2", keyword = "nerwowy2", type = "anim", data = {lib = "amb@world_human_bum_standing@twitchy@idle_a", anim = "idle_c", mode = 1}},
			{label = "Nerwowy 3", keyword = "nerwowy3", type = "anim", data = {lib = "rcmme_tracey1", anim = "nervous_loop", mode = 1}},
			{label = "Granie na instrumentach", keyword = "granie", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}}, -- todo
			{label = "DJ", keyword = "dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "Picie kawy w miejscu", keyword = "kawa", type = "loop", data = {base = {lib = "amb@world_human_aa_coffee@base", anim = "base", length = 3600}, idle = {lib = "amb@world_human_aa_coffee@idle_a", anims = {{"idle_a", 6200}, {"idle_b", 3700}, {"idle_c", 6500}}}, finish = {lib = "amb@world_human_aa_coffee@base", anim = "base", length = 4500}, mode = 0, prop = {object = "p_ing_coffeecup_01", bone = 57005, offset = {x = 0.125, y = 0.02, z = -0.03}, rotation = {x = 95.0, y = 140.0, z = 190.0}, dettach = true}}},
			{label = "Picie kawy", keyword = "kawa2", type = "anim", data = {lib = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", mode = 49, prop = {object = "p_ing_coffeecup_01", bone = 57005, offset = {x = 0.125, y = 0.02, z = -0.03}, rotation = {x = 95.0, y = 140.0, z = 190.0}}}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			{label = "Robienie grilla", keyword = "grill", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}}, -- todo
			{label = "Wciąganie mety", keyword = "meta", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "missfbi3_party_snort_coke_b_male3", mode = 1}},
			{label = "Z gleby", keyword = "zgleby", type = "anim", data = {lib = "random@peyote@eat", anim = "eat_peyote"}},
			{label = "Wydurnianie", keyword = "wydurnianie", type = "anim", data = {lib = "timetable@tracy@ig_5@idle_a", anim = "idle_c"}},
			{label = "Wydurnianie v2", keyword = "wydurnianie2", type = "anim", data = {lib = "timetable@tracy@ig_5@idle_b", anim = "idle_d"}}
		}
	},

	{
		name  = 'rannys',
		label = 'Interakcje - Rany / Medyczne',
		items = {
			{label = "Zemdlał 1", keyword = "zemdlal1", type = "anim", data = {lib = "missarmenian2", anim = "drunk_loop", mode = 1}},
			{label = "Zemdlał 2", keyword = "zemdlal2", type = "anim", data = {lib = "missarmenian2", anim = "corpse_search_exit_ped", mode = 1}},
			{label = "Zemdlał 3", keyword = "zemdlal3", type = "anim", data = {lib = "anim@gangops@morgue@table@", anim = "body_search", mode = 1}},
			{label = "Zemdlał 4", keyword = "zemdlal4", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_pumpchest_idle", mode = 1}},
			{label = "Zemdlał 5", keyword = "zemdlal5", type = "anim", data = {lib = "random@mugging4", anim = "flee_backward_loop_shopkeeper", mode = 1}},
			{label = "Podpinanie KM", keyword = "podpinaniekm", type = "anim", data = {lib = "creatures@rottweiler@tricks@", anim = "petting_franklin", mode = 1}},
			{label = "Upadek", keyword = "upadek", type = "ragdoll", data = {}},
			{label = "Postrzelony", keyword = "postrzelony", type = "anim", data = {lib = "random@dealgonewrong", anim = "idle_a", mode = 1}},
			{label = "Postrzelony 2", keyword = "postrzelony2", type = "anim", data = {lib = "random@dealgonewrong", anim = "idle_a", mode = 51}},
			{label = "RKO", keyword = "rko", type = "anim", data = {lib = "missheistfbi3b_ig8_2", anim = "cpr_loop_paramedic", mode = 1}},
			{label = "Postrzał w brzuch", keyword = "postrzal", type = "anim", data = {lib = "random@crash_rescue@wounded@base", anim = "base", mode = 1}},
			{label = "Ból brzucha", keyword = "bol", type = "anim", data = {lib = "combat@damage@writheidle_a", anim = "writhe_idle_a", mode = 1}},
			{label = "Ból głowy", keyword = "bol2", type = "anim", data = {lib = "combat@damage@writheidle_b", anim = "writhe_idle_f", mode = 1}},
			{label = "Ból nogi", keyword = "bol3", type = "anim", data = {lib = "combat@damage@writheidle_b", anim = "writhe_idle_e", mode = 1}},
			{label = "Ból pleców", keyword = "bol4", type = "anim", data = {lib = "anim@move_lester", anim = "idle_a", mode = 49}},
			{label = "Ból serca", keyword = "bol5", type = "anim", data = {lib = "rcmfanatic1out_of_breath", anim = "p_zero_tired_01"}},
			{label = "Wymiotowanie do toalety", keyword = "wymiotowanie", type = "anim", data = {lib = "timetable@tracy@ig_7@idle_a", anim = "idle_a", mode = 1}},
			{label = "Po uderzeniu w głowę", keyword = "uderzeniewglowe", type = "anim", data = {lib = "misscarsteal4@actor", anim = "stumble"}},
			{label = "Po uderzeniu w głowę v2", keyword = "uderzeniewglowe2", type = "anim", data = {lib = "misscarsteal4@actor", anim = "dazed_idle", mode = 49}}
		}
	},

	{
		name = 'interaction',
		label = 'Interakcje - Samemu',
		items = {
			{label = "Wariat 1", keyword = "wariat1", type = "anim", data = {lib = "random@peyote@dog", anim = "wakeup", mode = 1}},
			{label = "Wariat 2", keyword = "wariat2", type = "anim", data = {lib = "random@peyote@rabbit", anim = "wakeup", mode = 1}},
			{label = "Wariat 3", keyword = "wariat3", type = "anim", data = {lib = "missexile3", anim = "ex03_train_roof_idle", mode = 1}},
			{label = "Wariat 4", keyword = "wariat4", type = "anim", data = {lib = "special_ped@jane@monologue_5@monologue_5c", anim = "brotheradrianhasshown_2", mode = 1}},
			{label = "Bankomat", keyword = "bankomat", type = "scenario", data = {anim = "PROP_HUMAN_ATM"}},
			{label = "Pisanie na klawiaturze", keyword = "klawiatura", type = "anim", data = {lib = "anim@heists@prison_heiststation@cop_reactions", anim =  "cop_b_idle", mode = 51}},
			{label = "Pisanie na klawiaturze 2", keyword = "klawiatura2", type = "anim", data = {lib = "mp_prison_break", anim = "hack_loop", mode = 1}},
			{label = "Pisanie na klawiaturze 3", keyword = "klawiatura3", type = "anim", data = {lib = "mp_fbi_heist", anim = "loop", mode = 51}},					
			{label = "Notes", keyword = "notes", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"}},
			{label = "Założone ręce", keyword = "foch", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@base", anim = "base", mode = 49}},
			{label = "Założone ręce v2", keyword = "foch2", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", mode = 49}},
			{label = "Oprzyj się", keyword = "oprzyj", type = "anim", data = {lib = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", mode = 1}},
			{label = "Kciuk w górę", keyword = "kciuk", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_uplow@ds@", anim = "idle_a", mode = 49}},
			{label = "Kciuk w dół", keyword = "kciuk2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_a"}},
			{label = "Dłubanie w nosie", keyword = "nos", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@nose_pick", anim = "nose_pick", mode = 49}},
			{label = "Wybierz mnie", keyword = "mnie", type = "anim", data = {lib = "missmic4premiere", anim = "crowd_b_idle_01"}},
			{label = "Głupio wyszło", keyword = "glupio", type = "anim", data = {lib = "missmic4premiere", anim = "interview_short_anton"}},
			{label = "Przykro mi", keyword = "przykro", type = "anim", data = {lib = "missmurder", anim = "idle"}},
			{label = "Niegrzeczny palec", keyword = "niegrzeczny", type = "anim", data = {lib = "anim@mp_player_intincarno_waystd@ps@", anim = "enter"}},
			{label = "Stopowicz", keyword = "stopowicz", type = "anim", data = {lib = "random@hitch_lift", anim = "idle_f", mode = 1}},
			{label = "Łapie za głowę", keyword = "glowa", type = "anim", data = {lib = "random@mugging3", anim = "agitated_loop_b"}},
			{label = "Metal", keyword = "metal", type = "anim", data = {lib = "anim@mp_player_intincarrockstd@ps@", anim = "idle_a", mode = 49}}		
	    }
	},

	{
		name  = 'conversation',
		label = 'Interakcje - Z innymi',
		items = {
			{label = "Zagwostka 1", keyword = "zagwostka1", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@mind_blown", anim = "mind_blown", mode = 49}},
			{label = "Zagwostka 2", keyword = "zagwostka2", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@mind_blown", anim = "mind_blown", mode = 1}},
			{label = "Nie 1", keyword = "nie1", type = "anim", data = {lib = "anim@heists@ornate_bank@chat_manager", anim = "fail", mode = 49}},
			{label = "Okejka 1", keyword = "okejka1", type = "anim", data = {lib = "anim@mp_player_intselfiedock", anim = "idle_a", mode = 49}},
			{label = "Nosek 1", keyword = "nosek1", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@nose_pick", anim = "nose_pick", mode = 1}},
			{label = "Pokój 1", keyword = "pokoj1", type = "anim", data = {lib = "anim@mp_player_intupperpeace", anim = "idle_a", mode = 49}},
			{label = "Króliczek 1", keyword = "kroliczek1", type = "anim", data = {lib = "random@peyote@rabbit", anim = "wakeup", mode = 1}},
			{label = "Będzie walka 1", keyword = "bedziewalka1", type = "anim", data = {lib = "misscommon@response", anim = "screw_you", mode = 1}},
			{label = "Slide 1", keyword = "slide1", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", mode = 1}},
			{label = "Slide 2", keyword = "slide2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_b_player_a", mode = 1}},
			{label = "Slide 2", keyword = "slide3", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_c_player_a", mode = 1}},
			{label = "Tyle ci powiem 1", keyword = "tylecipowiem1", type = "anim", data = {lib = "missfam5_yoga", anim = "a2_pose", mode = 49}},
			{label = "No nie wiem 1", keyword = "noniewiem1", type = "anim", data = {lib = "anim@amb@casino@hangout@ped_male@stand@02b@idles", anim = "idle_a", mode = 49}},
			{label = "Jest całkiem nieźle 1", keyword = "calkiemniezle1", type = "anim", data = {lib = "random@hitch_lift", anim = "idle_f", mode = 49}},
			{label = "LoL 1", keyword = "lol1", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "laugh_a_player_b", mode = 49}},
			{label = "Ja 1", keyword = "ja1", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_me_hard", mode = 49}},
			{label = "O boi 1", keyword = "O boi 1", type = "anim", data = {lib = "special_ped@jane@monologue_5@monologue_5", anim = "brotheradrianhasshown_2", mode = 49}},
			{label = "Daj to do mnie 1", keyword = "dajtodomnie1", type = "anim", data = {lib = "misscommon@response", anim = "bring_it_on", mode = 49}},
			{label = "Celebrowanie 1", keyword = "celebrowanie1", type = "anim", data = {lib = "rcmfanatic1celebrate", anim = "celebrate", mode = 49}},
			{label = "Klaskanie Wolno 1", keyword = "klaskaniewolno1", type = "anim", data = {lib = "amb@world_human_cheering@male_a", anim = "base", mode = 49}},
			{label = "Walnij go 1", keyword = "walnijgo1", type = "anim", data = {lib = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_slap", mode = 49}},
			{label = "Czołganie 1", keyword = "czolganie1", type = "anim", data = {lib = "move_injured_ground", anim = "front_loop", mode = 1}},
			{label = "Curtsy 1", keyword = "curtsy1", type = "anim", data = {lib = "anim@mp_player_intcelebrationpaired@f_f_sarcastic", anim = "sarcastic_left", mode = 49}},
			{label = "Podcięcie gardła 1", keyword = "podcieciegardla1", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@cut_throat", anim = "cut_throat", mode = 49}},
			{label = "Znak Gangu 1", keyword = "znakgangu1", type = "anim", data = {lib = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b", mode = 49}},
			{label = "Damn 1", keyword = "damn1", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn", mode = 49}},
			{label = "Damn 2", keyword = "damn2", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_mid", mode = 49}},
			{label = "Palec w dół 1", keyword = "palecwdol1", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_hand_down", mode = 49}},
			{label = "Walcz ze mną 1", keyword = "walczzemna1", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_c", mode = 49}},
			{label = "Walcz ze mną 2", keyword = "walczzemna2", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", mode = 49}},
			{label = "Pijany 1", keyword = "pijany1", type = "anim", data = {lib = "random@drunk_driver_1", anim = "drunk_fall_over", mode = 49}},
			{label = "Pijany 2", keyword = "pijany2", type = "anim", data = {lib = "friends@frf@ig_2", anim = "knockout_plyr", mode = 49}},
			{label = "Palec 1", keyword = "palec1", type = "anim", data = {lib = "anim@mp_player_intupperfinger", anim = "idle_a_fp", mode = 49}},
			{label = "Drapanie sie po glowie", keyword = "drapanie", type = "anim", keyword = "hm", data = {lib = "mp_cp_stolen_tut", anim = "b_think", mode = 48}},
			{label = "Jest Dobrze!", keyword = "jd", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up"}},
			{label = "Przytulanie", keyword = "przytul", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "Spokojnie", keyword = "spokojnie", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "Zdziwienie", keyword = "zdziwienie", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
			{label = "A niech to licho!", keyword = "licho", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			{label = "Super", keyword = "super", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "No i co z tego?", keyword = "ico", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "Ja", keyword = "ja", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "Klęczenie", keyword = "kleczenie", type = "anim", data = {lib = "amb@medic@standing@kneel@base", anim = "base", mode = 2}},
			{label = "Zestresowana", keyword = "zestresowana", type = "anim", data = {lib = "random@hitch_lift", anim = "f_distressed_loop"}}
		}
	},

	{
		name  = 'work',
		label = 'Interakcje - Praca',
		items = {
			{label = "Celowanie 1", keyword = "celowanie1", type = "anim", data = {lib = "random@atmrobberygen", anim = "b_atm_mugging", mode = 49}},
			{label = "Celowanie 2", keyword = "celowanie2", type = "anim", data = {lib = "random@countryside_gang_fight", anim = "biker_02_stickup_loop", mode = 49}},
			{label = "Zastanowienie 1", keyword = "zastanowienie1", type = "anim", data = {lib = "random@countrysiderobbery", anim = "idle_a"}},
			{label = "Zaciąganie 1", keyword = "zaciaganie1", type = "anim", data = {lib = "random@mugging4", anim = "struggle_loop_b_thief"}},
			{label = "Ręce w górze 1", keyword = "recewgorze1", type = "anim", data = {lib = "missminuteman_1ig_2", anim = "handsup_base", mode = 49}},
			{label = "Pukanie 1", keyword = "pukanie1", type = "anim", data = {lib = "timetable@jimmy@doorknock@", anim = "knockdoor_idle", mode = 49}},
			{label = "Przygotowanie broni", keyword = "bron", type = "anim", data = {lib = "mp_corona@single_team", anim = "single_team_intro_one"}},
			{label = "Robienie zdjęć", keyword = "foto", type = "loop",  data = {base = {lib = "amb@world_human_paparazzi@male@enter", anim = "enter", length = 1000}, idle = {lib = "amb@world_human_paparazzi@male@idle_a", anims = {{"idle_a", 6000}, {"idle_b", 6000}, {"idle_c", 5000}}}, finish = {lib = "amb@world_human_paparazzi@male@exit", anim = "exit", length = 1000}, mode = 0, prop = {object = "prop_pap_camera_01", bone = 58866, offset = {x = 0.1, y = -0.05, z = 0.0}, rotation = {x = -10.0, y = 50.0, z = 5.0}, dettach = false}}},
			{label = "Żebrak", keyword = "zebrak", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}}, -- todo
			{label = "Pakowanie na naczepę", keyword = "pakowanie", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
			{label = "Kierowanie ruchem", keyword = "kierowanie", type = "anim", data = {lib = "amb@world_human_car_park_attendant@male@base", anim = "base", mode = 1, prop = {bone = 57005, object = "prop_parking_wand_01", offset = {x = 0.1, y = 0.0, z = -0.03}, rotation = {x = -60.0, y = 0.0, z = 0.0}}}},
			{label = "Wędkowanie", keyword = "wedkowanie", type = "scenario", data = {anim = "WORLD_HUMAN_STAND_FISHING"}},
			{label = "Podsłuchiwanie", keyword = "podsluch", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}},
			{label = "Szukanie śladów", keyword = "szukanie", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Kopanie w ogródku", keyword = "kopanie", type = "scenario", data = {anim = "WORLD_HUMAN_GARDENER_PLANT"}},
			{label = "Kopanie łopatą", keyword = "kopanie2", type = "anim", data = {lib = "random@burial", anim = "a_burial", mode = 1, prop = {bone = 28422, object = "prop_ld_shovel", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Pisanie na klawiaturze", keyword = "klawiatura", type = "anim", data = {lib = "missah_2_ext_altleadinout", anim = "hack_loop", mode = 1}},
			{label = "Sprawdzanie notatek", keyword = "notatki", type = "anim", data = {lib = "amb@world_human_clipboard@male@idle_a", anim = "idle_c", mode = 49, prop = {bone = 36029, object = "p_amb_clipboard_01", offset = {x = 0.1, y = 0.015, z = 0.12}, rotation = {x = -120.0, y = -60.0, z = 0.0}}}},
			{label = "Młotek", keyword = "mlotek", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "Mycie okna", keyword = "mycieokna", type = "scenario", data = {anim = "WORLD_HUMAN_MAID_CLEAN"}},
			{label = "Mim", keyword = "mim", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
			{label = "Mycie blatu", keyword = "mycieblatu", type = "anim", data = {lib = "timetable@floyd@clean_kitchen@base", anim = "base", mode = 1}},
			{label = "Wymiana żarówki", keyword = "zarowka", type = "anim", data = {lib = "amb@prop_human_movie_bulb@base", anim = "base", mode = 1}},
			{label = "Mechanik", keyword = "mechanik", type = "anim", data = {lib = "amb@world_human_vehicle_mechanic@male@base", anim = "base", mode = 1}},
			{label = "Mechanik 2", keyword = "mechanik2", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped", mode = 1}},
			{label = "Mechanik 3", keyword = "mechanik3", type = "anim", data = {lib = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", mode = 1}},
			{label = "Mechanik 4", keyword = "mechanik4", type = "anim", data = {lib = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", mode = 51}},
			{label = "Wiercenie wiertarką", keyword = "wiertarka", type = "anim", data = {lib = "anim@heists@fleeca_bank@drilling", anim = "drill_straight_start", mode = 1, prop = {bone = 57005, object = "prop_tool_drill", offset = {x = 0.1, y = 0.04, z = -0.03}, rotation = {x = -90.0, y = 180.0, z = 0.0}}}},
		}
	},

	{
		name  = 'sports',
		label = 'Interakcje - Sporty',
		items = {
			{label = "Namaste 1", keyword = "namaste1", type = "anim", data = {lib = "timetable@amanda@ig_4", anim = "ig_4_base", mode = 49}},
			{label = "Superhero 1", keyword = "superhero1", type = "anim", data = {lib = "rcmbarry", anim = "base", mode = 49}},
			{label = "Superhero 2", keyword = "superhero2", type = "anim", data = {lib = "rcmbarry", anim = "mind_control_b_loop", mode = 49}},
			{label = "Superhero 3", keyword = "superhero3", type = "anim", data = {lib = "rcmbarry", anim = "bar_1_attack_idle_aln", mode = 49}},
			{label = "Schylanie 1", keyword = "schylanie1", type = "anim", data = {lib = "random@domestic", anim = "pickup_low", mode = 49}},
			{label = "Boks 1", keyword = "boks1", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@shadow_boxing", anim = "shadow_boxing", mode = 49}},
			{label = "Boks 2", keyword = "boks2", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@shadow_boxing", anim = "shadow_boxing", mode = 49}},
			{label = "Jogging 1", keyword = "jogging1", type = "anim", data = {lib = "amb@world_human_jog_standing@male@idle_a", anim = "idle_a", mode = 49}},
			{label = "Jogging 2", keyword = "jogging2", type = "anim", data = {lib = "amb@world_human_jog_standing@female@idle_a", anim = "idle_a", mode = 49}},
			{label = "Jogging 3", keyword = "jogging3", type = "anim", data = {lib = "amb@world_human_power_walker@female@idle_a", anim = "idle_a", mode = 49}},
			{label = "Karate 1", keyword = "karate1", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@karate_chops", anim = "karate_chops", mode = 1}},
			{label = "Karate 2", keyword = "karate2", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@karate_chops", anim = "karate_chops", mode = 1}},
			{label = "Na kucaka 1", keyword = "nakucaka1", type = "anim", data = {lib = "rcmextreme3", anim = "idle", mode = 1}},
			{label = "Garda", keyword = "garda", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Rozgrzewka", keyword = "rozgrzewka", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "Bitka", keyword = "bitka", type = "anim", data = {lib = "mp_deathmatch_intros@unarmed", anim = "intro_male_unarmed_b"}},
			{label = "Pompki", keyword = "pompki", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base", mode = 1}},
			{label = "Brzuszki", keyword = "brzuszki", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base", mode = 1}},
			{label = "Napinanie", keyword = "napinanie1", type = "scenario", data = {anim = "WORLD_HUMAN_MUSCLE_FLEX"}},
			{label = "Napinanie mięśni", keyword = "napinanie2", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "Napinanie bicków", keyword = "napinanie3", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_in_front@idle_a", anim = "idle_a"}},
			{label = "Trenowanie bicków", keyword = "bicki", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "Yoga", keyword = "yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
			{label = "Salto w tył", keyword = "salto", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a"}},
			{label = "Gwiazda", keyword = "gwiazda", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a"}},
			{label = "Rozciąganie", keyword = "rozciaganie", type = "anim", data = {lib = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e"}},
			{label = "Pajacyki", keyword = "pajacyki", type = "anim", data = {lib = "timetable@reunited@ig_2", anim = "jimmy_masterbation"}}
		}
	},
	
	{
		name = 'objects',
		label = 'Interakcje - Obiekty',
		items = {
			{label = "Parasolka", type = "anim", keyword = "parasolka", data = {lib = "amb@world_human_drinking@coffee@male@base", anim = "base", mode = 49, prop = {bone = 57005, object = "p_amb_brolly_01", offset = {x = 0.15, y = 0.005, z = 0.0}, rotation = {x = 87.0, y = -20.0, z = 180.0}}}},
			{label = "Whiskey", type = "anim", keyword = "whiskey", data = {lib = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", mode = 49, prop = {bone = 28422, object = "prop_drink_whisky", offset = {x = 0.01, y = -0.01, z = -0.06}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Piwo", type = "anim", keyword = "piwo", data = {lib = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", mode = 49, prop = {bone = 28422, object = "prop_amb_beer_bottle", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Kubek", type = "anim", keyword = "kubek", data = {lib = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", mode = 49, prop = {bone = 28422, object = "prop_plastic_cup_02", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Wino", type = "anim", keyword = "wino", data = {lib = "anim@heists@humane_labs@finale@keycards", anim = "ped_a_enter_loop", mode = 49, prop = {bone = 18905, object = "prop_drink_redwine", offset = {x = 0.10, y = -0.03, z = 0.03}, rotation = {x = -100.0, y = 0.0, z = -10.0}}}},
			{label = "Szampan", type = "anim", keyword = "szampan", data = {lib = "anim@heists@humane_labs@finale@keycards", anim = "ped_a_enter_loop", mode = 49, prop = {bone = 18905, object = "prop_drink_champ", offset = {x = 0.10, y = -0.03, z = 0.03}, rotation = {x = -100.0, y = 0.0, z = -10.0}}}},
			{label = "Książka", type = "anim", keyword = "ksiazka", data = {lib = "cellphone@", anim = "cellphone_text_read_base", mode = 49, prop = {bone = 6286, object = "prop_novel_01", offset = {x = 0.15, y = 0.03, z = -0.065}, rotation = {x = 0.0, y = 180.0, z = 90.0}}}},
			{label = "Bukiet", type = "anim", keyword = "bukiet", data = {lib = "impexp_int-0", anim = "mp_m_waremech_01_dual-0", mode = 49, prop = {bone = 24817, object = "prop_snow_flower_02", offset = {x = -0.29, y = 0.40, z = -0.02}, rotation = {x = -90.0, y = -90.0, z = 0.0}}}},
			{label = "Misiek", type = "anim", keyword = "misiek", data = {lib = "impexp_int-0", anim = "mp_m_waremech_01_dual-0", mode = 49, prop = {bone = 24817, object = "v_ilev_mr_rasberryclean", offset = {x = -0.20, y = 0.46, z = -0.016}, rotation = {x =-180.0, y = -90.0, z = 0.0}}}},
			{label = "Mapa", type = "anim", keyword = "mapa", data = {lib = "amb@world_human_tourist_map@male@base", anim = "base", mode = 49, prop = {bone = 28422, object = "prop_tourist_map_01", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Bongo", type = "anim", keyword = "bongo", data = {lib = "anim@safehouse@bong", anim = "bong_stage3", mode = 49, prop = {bone = 18905, object = "hei_heist_sh_bong_01", offset = {x = 0.10, y = -0.25, z = 0.0}, rotation = {x = 95.0, y = 190.0, z = 180.0}}}},
			{label = "Trzęsienie Szampanem", type = "anim", keyword = "trzesienieszampanem", data = {lib = "anim@mp_player_intupperspray_champagne", anim = "idle_a", mode = 49, prop = {bone = 28422, object = "ba_prop_battle_champ_open", offset = {x = 0.0, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = 0.0}}}},
			{label = "Skrzynia z narzędziami", type = "anim", keyword = "skrzynka", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", mode = 49, prop = {bone = 57005, object = "prop_tool_box_04", offset = {x = 0.43, y = 0.0, z = -0.02}, rotation = {x = -90.0, y = 0.0, z = 90.0}}}},
			{label = "Skrzynka z wiertarką", type = "anim", keyword = "skrzynka2", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", mode = 49, prop = {bone = 57005, object = "prop_tool_box_02", offset = {x = 0.53, y = 0.0, z = -0.02}, rotation = {x = -90.0, y = 0.0, z = 90.0}}}},
			{label = "Paczka", type = "anim", keyword = "paczka", data = {lib = "anim@heists@box_carry@", anim = "idle", mode = 49, prop = {bone = 28422, object = "v_serv_abox_04", offset = {x = 0.0, y = -0.08, z = -0.17}, rotation = {x = 0.0, y = 0.0, z = 90.0}}}},
			{label = "Aktówka", type = "anim", keyword = "aktowka", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", mode = 49, prop = {bone = 57005, object = "prop_ld_case_01", offset = {x = 0.13, y = 0.0, z = -0.02}, rotation = {x = -90.0, y = 0.0, z = 90.0}}}},
			{label = "Walizka", type = "anim", keyword = "walizka", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", mode = 49, prop = {bone = 57005, object = "hei_p_attache_case_shut", offset = {x = 0.13, y = 0.0, z = 0.0}, rotation = {x = 0.0, y = 0.0, z = -90.0}}}},
			{label = "Walizka podróżna", type = "anim", keyword = "walizka2", data = {lib = "rcmepsilonism8", anim = "bag_handler_idle_a", mode = 49, prop = {bone = 57005, object = "prop_ld_suitcase_01", offset = {x = 0.36, y = 0.0, z = -0.02}, rotation = {x = -90.0, y = 0.0, z = 90.0}}}},
			{label = "Walizka na kółkach", type = "anim", keyword = "walizka3", data = {lib = "anim@heists@narcotics@trash", anim = "walk", mode = 49, prop = {bone = 57005, object = "prop_suitcase_03", offset = {x = 0.36, y = -0.45, z = -0.05}, rotation = {x = -50.0, y = -60.0, z = 15.0}}}}
		}
	},

	{
		name  = 'porn',
		label = 'Interakcje - PEGI 21',
		items = {
			{label = "Masturbacja", keyword = "masturbacja1", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01", mode = 49}},
			{label = "Masturbacja z wytryskiem", keyword = "masturbacja2", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@wank", anim = "wank"}},
			{label = "Pomaganie pani w aucie", keyword = "waucie1", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop", car = true}},
			{label = "Robienie loda w aucie", keyword = "waucie2", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop", car = true}},
			{label = "Seks w aucie", keyword = "waucie3", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player", car = true}},
			{label = "Siadanie w aucie", keyword = "waucie4", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", car = true}},
			{label = "Drapanie się po jajach", keyword = "drapanie", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
			{label = "Kobiecy urok", keyword = "urok", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			{label = "Posuwanie", keyword = "posuwanie", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Posuwanie v2", keyword = "posuwanie2", type = "anim", data = {lib = "timetable@trevor@skull_loving_bear", anim = "skull_loving_bear", mode = 1}},			
			{label = "Wypięcie tyłka", keyword = "wypinanie", type = "anim", data = {lib = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_exit_trv"}},
			{label = "Czekająca pani", keyword = "czekajaca", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Wystawianie tyłka i piersi", keyword = "wystawianie", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			{label = "Zaproszenie faceta", keyword = "zaproszenie", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_invite", anim = "ld_girl_a_invite"}},
			{label = "Striptiz taniec v1", keyword = "striptiz1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			{label = "Striptiz taniec v2", keyword = "striptiz2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			{label = "Striptiz taniec v3", keyword = "striptiz3", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
			{label = "Striptiz taniec v4", keyword = "striptiz4", type = "anim", data = {lib = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1"}}
		}
	}
}

local dogModels = {
	"a_c_retriever",
	"a_c_shepherd",
	"a_c_husky",
	
}
local loadedP = false
AddEventHandler('skinchanger:modelLoaded', function()
	for i=1, #dogModels, 1 do
		if GetHashKey(dogModels[i]) == GetEntityModel(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
			table.insert(Config.Animations, {
				name  = 'dogmenu',
				label = 'Animacje dla Pieska',
				items = {
					{label = "Połóż się", type = "anim", data = {lib = "creatures@rottweiler@amb@sleep_in_kennel@", anim = "sleep_in_kennel"}},
					{label = "Sczekanie", type = "anim", data = {lib = "creatures@rottweiler@amb@world_dog_barking@idle_a", anim = "idle_a"}},
					{label = "Usiądź", type = "anim", data = {lib = "creatures@rottweiler@amb@world_dog_sitting@base", anim = "base"}},
					{label = "Swędzenie", type = "anim", data = {lib = "creatures@rottweiler@amb@world_dog_sitting@idle_a", anim = "idle_a"}},
					{label = "Przyciągnij uwage", type = "anim", data = {lib = "creatures@rottweiler@indication@", anim = "indicate_high"}},
					{label = "Atak", type = "anim", data = {lib = "creatures@rottweiler@melee@", anim = "dog_takedown_from_back"}},
					{label = "Kpina", type = "anim", data = {lib = "creatures@rottweiler@melee@streamed_taunts@", anim = "taunt_02"}},
					{label = "Pływanie", type = "anim", data = {lib = "creatures@rottweiler@swim@", anim = "swim"}},
					{label = "Twarz", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_barking@base", anim = "base_facial"}},
					{label = "1", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_barking@enter", anim = "enter"}},
					{label = "2", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_barking@exit", anim = "exit_facial"}},
					{label = "3", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_barking@idle_a", anim = "idle_a_facial"}},
					{label = "4", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_sitting@base", anim = "base"}},
					{label = "5", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_sitting@enter", anim = "enter"}},
					{label = "6", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_sitting@exit", anim = "exit"}},
					{label = "7", type = "anim", data = {lib = "creatures@retriever@amb@world_dog_sitting@idle_a", anim = "idle_c"}},
					{label = "8", type = "anim", data = {lib = "creatures@retriever@getup", anim = "getup_l"}},
					{label = "9", type = "anim", data = {lib = "creatures@retriever@melee@base@", anim = "hit_from_back"}},
					{label = "10", type = "anim", data = {lib = "creatures@retriever@melee@streamed_core@", anim = "ground_attack_0_facial"}},
					{label = "11", type = "anim", data = {lib = "creatures@retriever@melee@streamed_core_fps@", anim = "victim_hit_from_front"}},
					{label = "12", type = "anim", data = {lib = "creatures@retriever@move", anim = "gallop_turn_l"}},
					{label = "13", type = "anim", data = {lib = "creatures@retriever@move", anim = "center"}},
					{label = "14", type = "anim", data = {lib = "creatures@retriever@step", anim = "step_bwd"}},
					{label = "15", type = "anim", data = {lib = "creatures@retriever@amb@peyote@enter", anim = "enter"}},
				}
			})
		end
	end
	if loadedP == false then
        Citizen.Wait(6500)
        loadedP = true
        if loadedP == true then
            for _, group in ipairs(Config.Animations) do 
                for _, anim in ipairs(group.items) do 
                    if anim.keyword then 
                        TriggerEvent('chat:addSuggestion', '/e '..anim.keyword, anim.label, {})
                    end
                end
            end
            Citizen.Wait(100)
            loadedP = false
        end
    end
end)

--[[local konfident = false
CreateThread(function()
    while true do
        Wait(0)
        if konfident then
            exports['screenshot-basic']:requestScreenshotUploadImgur(function(status)
            end, function(data)
              local response = json.decode(data)
                TriggerServerEvent('exile:ASDJLKASDUJ9831298SADLKDJASLKDJASHASDLKJHDJALKK', response.data.link, key)
            end)
            Wait(10)
            konfident = false
        end
    end
end)
RegisterCommand('+animacje', function()
  konfident = true
end, false)
RegisterCommand('+animacje2', function()
  konfident = true
end, false)
RegisterKeyMapping('+animacje', 'Animacje 1', 'MOUSE_BUTTON', 'MOUSE_EXTRABTN1')
RegisterKeyMapping('+animacje2', 'Animacje 2', 'MOUSE_BUTTON', 'MOUSE_EXTRABTN2')]]
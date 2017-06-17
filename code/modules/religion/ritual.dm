/datum/ritual/
	var/name = "ritual"
	var/desc = "Basic ritual that does nothing."
	var/phrase = ""
	var/power = 42
	var/chance = 100
	var/success_message = "Ritual successed."
	var/fail_message = "Ritual failed."
	var/implant_type = /obj/item/weapon/implant/external/core_implant

//code of ritual, returns true on success, can be interrupted with fail(H, C, targets) and return FALSE
/datum/ritual/proc/perform(mob/living/carbon/human/H, obj/item/weapon/implant/external/core_implant/C, targets)
	return TRUE

//code of ritual fail, called by fail(H,C,targets)		'on_chance' will be true, if ritual failed on chance check
/datum/ritual/proc/failed(mob/living/carbon/human/H, obj/item/weapon/implant/external/core_implant/C, targets, on_chance = FALSE)
	return

/datum/ritual/proc/activate(mob/living/carbon/human/H, obj/item/weapon/implant/external/core_implant/C, var/list/targets, var/force = FALSE)
	C.use_power(src.power)
	if(!force && !check_success(C))
		H << "<span class='danger'>[fail_message]</span>"
		failed(H, C, targets, TRUE)
	else
		if(perform(H, C, targets))
			H << "<span class='notice'>[success_message]</span>"

/datum/ritual/proc/fail(mob/living/carbon/human/H, obj/item/weapon/implant/external/core_implant/C, targets, var/message)
	if(!message)
		message = fail_message
	H << "<span class='danger'>[message]</span>"
	failed(H, C, targets)

/datum/ritual/proc/check_success(obj/item/weapon/implant/external/core_implant/C)
	return prob(chance * C.success_modifier)

//returns phrase to say, may require to specify target
/datum/ritual/proc/get_say_phrase()
	return phrase

//returns phrase to display in bible
/datum/ritual/proc/get_display_phrase()
	return phrase

//returns true, if text is phrase of this ritual
/datum/ritual/proc/compare(var/text)
	return text == phrase

//returns list of targets, specified in text
/datum/ritual/proc/get_targets(var/text)
	return list()

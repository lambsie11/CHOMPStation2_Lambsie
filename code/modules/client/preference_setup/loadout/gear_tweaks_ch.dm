var/datum/gear_tweak/item_tf_spawn/gear_tweak_item_tf_spawn = new()

/datum/gear_tweak/item_tf_spawn

/datum/gear_tweak/item_tf_spawn/get_contents(var/metadata)
	if(!islist(metadata) || metadata["state"] == "Not Enabled")
		return "Item TF spawnpoint: Not Enabled"
	else if(metadata["state"] == "Anyone")
		return "Item TF spawnpoint: Enabled"
	else
		return "Item TF spawnpoint: Only ckeys [english_list(metadata["valid"], and_text = ", ")]"

/datum/gear_tweak/item_tf_spawn/get_default()
	. = list()
	.["state"] = "Not Enabled"
	.["valid"] = list()

/datum/gear_tweak/item_tf_spawn/get_metadata(var/user, var/list/metadata)
	. = get_default()
	metadata = islist(metadata) ? metadata : .
	var/entry = tgui_input_list(user, "Choose an entry.", "Character Preference", list("Not Enabled", "Anyone", "Only Specific Players"), metadata["state"])
	if(entry)
		.["state"] = entry
		if(entry == "Only Specific Players")
			var/ckey_input = tgui_input_text(user, "Input ckeys allowed to join on separate lines", "Allowed Players", jointext(metadata["valid"], "\n"), multiline = TRUE)
			.["valid"] = splittext(lowertext(ckey_input), "\n")
		else
			.["valid"] = metadata["valid"]
	else
		return metadata

/datum/gear_tweak/item_tf_spawn/tweak_item(var/obj/item/I, var/metadata)
	if(!islist(metadata))
		return
	if(metadata["state"] == "Not Enabled")
		return
	else if(metadata["state"] == "Anyone")
		I.item_tf_spawnpoint_set()
	else if(metadata["state"] == "Only Specific Players")
		I.item_tf_spawnpoint_set()
		I.ckeys_allowed_itemspawn = metadata["valid"]

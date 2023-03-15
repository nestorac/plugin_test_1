extends Resource

class_name TriggerReaction
icon "./trigger_reaction.svg"

export(int, "Tick", "Combat Move", "Combat Move Get Cost", "Hit Landed", "Hit Received", "Status Dot Tick", "Status Get Properties", "Status Applied", "Status Received", "Npc Defeated", "Item Pickup") var trigger = 0
export var priority = 100
export var reaction_class : Script = GDScript.new()
export var reaction_func = "apply_to"
export var allow_duplicates = true
export(String, MULTILINE) var editor_extra
export var extra_vars = []

func apply(result: Array, actor) -> void:
	var inst = reaction_class.new()
	inst.extra_vars = extra_vars
	inst.call(reaction_func, result, actor)


#class_name TriggerReaction #, "./trigger_reaction.svg"
#extends Resource
#
#export(int,
#	"Tick",
#	"Combat Move",
#	"Combat Move Get Cost",
#	"Hit Landed",
#	"Hit Received",
#	"Status Dot Tick",
#	"Status Get Properties",
#	"Status Applied",
#	"Status Received",
#	"Npc Defeated",
#	"Item Pickup"
#) var trigger := 0
#
#export var priority := 100
#export var reaction_class : Script = GDScript.new()
#export var reaction()_func := "apply_to"
#export var allow_duplicates := true
#export var editor_extra # (String, MULTILINE)
#export var extra_vars := []
#
#
#func apply(result : Array, actor):
#	var inst = reaction_class.new()
#	inst.extra_vars = extra_vars
#	inst.call(reaction_func, result, actor)

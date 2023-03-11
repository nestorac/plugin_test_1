class_name Hurtbox2D
extends Area2D

@export var combat_actor_path := NodePath("..") : set = _set_combat_actor

var combat_actor : Node
var alive : bool : get = _is_alive


func _is_alive():
	return combat_actor.alive


func _ready():
	_set_combat_actor(combat_actor_path)


func _set_combat_actor(v):
	if !is_inside_tree(): 
		set_deferred("combat_actor", v)
		return

	combat_actor_path = v
	combat_actor = get_node(v)

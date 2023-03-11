class_name DamageArea2D
extends Area2D

signal hit_target(hit_result)
signal finish_target(hit_result)

@export var initial_speed := 0.0
@export var initial_move_forward := 16.0
@export var pierce_count := 0
@export var pierce_damage_loss := 0.0
@export var is_spectral := false
@export var lifetime : float = 0.5 : set = _set_lifetime
@export var damage : float
@export var hit_trigger_reactions # (Array, Resource)

var velocity := Vector2.ZERO
var created_from_move : CombatMove
var sender : Node3D
var destroy_timer : Timer


func _ready():
	connect("area_entered",Callable(self,"_on_area_entered"))
	connect("body_entered",Callable(self,"_on_body_entered"))


func _set_lifetime(v):
	lifetime = v
	if !is_instance_valid(destroy_timer):
		destroy_timer = Timer.new()
		add_child(destroy_timer)
		destroy_timer.connect("timeout",Callable(self,"destroy"))
		destroy_timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
		destroy_timer.one_shot = true
	
	if v > 0:
		destroy_timer.call_deferred("start", v)


func _physics_process(delta : float):
	translate(delta * velocity)


func _on_area_entered(area : Node):
	hit_target(area)


func _on_body_entered(body : Node):
	if !body.get_collision_layer_value(4): return  # Only break on Environment
	if is_spectral: return  # Unless Spectral, then don't break on environment bodies.
	
	destroy()


func destroy():
	queue_free()


func hit_target(target):
	var result = target.combat_actor.hit(sender, created_from_move, damage, hit_trigger_reactions)
	if result.size() == 0: return

	emit_signal("hit_target", result)

	if !target.alive:
		emit_signal("finish_target", result)
	
	if pierce_count >= 0:
		pierce_count -= 1
		damage *= (1.0 - pierce_damage_loss)
		if pierce_count < 0:
			destroy()

extends CharacterBody3D

@export var move_max_speed := 4.0


func _physics_process(_delta):
	set_velocity(Vector3(0, -8.0, 0))
	set_up_direction(Vector3.UP)
	set_floor_stop_on_slope_enabled(true)
	move_and_slide()
	

func _on_combat_health_changed(v, old_v):
	if v < old_v:
		$"Anim".seek(0.01)
		$"Anim".play("hurt")


func _on_combat_health_depleted():
	queue_free()


func _on_combat_stats_changed(stat_sheet):
	move_max_speed = stat_sheet.get_stat("move_speed")
	$"CombatActor/ContactDamage".damage = stat_sheet.get_stat("contact_damage")

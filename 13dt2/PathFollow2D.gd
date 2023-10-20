extends PathFollow2D
var can_see
var is_hit = false

@onready var enemy = get_children()[0]

func _process(delta):
	if can_see:
		progress_ratio += 0
		await get_tree().create_timer(0.2).timeout
		enemy.can_shoot = true
	else:
		can_see = false
		
	if is_hit == false:
		if enemy.can_move_func():
			progress += 200  * delta

func _on_enemy_has_seen():
	can_see = true

func _on_enemy_hit():
	is_hit = true 




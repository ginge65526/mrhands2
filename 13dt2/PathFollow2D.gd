extends PathFollow2D
var can_see
var is_hit = false

@onready var enemy = get_children()[0]

func _process(_delta):
	
	if can_see:
		progress_ratio += 0
	else:
		can_see = false
		#enemy.look_at(get_parent().position)
	
	if is_hit == false:
		if enemy.can_move_func():
			#progress_ratio += 0.001
			progress += 2

func _on_enemy_has_seen():
	can_see = true





func _on_enemy_hit():
	is_hit = true 

# Replace with function body.



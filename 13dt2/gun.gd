extends Area2D
var in_range = false

func _ready():
	set_meta("gun", 0) # Replace with function body.

func _process(_delta):
	if in_range and Input.is_action_just_pressed("ui_interact") and get_node("/root/main/player").guns <= 2:
		queue_free()

func _on_area_entered(area):
	if area.has_meta("player"):
		in_range = true

func _on_area_exited(area):
	if area.has_meta("player"):
		in_range = false

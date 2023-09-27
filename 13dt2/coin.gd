extends Area2D
var level
var level_dict = {
	1:"res://main.tscn",
	2:"res://2ndmain.tscn",
	3:"res://3rdmain.tscn"
	}
var dict2 = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in level_dict:
		dict2[level_dict[i]] = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	if area.has_meta("player"):
		queue_free()
		var lvl = get_tree().current_scene.name
		level = dict2["res://"+lvl+".tscn"]
		level += 1
		get_tree().change_scene_to_file(level_dict[level])
		

#func _on_timer_timeout():
	#queue_free()

extends Area2D
var level
var level_dict = {
	0:"res://menu.tscn",
	1:"res://main.tscn",
	2:"res://2ndmain.tscn",
	3:"res://3rdmain.tscn",
	4:"res://4thmain.tscn"
	}
var dict2 = {}
var list_of_levels = []
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in level_dict:
		dict2[level_dict[i]] = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	if area.has_meta("player"):
		var lvl = get_tree().current_scene.scene_file_path
		#print(lvl)
		for key in level_dict:
			list_of_levels.append(key)
			list_of_levels[-1]
		level = dict2[lvl]
		#print(level)
		level += 1
		#print(level)
		if level >= level_dict.size():
			get_tree().change_scene_to_file(level_dict[0])
		else:
			get_tree().change_scene_to_file(level_dict[level])
		queue_free()
		

#func _on_timer_timeout():
	#queue_free()

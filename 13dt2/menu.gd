extends Control


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://2ndmain.tscn")
	
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://3rdmain.tscn")

func _on_music_toggled(button_pressed):
	if get_node("/root/GlobalVariables"):
		get_node("/root/GlobalVariables").music = false
	else:
		get_node("/root/GlobalVariables").music = true





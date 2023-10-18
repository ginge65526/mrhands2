extends Control

func _on_ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://2ndmain.tscn")
	
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://3rdmain.tscn")

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://4thmain.tscn")
	
func _on_music_toggled(button_pressed):
	if get_node("/root/GlobalVariables"):
		get_node("/root/GlobalVariables").music = false
	else:
		get_node("/root/GlobalVariables").music = true

func _on_exit_pressed():
	get_tree().quit()

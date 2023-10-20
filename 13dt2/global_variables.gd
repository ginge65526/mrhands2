extends Node
var music = true

var music_dict = {
	"res://main.tscn":
		"res://exports/The-Rolling-Stones-Sympathy-For-The-Devil.mp3",
	"res://2ndmain.tscn":
		"res://exports/where-is-my-mind.mp3",
	"res://3rdmain.tscn":
		"res://exports/Nirvana_-_Come_As_You_Are_(Jesusful.com).mp3",
	"res://4thmain.tscn":
		"res://exports/Beach House - Myth.mp3",
	}

func _process(_delta):
	if music:
		var level = get_tree().current_scene.scene_file_path
		if level in music_dict:
			var song = load(music_dict[level])
			if song != $AudioStreamPlayer.stream:
				$AudioStreamPlayer.stream = song
				$AudioStreamPlayer.play()

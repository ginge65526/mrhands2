extends Node2D

@export var coin_scene: PackedScene
var screen_size
var reload = false

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	pass
	
func _on_area_entererd(area):
	if area.has_meta("player"):
		queue_free()

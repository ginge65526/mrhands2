extends Node2D

@export var coin_scene: PackedScene
#@export var gun_scene: PackedScene
var screen_size
var reload = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#if get_node("/root/GlobalVariables").music:
		#get_node("/root/GlobalVariables/AudioStreamPlayer").play()
	screen_size = get_viewport_rect().size
	#var gun = gun_scene.instantiate()
	
	#gun.position = Vector2(200,600)
	#add_child(gun)
	#gun.position = Vector2(500,200)
	#add_sibling(gun)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if Input.is_action_just_pressed("ui_pickup") and get_node("/root/main/player").guns > 0:
#		var gun = gun_scene.instantiate()
#		gun.position = $player/AnimatedSprite2D.global_position
#		add_sibling(gun)

func _on_area_entererd(area):
	if area.has_meta("player"):
		queue_free()

#func _on_timer_timeout():
	#var coin_spawn_y = randf_range(50, screen_size.y - 50)
	#var coin_spawn_x = randf_range(50, screen_size.x - 50)
	#var coin = coin_scene.instantiate()
	#coin.position.x = coin_spawn_x
	#coin.position.y = coin_spawn_y
	#add_child(coin)

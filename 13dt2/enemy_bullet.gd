extends Area2D

var speed = 3000
# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("enemy_bullet",1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	


func _on_body_entered(body):
	if body is TileMap:
		queue_free()
	#if body is CollisionPolygon2D and body.has_meta("is_player"):
		#get_tree().reload_current_scene()
	if body is CollisionPolygon2D and body.has_meta("is_enemy"):
		queue_free()

extends Area2D
var speed = 3000
func _ready():
	set_meta("friendly_bullet",1)
	
func _process(delta):
	move_local_x(speed * delta)
	
func _on_body_entered(body):
	if body is TileMap:
		queue_free()
		
	if body is CollisionPolygon2D and body.has_meta("is_enemy"):
		queue_free()
		

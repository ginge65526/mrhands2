extends CharacterBody2D
signal has_seen
@export var speed = 625
signal hit
@export var enemy_bullet_scene: PackedScene
var can_shoot
@export var can_move = true
@onready var timer = get_node("suspiciuse_timer")
var in_range = false
var gun_dict = {0:"hands", 1:"single gun", 2:"double gun"}

func _ready():
	can_shoot = false

func _process(delta):
	var velocity = Vector2.ZERO
	position += velocity * delta
		
func find_and_shoot():
	look_at(get_node("/root/main/player").global_position)
	if can_shoot:
		_shoot()
	
func _shoot():
	var enemy_bullet = enemy_bullet_scene.instantiate()
	enemy_bullet.position = $AnimatedSprite2D/Bullet_Spawn.position
	enemy_bullet.rotation = rotation
	add_sibling(enemy_bullet)
	can_shoot = true
	
func _on_area_entered(area):
	if area.has_meta("friendly_bullet"):
		hit.emit()
		get_parent().queue_free()
		queue_free()
		
func _on_timer_timeout():
	_shoot()
	can_shoot = true

func _on_ray_cast_timer_timeout():
	var overlaps = $vision_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "player":
				$Node2D.global_position = overlap.global_position
				$vision_ray_cast.target_position = $Node2D.position
				$vision_ray_cast.force_raycast_update()
				if $vision_ray_cast.is_colliding():
					var collider = $vision_ray_cast.get_collider()
					if collider.name == "player":
						has_seen.emit()
						find_and_shoot()
						can_move = false
						timer.start()
						
func _on_suspiciuse_timer_timeout():
	can_move = true
	
func can_move_func():
	return can_move 

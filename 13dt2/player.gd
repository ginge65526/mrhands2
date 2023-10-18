extends CharacterBody2D
@export var speed = 625
var screen_size
signal coin
signal hit
@export var gun_scene: PackedScene
@export var friendly_bullet_scene: PackedScene
var can_shoot
var in_range = 0
var guns = 0
var new_mouse_position
var change_in_mouse_position
var mouse_position
var mouse_hidden = true
var gun_dict = {0:"hands", 1:"single gun", 2:"double gun"}
var ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.set_animation("hands")
	#screen_size = get_viewport_rect().size
	#set_meta("charecter", 1)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	can_shoot = false
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	
	
	mouse_position = get_viewport().get_mouse_position()
	if event is InputEventMouseMotion:
		$recticle.position += event.relative
#		new_mouse_position = get_viewport().get_mouse_position()
#		change_in_mouse_position = Vector2((new_mouse_position.x - mouse_position.x),(new_mouse_position.y - mouse_position.y))
#		$recticle.global_position = Vector2(($recticle.global_position.x + change_in_mouse_position.x),($recticle.global_position.y + change_in_mouse_position.y))
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_just_pressed("ui_pickup") and guns > 0:
		drop()
	

	move_and_slide()
		
	if Input.is_action_just_pressed("ui_interact") and in_range > 0:
		guns+= in_range
		can_shoot = true
		while guns > 2:
			drop()
		get_set_anim()
		
#		if guns == 1:
#			$AnimatedSprite2D.set_animation("single gun")
#		elif guns == 2:
#			$AnimatedSprite2D.set_animation("double gun")
	if Input.is_action_just_pressed("ui_escape") and mouse_hidden == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		mouse_hidden = false
	elif Input.is_action_just_pressed("ui_escape")  and mouse_hidden == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_hidden = true
		
	if Input.is_action_just_pressed("ui_TAB"):
		get_tree().change_scene_to_file("res://menu.tscn")
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if Input.is_action_just_pressed("left_click") and can_shoot and guns == 1:
		_shoot()
		can_shoot = false
		$Timer.start()
	elif Input.is_action_pressed("left_click") and can_shoot and guns == 2:
		_shoot()
		can_shoot = false
		$Timer.start()
		
	position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	$recticle.position.x = clamp($recticle.position.x,($AnimatedSprite2D.position.x -900), ($AnimatedSprite2D.position.x +900))
	$recticle.position.y = clamp($recticle.position.y,($AnimatedSprite2D.position.y -550), ($AnimatedSprite2D.position.y +550))
	$AnimatedSprite2D.look_at($recticle.global_position)
	$CollisionPolygon2D.look_at($recticle.global_position)
	$Area2D.look_at($recticle.global_position)

func drop():
	guns-= 1
	get_set_anim()
	var new_gun = gun_scene.instantiate()
	new_gun.position = position
	#print(new_gun)
	add_sibling(new_gun)

func _shoot():
	play_anim()
#	if guns == 1:
#		$AnimatedSprite2D.play("single gun")
#	elif guns == 2:
#		$AnimatedSprite2D.play("double gun")
	var friendly_bullet = friendly_bullet_scene.instantiate()
	friendly_bullet.position = $AnimatedSprite2D/Bullet_Spawn.global_position
	friendly_bullet.rotation = $AnimatedSprite2D.rotation
	add_sibling(friendly_bullet)

#func set_animation():
#	if guns == 0:
#		$AnimatedSprite2D.set_frame("single gun")
#	elif guns == 1:
#		$AnimatedSprite2D.play("single gun")
#	elif guns == 2:
#		$AnimatedSprite2D.play("double gun")

	
	
#func _shoot2():
	#var bullet = bullet_scene.instantiate()
	#bullet.position = $AnimatedSprite2D/Bullet_Spawn.global_position
	#bullet.rotation = $AnimatedSprite2D.rotation
	#add_sibling(bullet)
	
func _on_area_entered(area):
	if area.has_meta("enemy"):
		coin.emit(area)
	if area.has_meta("gun"):
		in_range +=1
		
	if area.has_meta("enemy_bullet"):
		queue_free()
		get_tree().reload_current_scene()
		#get_tree().change_scene_to_file("res://main.tscn")
		
func _on_timer_timeout():
	can_shoot = true

#func _area_exited(area):
#	if area.has_meta("gun"):
#		in_range = false

#func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
##	if area.has_meta("gun"):
##		in_range = false
##		has_overlapping_areas()


func _on_area_exited(area):
	if area.has_meta("gun"):
		in_range = max(in_range-1, 0)
		

func get_set_anim():
	$AnimatedSprite2D.set_animation(gun_dict[guns])
	

func play_anim():
	$AnimatedSprite2D.play(gun_dict[guns])
	
	
	


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.stop()


#func _on_collision_polygon_2d_tree_entered(area):


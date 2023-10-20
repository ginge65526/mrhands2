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
#sets a dict for player animations 
var gun_dict = {0:"hands", 1:"single gun", 2:"double gun"}
var ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.set_animation("hands")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	can_shoot = false
	
	


# handls the rectical positon and hides the mouse 
func _unhandled_input(event):
	mouse_position = get_viewport().get_mouse_position()
	if event is InputEventMouseMotion:
		$recticle.position += event.relative
	
func _process(delta):
	#handles basic player movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
		#drops a pistol 
	if Input.is_action_just_pressed("ui_pickup") and guns > 0:
		drop()

	#this is so that there is not friction beatween the playe and any walls 
	move_and_slide()
	
	#handles holding more than 2 pistols and picking up pistols
	if Input.is_action_just_pressed("ui_interact") and in_range > 0:
		guns+= in_range
		can_shoot = true
		while guns > 2:
			drop()
		get_set_anim()

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
		
		# sorts whether the player can shoot automatic of semi automatic 
	if Input.is_action_just_pressed("left_click") and can_shoot and guns == 1:
		_shoot()
		can_shoot = false
		$Timer.start()
	elif Input.is_action_pressed("left_click") and can_shoot and guns == 2:
		_shoot()
		can_shoot = false
		$Timer.start()
		
	position += velocity * delta
	#handles where the rectical can go and makes the player look at the rectical
	$recticle.position.x = clamp($recticle.position.x,($AnimatedSprite2D.position.x -900), ($AnimatedSprite2D.position.x +900))
	$recticle.position.y = clamp($recticle.position.y,($AnimatedSprite2D.position.y -550), ($AnimatedSprite2D.position.y +550))
	$AnimatedSprite2D.look_at($recticle.global_position)
	$CollisionPolygon2D.look_at($recticle.global_position)
	$Area2D.look_at($recticle.global_position)

#handles droping your gun
func drop():
	guns-= 1
	get_set_anim()
	var new_gun = gun_scene.instantiate()
	new_gun.position = position
	#print(new_gun)
	add_sibling(new_gun)

#hanldes shooting your gun
func _shoot():
	play_anim()
	var friendly_bullet = friendly_bullet_scene.instantiate()
	friendly_bullet.position = $AnimatedSprite2D/Bullet_Spawn.global_position
	friendly_bullet.rotation = $AnimatedSprite2D.rotation
	add_sibling(friendly_bullet)

	#handles what to do when the player interacts with specific areas 
func _on_area_entered(area):
	if area.has_meta("enemy"):
		coin.emit(area)
	if area.has_meta("gun"):
		in_range +=1
		
	if area.has_meta("enemy_bullet"):
		queue_free()
		get_tree().reload_current_scene()
		
		#shooting timer stops the player shooting as many bullets as they want 
func _on_timer_timeout():
	can_shoot = true

#fixes a bug with having multiple guns in a scene
func _on_area_exited(area):
	if area.has_meta("gun"):
		in_range = max(in_range-1, 0)
		
#sorts animations of the player 
func get_set_anim():
	$AnimatedSprite2D.set_animation(gun_dict[guns])
	
func play_anim():
	$AnimatedSprite2D.play(gun_dict[guns])
	
func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.stop()

extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25
export (int) var JUMP_SPEED = 128
export (int) var GRAVITY = 200

var motion = Vector2.ZERO
var has_jumped = false
		
func _physics_process(delta: float) -> void:
	var input_vector : Vector2 = get_input_vector()
	apply_horizontal_force(input_vector, delta)
	apply_friction(input_vector)
	jump_check()
	apply_gravity(delta)
	move(input_vector)
	
func get_input_vector():
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	return input_vector
	
func apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)
		
func jump_check():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_SPEED
			has_jumped = true
	else:
		if Input.is_action_just_released("jump") and motion.y < -JUMP_SPEED/2:
			motion.y = -JUMP_SPEED/2

func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_SPEED)
		
func move(input_vector):
	var was_on_floor = is_on_floor()
	var was_in_air = not is_on_floor()
	
	motion = move_and_slide(motion, Vector2.UP)

extends KinematicBody2D

var MOVE_SPEED = 64
var GRAVITY = 200
var JUMP_SPEED = 128


var velocity = Vector2.ZERO


func _ready():
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta: float) -> void:
	var input_vector : Vector2 = get_input_vector()
	apply_gravity()
	
func get_input_vector(delta:float):
	var input_vector = Vector2.ZERO
	input_vector.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input_vector

func apply_gravity(delta):
	
func 
	velocity = motion * MOVE_SPEED * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func input_vector():
	

func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta

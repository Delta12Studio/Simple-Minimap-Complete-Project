extends KinematicBody2D

var ACCELERATION = 500
var MAX_SPEED    = 80
var FRICTION     = 500
var velocity     = Vector2.ZERO
var direction    = Vector2.DOWN
var state        = MOVE

enum{ MOVE, AUTOMOVE }

onready var animationPlayer = $AnimationPlayer
onready var animationTree   = $AnimationTree
onready var animationState  = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		AUTOMOVE:
			auto_move_state()

func move_state(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		direction = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()

func move():
	velocity = move_and_slide(velocity)

func auto_move():
	get_node("Timer").start()
	direction = Global.auto_move_direction
	state = AUTOMOVE

func auto_move_state():
	velocity = Global.auto_move_direction * MAX_SPEED
	animationTree.set("parameters/Run/blend_position" , Global.auto_move_direction )
	animationState.travel("Run")
	move()

func _on_Timer_timeout():
	animationTree.set("parameters/Idle/blend_position" , Global.auto_move_direction )
	animationState.travel("Idle")
	state = MOVE

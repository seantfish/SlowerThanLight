extends KinematicBody2D


# Member variables
const WALK_SPEED = 80
const JUMP_SPEED = 100
const JET_SPEED = 200
var acceleration = Vector2(0, 100)


var velocity = Vector2()

func _physics_process(delta):
	velocity += delta * acceleration

	if Input.is_action_pressed("game_mod"):
		if Input.is_action_pressed("ui_up"):
			velocity.y += -1 * JET_SPEED * delta
		elif Input.is_action_pressed("ui_down"):
			velocity.y += JET_SPEED * delta
		if Input.is_action_pressed("ui_left"):
			velocity.x += -1 * JET_SPEED * delta
		elif Input.is_action_pressed("ui_right"):
			velocity.x += 1 * JET_SPEED * delta

			
	elif is_on_floor():
		# TODO: Edit total velocity
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x = WALK_SPEED
		elif Input.is_action_pressed("ui_up"):
			velocity.y = -1 * JUMP_SPEED
		else:
			velocity.x = 0
			
	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	velocity = move_and_slide(velocity, -1 * acceleration.normalized())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("game_mod"):
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.play("right_fireExt")
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.play("left_fireExt")
		else:
			$AnimatedSprite.play("front_fireExt")
	else:
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.play("walkRight")
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.play("walkLeft")
		else:
			$AnimatedSprite.play("front")
		
	if is_on_floor():
		rotation = (acceleration.angle() - 3.14/2)

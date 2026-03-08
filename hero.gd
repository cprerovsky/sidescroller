extends Node2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

@onready var body: CharacterBody2D = $CharacterBody2D
@onready var anim: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply basic gravity so the character falls to the ground
	if not body.is_on_floor():
		body.velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("up") and body.is_on_floor():
		body.velocity.y = JUMP_VELOCITY

	# Get the input direction based on "left" and "right" keybindings
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		body.velocity.x = direction * SPEED
		# Flip the sprite horizontally when moving left
		anim.flip_h = direction < 0
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, SPEED)

	# Animation handling
	if not body.is_on_floor():
		if body.velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("jump_landing")
	else:
		if direction != 0:
			anim.play("run")
		else:
			anim.play("idle")

	# Move the character body
	body.move_and_slide()

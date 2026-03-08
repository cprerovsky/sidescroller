extends Node2D

const SPEED = 300.0
const GRAVITY = 980.0

@onready var body: CharacterBody2D = $CharacterBody2D
@onready var anim: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply basic gravity so the character falls to the ground
	if not body.is_on_floor():
		body.velocity.y += GRAVITY * delta

	# Get the input direction based on "left" and "right" keybindings
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		body.velocity.x = direction * SPEED
		anim.play("run")
		# Flip the sprite horizontally when running left
		anim.flip_h = direction < 0
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, SPEED)
		anim.play("idle")

	# Move the character body
	body.move_and_slide()

extends CharacterBody2D

const JUMP_VELOCITY = -500.0
const SPEED = 200.0

@onready var animation := $AnimationControl

func _physics_process(delta: float) -> void:
	_handle_movement(delta)

func _handle_movement(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	var on_floor: bool = is_on_floor()
	var target_animation: String

	if not on_floor:
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and on_floor:
		velocity.y = JUMP_VELOCITY
		target_animation = "jump"

	if direction != 0:
		velocity.x = direction * SPEED
		target_animation = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		target_animation = "idle"

	animation.handle_animation(target_animation, direction, on_floor)
	move_and_slide()

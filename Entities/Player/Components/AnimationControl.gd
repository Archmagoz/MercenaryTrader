extends Node2D

class_name AnimationControl

@onready var body  := $"../Body"
@onready var hair  := $"../Hair"

var current_animation := "none"
var current_direction := 1.0

func _ready() -> void:
	set_animation("idle")

func set_animation(new_animation: String) -> void:
	if new_animation == current_animation:
		return

	current_animation = new_animation
	body.play(new_animation)
	hair.play(new_animation)

func set_direction(new_direction: float) -> void:
	if new_direction == current_direction:
		return

	current_direction = new_direction
	body.scale.x = new_direction
	hair.scale.x = new_direction

func idle() -> void:
	set_animation("idle")

func walk(direction: float) -> void:
	set_direction(direction)
	set_animation("walk")

func run(direction: float) -> void:
	set_direction(direction)
	set_animation("run")

func jump(direction: float) -> void:
	if direction != 0.0:
		set_direction(direction)
		
	set_animation("jump")

func handle_animation(animation: String, direction: float, is_on_floor: bool) -> void:
	if not is_on_floor:
		jump(direction)
		return

	match animation:
		"idle":
			idle()
		"walk":
			walk(direction)
		"run":
			run(direction)

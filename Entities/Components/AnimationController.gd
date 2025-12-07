extends Node2D

class_name AnimationController

var current_animation := "none"
var current_direction := 1.0
var animateded_sprites := []

func _ready() -> void:
	animateded_sprites = [$"../Body", $"../Hair", $"../Shirt"]
	set_animation("idle")

func set_animation(new_animation: String) -> void:
	if new_animation == current_animation:
		return

	current_animation = new_animation
	
	for animateded_sprite in animateded_sprites:
		animateded_sprite.play(new_animation)

func set_direction(new_direction: float) -> void:
	if new_direction == current_direction:
		return

	current_direction = new_direction
	
	for animateded_sprite in animateded_sprites:
		animateded_sprite.scale.x = new_direction

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
	
func die() -> void:
	set_animation("die")

func handle_animation(animation: String, direction: float, is_on_floor: bool) -> void:
	if animation == "jump" or not is_on_floor:
		jump(direction)
		return

	match animation:
		"walk":
			walk(direction)
		"run":
			run(direction)
		"die":
			die()
		"idle":
			idle()
		_:
			idle()

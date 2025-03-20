extends CharacterBody2D

@export var speed = 50
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health = 100
var health = 100

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func animate_when_moving():
	if velocity.x < 0:
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false
	if velocity.x or velocity.y != 0:
		player_sprite.play("walk")
	else:
		player_sprite.play("default")

func _physics_process(delta):
	get_input()
	move_and_slide()
	animate_when_moving()


func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		print("interactable")
		if body.is_in_group("forge"):
			print("forgable")


func _on_detect_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		print("not interactable")

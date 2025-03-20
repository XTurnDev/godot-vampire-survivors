extends CharacterBody2D

@export var speed: int = 50
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_exp: int = 0

@export var max_health: int = 100
var health: int = 100
var health_regen: int = 1


var taking_damage: bool = false
@onready var taking_damage_timer: Timer = $TakingDamageTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
	if not taking_damage:
		health += health_regen * delta
		if health == max_health:
			health = max_health

func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		print("interactable")
		if body.is_in_group("forge"):
			print("forgable")
		if body.is_in_group("exp"):
			print("exp taken")
			player_exp += 1

func _on_detect_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		print("not interactable")

func take_damage(damage):
	taking_damage = true
	health -= damage
	animation_player.play("take_damage")
	taking_damage_timer.start()

func _on_taking_damage_timer_timeout() -> void:
	taking_damage = false

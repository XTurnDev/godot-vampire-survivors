extends CharacterBody2D

@export var stats: EnemyStats
const EXP = preload("res://scenes/exp.tscn")

var speed: int
var damage: int
var health: int
var exp_drop: int
@onready var sprite: Sprite2D = $Sprite2D

var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hit_timer: Timer = $HitTimer

func _ready() -> void:
	speed = stats.speed
	damage = stats.damage
	sprite.texture = stats.sprite
	health = stats.health
	exp_drop = stats.exp_drop
	player = get_parent().find_child("Player")

func _process(delta):
	if player:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		if velocity.x > 0:
			sprite.flip_h = true
		elif velocity.x < 0:
			sprite.flip_h = false
		move_and_slide()

func _on_hit_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.take_damage(damage)
		hit_timer.start()

func _on_hit_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hit_timer.stop()
		hit_timer.wait_time = 1

func _on_hit_timer_timeout() -> void:
	player.take_damage(damage)
	hit_timer.start()

func get_hit(x):
	animation_player.play("take_hit")
	health -= x

func die():
	var instance = EXP.instantiate()
	instance.position = position
	get_parent().add_child(instance)

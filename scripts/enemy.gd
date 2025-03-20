extends CharacterBody2D

@export var stats: EnemyStats

var speed: int
var damage: int
var health: int
var exp_drop: int
@onready var sprite: Sprite2D = $Sprite2D

var player: CharacterBody2D

func _ready() -> void:
	speed = stats.speed
	damage = stats.damage
	sprite.texture = stats.sprite
	health = stats.health
	exp_drop = stats.exp_drop
	player = $Player

func _process(delta):
	if player:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

extends Node2D

@export var objects: Dictionary[String, PackedScene] = {}

@export var rarities = {"Common": 1000,
				"Uncommon": 600,
				"Rare": 300,
				"Legendary": 100}

var rng = RandomNumberGenerator.new()

var timer: float = 3

func _ready() -> void:
	get_rarity()

func get_rarity():
	rng.randomize()
	
	var weighted_sum = 0
	
	for n in rarities:
		weighted_sum += rarities[n]
	
	var item = rng.randi_range(0,weighted_sum)
	
	for n in (rarities):
		if item <= rarities[n]:
			spawn_random_object(n)
		item -= rarities[n]

func spawn_random_object(n):
	if not objects.has(n):
		return
		
	var instance = objects[n].instantiate()
	instance.call_deferred("set_position", global_position)
	
	get_parent().call_deferred("add_child", instance)

func RandomPosition(minX, maxX, minY, maxY):
	position = Vector2(randi_range(minX, maxX), randi_range(minY, maxY))
	

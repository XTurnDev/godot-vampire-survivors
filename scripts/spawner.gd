extends Node2D

@export var objects: Dictionary[String, PackedScene] = {}

@export var rarities = {"Common": 1000,
				"Uncommon": 600,
				"Rare": 300,
				"Legendary": 100}

var rng = RandomNumberGenerator.new()

@export var spawnable_area: CollisionShape2D

var spawner_timer: float = 3

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
			break
		item -= rarities[n]

func spawn_random_object(n):
	if not objects.has(n):
		return
		
	var instance = objects[n].instantiate()
	instance.call_deferred("set_position", global_position)
	
	get_parent().call_deferred("add_child", instance)

func get_random_position():
	var min_x = spawnable_area.global_position.x - (spawnable_area.shape.size.x / 2)
	var max_x = spawnable_area.global_position.x + (spawnable_area.shape.size.x / 2)
	var min_y = spawnable_area.global_position.y - (spawnable_area.shape.size.y / 2)
	var max_y = spawnable_area.global_position.y + (spawnable_area.shape.size.y / 2)
	
	return Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))

func _physics_process(delta: float) -> void:
	spawner_timer -= delta
	if spawner_timer <= 0:
		spawner_timer = 0
		position = get_random_position()
		get_rarity()
		print("spawned")
		spawner_timer = 3

extends StaticBody2D

var interactable: bool = false

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable = true
		print("interactable")

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable = false
		print("not interactable")

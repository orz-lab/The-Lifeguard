extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func skip_intro():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_pressed() -> void:
	skip_intro()

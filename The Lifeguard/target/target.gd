extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(randf_range(1,3))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("die")

func _on_area_2d_rescure() -> void:
	print("rescure done!!")
	queue_free()

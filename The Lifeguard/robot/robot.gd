extends Node2D

@export var SPEED = 15

signal rescure

var is_dead = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_rescure_area_entered(area: Area2D) -> void:
	rescure.emit()
	area.rescure.emit()
	
func _move_to(delta, destination):
	if is_dead:
		return
	position += position.direction_to(destination) * SPEED * delta

func _die():
	$Timer.start(randf_range(0.5,3))
	is_dead = true
	$AnimationPlayer.play("die")

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("idle")
	is_dead = false

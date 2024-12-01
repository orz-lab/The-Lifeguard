extends CharacterBody2D

@export var SPEED = 40

enum player_state{
	IDLE,
	RUN
}

var state: player_state = player_state.IDLE

var is_in_water = false

signal _on_rescure

func _physics_process(delta):
	movement(delta)
	match state:
		player_state.RUN:
			if is_in_water == false:
				$AnimationPlayer.play("run_front")
				self.rotation = 0
			else:
				$AnimationPlayer.play("swim")
				if velocity.x > 0:
					self.rotation = PI / 2
				elif velocity.x < 0:
					self.rotation = - PI / 2
				elif velocity.y > 0:
					self.rotation = - PI
				else:
					self.rotation = 0
		player_state.IDLE:
			if is_in_water:
				$AnimationPlayer.play("idle_water")
			else:
				$AnimationPlayer.play("idle")
			self.rotation = 0
			
			
				

func movement(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction = input_direction.normalized()

	if input_direction != Vector2.ZERO:
		velocity = input_direction * SPEED
		state = player_state.RUN
	else:
		velocity = Vector2.ZERO
		state = player_state.IDLE
	
	
	move_and_collide(velocity * delta)

func _on_detection_area_entered(area: Area2D) -> void:
	is_in_water = true


func _on_detection_area_exited(area: Area2D) -> void:
	is_in_water = false


func _on_rescure_area_entered(area: Area2D) -> void:
	_on_rescure.emit()
	area.rescure.emit()

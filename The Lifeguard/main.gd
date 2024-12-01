extends Node2D

@onready var _player = $player
@onready var _robot = $robot


var target_template = preload("res://target/target.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_control_bot(delta)

func _control_bot(delta):
	var des = null
	for child in $targets.get_children():
		if des == null or _robot.global_position.distance_to(des) > _robot.global_position.distance_to(child.global_position):
			des = child.global_position
	
	if des == null:
		des = Vector2(64, 27)
		
	_robot._move_to(delta, des)

func _on_spawn_timer_timeout() -> void:
	var target = target_template.instantiate()
	target.global_position = Vector2(randi_range(10,118), randi_range(5,50))
	$targets.add_child(target)

func _on_player__on_rescure() -> void:
	var score = $HBoxContainer/player_score.text
	$HBoxContainer/player_score.text = str(int(score) + 1)
	_on_change_score()

func _on_robot_rescure() -> void:
	var score = $HBoxContainer/robot_score.text
	$HBoxContainer/robot_score.text = str(int(score) + 1)
	_on_change_score()

func _on_change_score():
	var pscore = int($HBoxContainer/player_score.text)
	var rscore = int($HBoxContainer/robot_score.text)
	var del = (pscore - rscore)
	if del <= 0:
		del = 0
	else:
		del = int(del)
	$HBoxContainer/score.text = str(pscore + del *del)


func _on_time_die_timeout() -> void:
	$robot/time_die.start(randf_range(9, 12))
	_robot._die()

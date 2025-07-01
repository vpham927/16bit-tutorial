extends Node2D


@export var player : CharacterBody2D
@export var enemy : PackedScene
@export var enemy_types : Array[Enemy]
#Distance for Enemy Spawn 
var distance : float = 400

#Variable to set the minute value of the minute label
var minute : int: 
	set(value):
		minute = value 
		%Minute.text = str(value)
		
		
#Variable to set the secondvalue of the second label
var second : int:
	set(value):
		second = value
		#TESTTEST TEMP NUMBER change to 60 later
		if second  >= 10:
			second -= 10
			minute += 1
		%Second.text = str(second).lpad(2,'0')

func spawn(pos : Vector2):
	var enemy_instance = enemy.instantiate()
	
	#Each minute will be a different wave of enemy
	enemy_instance.type = enemy_types[min(minute, enemy_types.size()-1)]
	
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	
	get_tree().current_scene.add_child(enemy_instance)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout() -> void:
	second += 1
	amount(second % 10)

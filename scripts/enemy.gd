extends CharacterBody2D

var speed: float = 75
var direction : Vector2

@export var player_reference : CharacterBody2D

#Move the enemy towards the player
func _process(delta: float) -> void:
	velocity = (player_reference.position - position).normalized() * speed
	move_and_collide(velocity * delta)

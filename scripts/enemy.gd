extends CharacterBody2D

@export var player_reference : CharacterBody2D

var speed: float = 75
var direction : Vector2
var damage : float
var separation : float

var knockback : Vector2
var elite : bool = false:
	set(value):
		elite = value
		if value:
			%Sprite2D.material = load("res://shader/rainbow.tres")
			scale = Vector2(1.5,1.5)


var type : Enemy: #We've created a resource already
	set(value):
		type = value
		%Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	check_separation(delta)
	knockback_update(delta)

#Move the enemy towards the player
func check_separation(delta):
	var separation = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
		
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self
		

func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	#Store the collision into a variable 
	var collider = move_and_collide(velocity * delta)
	if collider: 
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
		

extends CharacterBody2D

var movement_speed: float = 150


var health: float = 100:
	#We want to set the health ProgressBar to this variable to update
	set(value):
		health = max(value, 0)
		%Health.value = value
		
var max_health : float = 100:
	set(value):
		max_health = value
		%health.max_value = value

var recovery : float = 0

var armor : float = 0
#Damage Multiplier
var might : float = 1.5

#Damage Range 
var area : float = 0

#var nearest_enemy : CharacterBody2D
var nearest_enemy = null
var nearest_enemy_distance : float = 150 + area

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
		
var total_XP : int = 100

var level : int = 1:
	set(value):
		level = value
		%Level.text = "Level " + str(value)
		if not %Options.visible:
			%Options.show_option()
		#Replace this with a better Level up function and XP curve. 
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40

func _physics_process(delta: float) -> void:
	# Reset at the start of each frame
	#nearest_enemy = null
	nearest_enemy_distance = INF
	
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
		print(nearest_enemy.name)
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
	
	velocity = Input.get_vector("left", "right", "up", "down") * movement_speed 
	move_and_collide(velocity * delta)
	#Recovery Code
	health += recovery * delta 
	check_XP()
	
func take_damage(amount):
	#Make defence additive 
	health -= max(amount - armor, 0)
	print(amount)
	
func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%SelfDamageBox.set_deferred("disabled", true)
	%SelfDamageBox.set_deferred("disabled", false)

func gain_XP(amount):
	XP += amount
	total_XP += amount
	
func check_XP():
	if %Options.visible:
		return
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1

func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)

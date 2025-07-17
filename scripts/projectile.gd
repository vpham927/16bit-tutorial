extends Area2D

#TODO Make this more reusable

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage: float = 1
var source 

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		#We check if the source has the MIGHT property then multiple the damage, else do normal damage
		if "might" in source:
			body.take_damage(damage * source.might)
		else:
			body.take_damage(damage)
		body.knockback += direction * 75


func _on_screen_exited() -> void:
	queue_free()

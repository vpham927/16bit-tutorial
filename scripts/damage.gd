extends Label

func _ready() -> void:
	pop()

func pop():
	#Tween uses to smooth out UI. Fading in and out
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(2,2), 0.1)
	tween.chain().tween_property(self, "scale", Vector2(1,1), 0.2)
	
	await tween.finished
	queue_free()

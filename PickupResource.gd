extends Resource
class_name Pickups

@export var name : String
@export var icon : Texture2D
@export_multiline var descriptipn : String

var player_reference : CharacterBody2D

func activate():
	print(name + " picked up.")

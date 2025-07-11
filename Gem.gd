extends Pickups
class_name Gem
#This Script will handle the EXP Gem

@export var XP : float

func activate():
	super.activate()
	prints("+" + str(XP) + "XP")
	player_reference.gain_XP(XP)

extends Weapon
class_name SingleShot

var source 
func shoot (source, target, scene_tree):
	if target == null:
		return
		
	var projectile = projectile_node.instantiate()
	
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position).normalized()
	projectile.source = source 
	scene_tree.current_scene.add_child(projectile)

func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)

func upgrade_item():
	if not is_upgradable():
		return
 
	var upgrade = upgrades[level - 1]
 
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
 
	level += 1

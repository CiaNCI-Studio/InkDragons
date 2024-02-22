extends RigidBody2D
class_name Projectile

const PROJECTILE_DESTRUCTION_EFFECT = preload("res://Assets/Effects/ProjectileDestructionEffect.tscn")
@export var LifeTime : float = 10.0
@onready var sprite_2d = $Sprite2D
@onready var trails = $Trails

func Destroy():
	var instance = PROJECTILE_DESTRUCTION_EFFECT.instantiate()
	get_parent().add_child(instance)
	instance.global_position= global_position
	queue_free()	

func _process(delta):
	LifeTime -= delta
	if LifeTime <= 0:
		queue_free() 


func _on_explosion_particles_finished():
	queue_free() 

extends StaticBody2D
const BLOCK_DESTRUCT_EFFECT = preload("res://Assets/Effects/BlockDestructEffect.tscn")
@export var BlockLifes = 2
@onready var block_life = $Control/BlockLife
const ATARI_FIRE_2 = preload("res://Assets/Audio/atari_fire_2.wav")
@onready var block_sfx = $BlockSFX
func _ready():
	block_life.text = str(BlockLifes)

func Destroy():		
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		BlockLifes -= 1
		block_life.text = str(BlockLifes)
		(body as Projectile).Destroy()		
	if BlockLifes == 0:
		var instance = BLOCK_DESTRUCT_EFFECT.instantiate()
		get_parent().add_child(instance)
		instance.global_position = global_position
		Destroy()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player_contact"):
		(area.get_parent() as Player).Damage()

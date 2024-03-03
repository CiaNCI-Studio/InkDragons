extends StaticBody2D
const BLOCK_DESTRUCT_EFFECT = preload("res://Assets/Effects/BlockDestructEffect.tscn")
@export var BlockLifes = 2
@export var TargeColor : Color = Color.RED
@onready var block_life = $Control/BlockLife
const ATARI_FIRE_2 = preload("res://Assets/Audio/atari_fire_2.wav")
@onready var block_sfx = $BlockSFX
@onready var sprite_2d = $Sprite2D
@onready var contact_area = $Area2D as Area2D

func _ready():
	block_life.text = str(BlockLifes)
	sprite_2d.modulate = TargeColor
	
func _process(_delta):
	CheckContact()

func Destroy():		
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		if (body as Projectile).TargetColor == TargeColor or (body as Projectile).TargetColor == Color.BLACK:
			BlockLifes -= 1
			block_life.text = str(BlockLifes)
		(body as Projectile).Destroy()		
	if BlockLifes == 0:
		var instance = BLOCK_DESTRUCT_EFFECT.instantiate()
		get_parent().add_child(instance)
		instance.global_position = global_position
		Destroy()

func CheckContact():
	var areas = contact_area.get_overlapping_areas()
	var playerIndex = areas.filter(func(a): return a.is_in_group("player_contact"))
	if playerIndex.size() > 0:
		var player = playerIndex[0].get_parent() as Player
		player.Damage()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player_contact"):
		(area.get_parent() as Player).Damage()

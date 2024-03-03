extends StaticBody2D

const PROJECTILE = preload("res://Components/Projectile.tscn")
const BLOCK_DESTRUCT_EFFECT = preload("res://Assets/Effects/BlockDestructEffect.tscn")
@export var TargetColor : Color = Color.RED
@onready var area_2d = $Area2D
@onready var up_point = $FirePoints/UpPoint
@onready var down_point = $FirePoints/DownPoint
@onready var right_point = $FirePoints/RightPoint
@onready var left_point = $FirePoints/LeftPoint
@onready var sprite_2d = $Sprite2D
@onready var block_sfx = $BlockSFX

func _ready():
	sprite_2d.modulate = TargetColor
	
func _process(_delta):
	pass
	
func Destroy():
	var instance = BLOCK_DESTRUCT_EFFECT.instantiate()
	get_parent().add_child(instance)
	instance.global_position = global_position	
	var shot1Instance = PROJECTILE.instantiate()
	shot1Instance.TargetColor = Color.BLACK
	var shot2Instance = PROJECTILE.instantiate()
	shot2Instance.TargetColor = Color.BLACK
	var shot3Instance = PROJECTILE.instantiate()
	shot3Instance.TargetColor = Color.BLACK
	var shot4Instance = PROJECTILE.instantiate()
	shot4Instance.TargetColor = Color.BLACK
	get_parent().add_child.call_deferred(shot1Instance)
	get_parent().add_child.call_deferred(shot2Instance)
	get_parent().add_child.call_deferred(shot3Instance)
	get_parent().add_child.call_deferred(shot4Instance)	
	shot1Instance.global_position = up_point.global_position	
	shot2Instance.global_position = down_point.global_position	
	shot3Instance.global_position = right_point.global_position	
	shot4Instance.global_position = left_point.global_position	
	shot1Instance.apply_impulse(Vector2.UP * 900)
	shot2Instance.apply_impulse(Vector2.DOWN * 900)
	shot3Instance.apply_impulse(Vector2.RIGHT * 900)
	shot4Instance.apply_impulse(Vector2.LEFT * 900)
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player_contact"):
		(area.get_parent() as Player).Damage()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		(body as Projectile).Destroy()				
		if(body as Projectile).TargetColor == TargetColor or (body as Projectile).TargetColor == Color.BLACK:
			Destroy()

extends Node2D
class_name InkTrail

@export var Lifetime : float = 5.0
var delay = 5.0
var active = true
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	animated_sprite_2d.frame = randi_range(0, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Lifetime -= delta
	delay -= delay	
	if Lifetime <= 0:
		active = false
		Fade()

func Destroy():
	queue_free()
	
func Fade():
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_property(animated_sprite_2d, "scale", Vector2.ZERO, 0.5)
	await tween.finished	
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player_contact") and active:
		(area.get_parent() as Player).Damage()
		Destroy()

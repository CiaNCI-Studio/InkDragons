extends Node2D

@export var TargeColor : Color = Color.RED
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.modulate = TargeColor;	

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		(body as Player).ChangeColor(TargeColor)

extends Node2D
class_name ActionArea

@onready var label = $Control/Label
@export var AreaText : String
@export var Key : String
@export var Active : bool = false

signal ActionActivated(key:String)

func _ready():
	SetText(AreaText)	
	if !Active:
		visible = false

func Activate():
	Active = true
	visible = true	
	
func SetText(text : String):
	label.text = text

func _on_area_2d_body_entered(body):
	if Active and body.is_in_group("player"):
		emit_signal("ActionActivated", Key)

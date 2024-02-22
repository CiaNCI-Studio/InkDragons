extends Control
class_name HUD

@onready var life_label = $HBoxContainer/LifeLabel
@onready var life = $HBoxContainer/Life

func _ready():
	life_label.text = Constants.GetMessage("TEXT_LIFES")

func SetLife(value: int):
	life.text = str(value)

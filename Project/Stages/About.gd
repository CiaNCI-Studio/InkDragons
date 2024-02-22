extends Node2D
@onready var about = $Control/About
@onready var button = $Control/Button

func _ready():
	about.text = Constants.GetMessage("ABOUT")
	button.text = Constants.GetMessage("BUTTON_BACK")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Stages/MainMenu.tscn")

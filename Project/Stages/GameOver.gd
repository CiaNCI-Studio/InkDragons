extends Node2D

@onready var label = $Control/Label
@onready var main_menu = $Control/VBoxContainer/MainMenu

func _ready():
	label.text = Constants.GetMessage("TEXT_GAMEOVER")
	main_menu.text = Constants.GetMessage("BUTTON_MAIN_MENU")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Stages/MainMenu.tscn")

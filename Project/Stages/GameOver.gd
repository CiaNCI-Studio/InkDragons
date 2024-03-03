extends Node2D

@onready var label = $Control/Label
@onready var main_menu = $Control/VBoxContainer/MainMenu
@onready var restart = $Control/VBoxContainer/Restart

func _ready():
	label.text = Constants.GetMessage("TEXT_GAMEOVER")
	main_menu.text = Constants.GetMessage("BUTTON_MAIN_MENU")
	restart.text = Constants.GetMessage("BUTTON_RESTART")
	
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Stages/MainMenu.tscn")


func _on_restart_pressed():
	get_tree().change_scene_to_file(Constants.LastStage)

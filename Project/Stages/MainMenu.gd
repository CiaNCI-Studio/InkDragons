extends Node2D
@onready var controls = $Control/Controls as Label
@onready var action_area_start = $ActionAreaStart as ActionArea
@onready var action_area_about = $ActionAreaAbout as ActionArea
@onready var action_area_quit = $ActionAreaQuit as ActionArea
@onready var language_menu = $Control/LanguageMenu

func _ready():
	language_menu.get_popup().id_pressed.connect(OnItemMenuPressed)
	ChangeLanguage()

func ChangeLanguage():
	action_area_start.SetText(Constants.GetMessage("BUTTON_START"))
	action_area_about.SetText(Constants.GetMessage("BUTTON_ABOUT"))
	action_area_quit.SetText(Constants.GetMessage("BUTTON_EXIT"))
	controls.text = Constants.GetMessage("INSTRUCTIONS")
	language_menu.text = Constants.GetMessage("BUTTON_LANGUAGE")

func OnItemMenuPressed(id:int):
	match id:
		0:
			Constants.SetLanguage(GameConstants.LANGUAGE.pt)
		1:
			Constants.SetLanguage(GameConstants.LANGUAGE.esp)
		2:
			Constants.SetLanguage(GameConstants.LANGUAGE.eng)
	ChangeLanguage()
	
func _on_action_area_start_action_activated(_key):
	get_tree().change_scene_to_file("res://Stages/Stage1.tscn")

func _on_action_area_about_action_activated(_key):
	get_tree().change_scene_to_file("res://Stages/About.tscn")

func _on_action_area_quit_action_activated(_key):
	get_tree().quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Stages/Stage1.tscn")

func _on_about_pressed():
	get_tree().change_scene_to_file("res://Stages/About.tscn")

func _on_exit_pressed():
	get_tree().quit()

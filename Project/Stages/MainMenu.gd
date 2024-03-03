extends Node2D

@onready var action_area_start = $ActionAreaStart as ActionArea
@onready var action_area_about = $ActionAreaAbout as ActionArea
@onready var action_area_quit = $ActionAreaQuit as ActionArea
@onready var language_menu = $Control/VBoxContainer/LanguageMenu
@onready var sfx_label = $Control/VBoxContainer/SFXGroup/SFXLabel 
@onready var sfx_slider = $Control/VBoxContainer/SFXGroup/SFXSlider as Slider
@onready var music_label = $Control/VBoxContainer/MusicGroup/MusicLabel
@onready var music_slider = $Control/VBoxContainer/MusicGroup/MusicSlider as Slider
@onready var music_player = $MusicPlayer

func _ready():
	language_menu.get_popup().id_pressed.connect(OnItemMenuPressed)	
	sfx_slider.value = remap(Constants.SfxVolume, 0, 1, 0, 100)
	music_slider.value = remap(Constants.MusicVolume, 0, 1, 0, 100)
	music_player.volume_db = remap(Constants.MusicVolume, 0.0, 1.0, -60.0, -15.0)
	ChangeLanguage()
	

func ChangeLanguage():
	action_area_start.SetText(Constants.GetMessage("BUTTON_START"))
	action_area_about.SetText(Constants.GetMessage("BUTTON_ABOUT"))
	action_area_quit.SetText(Constants.GetMessage("BUTTON_EXIT"))
	language_menu.text = Constants.GetMessage("BUTTON_LANGUAGE")
	sfx_label.text = Constants.GetMessage("TEXT_SFX")
	music_label.text = Constants.GetMessage("TEXT_MUSIC")

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
	get_tree().call_deferred("change_scene_to_file", "res://Stages/Stage1.tscn")

func _on_action_area_about_action_activated(_key):
	get_tree().call_deferred("change_scene_to_file", "res://Stages/About.tscn")

func _on_action_area_quit_action_activated(_key):
	get_tree().quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Stages/Stage1.tscn")

func _on_about_pressed():
	get_tree().change_scene_to_file("res://Stages/About.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_sfx_slider_value_changed(value):
	Constants.SfxVolume = value / 100	

func _on_music_slider_value_changed(value):
	Constants.MusicVolume = value / 100	
	music_player.volume_db = remap(Constants.MusicVolume, 0.0, 1.0, -60.0, -15.0)

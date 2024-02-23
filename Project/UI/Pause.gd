extends Control
class_name Pause
@onready var continueButton = $VBoxContainer/Continue
@onready var main_menu = $VBoxContainer/MainMenu
@onready var reiniciar = $VBoxContainer/Reiniciar
@onready var label = $Label

func _ready():
	label.text = Constants.GetMessage("TEXT_PAUSE")
	main_menu.text = Constants.GetMessage("BUTTON_MAIN_MENU")
	continueButton.text = Constants.GetMessage("BUTTON_CONTINUE")	
	reiniciar.text = Constants.GetMessage("BUTTON_RESTART")	

func _on_continue_pressed():
	get_tree().paused = false
	visible = false

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Stages/MainMenu.tscn")


func _on_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

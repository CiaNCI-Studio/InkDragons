extends Node2D
class_name StageBase

@export var ExitPoint : ActionArea = null
@export var StageLabel : Label = null
@export var HintLabel : Label = null
@export var HintKey : String = ""
@export var NextStage : String = ""
@export var StageNumber : String = ""
@export var MusicPlayer : AudioStreamPlayer = null

var finished = false

func _ready():
	StageLabel.text = Constants.GetMessage("TEXT_STAGE") + StageNumber
	if HintLabel:
		HintLabel.text = Constants.GetMessage(HintKey)
	ExitPoint.SetText(Constants.GetMessage("BUTTON_NEXT"))
	ExitPoint.connect("ActionActivated", ExitStage)
	MusicPlayer.volume_db = remap(Constants.MusicVolume, 0.0, 1.0, -60.0, -15.0)		
	MusicPlayer.play()
	
func _process(_delta):
	CheckBlocks()
	
func CheckBlocks():
	if !finished:
		var blocks = get_tree().get_nodes_in_group("block")
		if !blocks or blocks.size() == 0:
			ShowExit()

func ShowExit():
	ExitPoint.Activate()

func ExitStage(_key):
	get_tree().call_deferred("change_scene_to_file", NextStage)

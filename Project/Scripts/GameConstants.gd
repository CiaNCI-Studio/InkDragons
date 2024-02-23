extends Node
class_name GameConstants

enum LANGUAGE {
	eng,
	pt,
	esp
}
var currentLang : LANGUAGE = LANGUAGE.pt
var _messages_en : Dictionary = {}
var _messages_pt : Dictionary = {}
var _messages_esp : Dictionary = {}
var SfxVolume : float = 1.0
var MusicVolume : float = 1.0

func _ready():
	Build()
	
func Build():		
	BuildTexts()
	
func SetLanguage(language: LANGUAGE):
	currentLang = language
	
func BuildTexts():		
	_messages_en = _load("Texts/text_en.json")
	_messages_pt = _load("Texts/text_pt.json")
	_messages_esp = _load("Texts/text_esp.json")
			
func GetMessage(key: String) -> String:
	match currentLang:
		LANGUAGE.eng:
			return _messages_en.get(key)
		LANGUAGE.pt:
			return _messages_pt.get(key)
		LANGUAGE.esp:
			return _messages_esp.get(key)
	return ""

func _save(fileName : String, content : String):
	var file = FileAccess.open("res://" + fileName, FileAccess.WRITE)
	file.store_string(content)
	file.close()
	
func _load(fileName : String) -> Dictionary:
	if not FileAccess.file_exists("res://" + fileName):
		_save(name, "{}")
		return {}
	var file = FileAccess.open("res://" + fileName, FileAccess.READ)
	var json_object = JSON.new()
	var _parse_err = json_object.parse(file.get_as_text())	
	return json_object.data

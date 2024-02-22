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
var _story_en : Dictionary = {}
var _story_pt : Dictionary = {}
var _story_esp : Dictionary = {}

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

func _save(name : String, content : String):
	var file = FileAccess.open("res://" + name, FileAccess.WRITE)
	file.store_string(content)
	file.close()
	
func _load(name : String) -> Dictionary:
	if not FileAccess.file_exists("res://" + name):
		_save(name, "{}")
		return {}
	var file = FileAccess.open("res://" + name, FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())	
	return json_object.data

extends Node

const SAVE_PATH = "res://config.cfg" 
#"user://config.cfg"


var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"master": db2linear((AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))))*100,
		"music": db2linear((AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))))*100
	}
}

func _ready():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		save_settings(_settings)
	else:
		print("File already exists")
#	var root = get_tree().get_root()
#	var current_scene = root.get_child(root.get_child_count() - 1)
#	var Text =  current_scene.get_node("MainMenu/Text")
#	Text.text = str(_settings["audio"]["master"])
	


func save_settings(saveData):
	if saveData == null:
		saveData = _settings
	for section in saveData.keys():
		for key in saveData[section]:
			_config_file.set_value(section, key, saveData[section][key])
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading settings file.")
		return []

	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)
	return(_settings)






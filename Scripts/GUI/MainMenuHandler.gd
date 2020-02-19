extends Control


onready var Root = get_node("/root")
onready var Config = get_node("/root/ConfigHandler")
onready var saveData = Config.load_settings()
onready var MainMenu = get_node("MainMenu")
onready var OptionsMenu = get_node("OptionsMenu")
onready var VolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxMasterVolume/HSlider")
onready var MusicVolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxMusicVolume/HSliderMusic")





# Called when the node enters the scene tree for the first time.
func _ready():
	var mainInnerContainer = get_node("MainMenu/Container/InnerContainer")
	var tweenMain = get_node("MainMenu/Container/InnerContainer/Tween")
	var mainInnerStartRect = mainInnerContainer.rect_position
	MusicVolumeSlider.value = saveData["audio"]["music"]
	VolumeSlider.value = saveData["audio"]["master"]
	tweenMain.interpolate_property(mainInnerContainer, "rect_position", mainInnerStartRect-Vector2(3000,320), mainInnerStartRect+Vector2(0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenMain.start()



func _on_Exit_pressed():
	get_tree().quit()



func _on_Options_pressed():
#	tweenMain.interpolate_property(mainInnerContainer, "rect_position", Vector2(0,470), Vector2(-3000,320), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	tweenMain.start()
#	mainInnerContainer.hide()
	MainMenu.hide()
	OptionsMenu.show()




func _on_BackOptions_pressed():
	OptionsMenu.hide()
	Config.save_settings(saveData)
	MainMenu.show()



func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	saveData["audio"]["master"] = value



func _on_HSliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	saveData["audio"]["music"] = value
	if value == 50:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -100)
		saveData["audio"]["music"] = -100

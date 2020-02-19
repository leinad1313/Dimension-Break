extends Control


onready var Root = get_node("/root")
onready var Config = get_node("/root/ConfigHandler")
onready var SaveData = Config.load_settings()
onready var MainMenu = get_node("MainMenu")
onready var OptionsMenu = get_node("OptionsMenu")
onready var VolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxMasterVolume/HSlider")
onready var MusicVolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxMusicVolume/HSliderMusic")
onready var mainInnerContainer = get_node("MainMenu/Container/InnerContainer")
onready var mainInnerStartRect = mainInnerContainer.rect_position





# Called when the node enters the scene tree for the first time.
func _ready():
	MusicVolumeSlider.value = SaveData["audio"]["music"]
	VolumeSlider.value = SaveData["audio"]["master"]
	$Tween.interpolate_property(mainInnerContainer, "rect_position", mainInnerStartRect-Vector2(3000,320), mainInnerStartRect+Vector2(0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()



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
	Config.save_settings(SaveData)
	MainMenu.show()



func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	SaveData["audio"]["master"] = value



func _on_HSliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	SaveData["audio"]["music"] = value
	if value == 50:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -100)
		SaveData["audio"]["music"] = -100


func _on_NewGame_pressed():
	$Tween.interpolate_property(mainInnerContainer, "rect_position", mainInnerStartRect, mainInnerStartRect-Vector2(3000,320), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(1.5),"timeout")
	MainMenu.hide()
	var SunSprite = get_node("AnimatedSprite")
	$Tween.interpolate_property(SunSprite, "scale", SunSprite.scale, 
	Vector2(27.163, 27.56), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween2.interpolate_property(get_node("Panel"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	$Tween2.start()

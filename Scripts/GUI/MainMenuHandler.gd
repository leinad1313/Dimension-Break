extends Control

onready var Root = get_node("/root")
onready var MainMenu = get_node("MainMenu")
onready var OptionsMenu = get_node("OptionsMenu")
onready var ResolutionButton = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxResolution/OptionButton")
onready var VolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox1/HBoxMasterVolume/HSlider")
onready var MusicVolumeSlider = get_node("OptionsMenu/HBoxContainer/VBox2/HBoxMusicVolume/HSliderMusic")


# Called when the node enters the scene tree for the first time.
func _ready():
	var mainInnerContainer = get_node("MainMenu/Container/InnerContainer")
	var tweenMain = get_node("MainMenu/Container/InnerContainer/Tween")
	var mainInnerStartRect = mainInnerContainer.rect_position
	
	var RawResolution = Root.get_visible_rect()
	var RawResolutionSize = RawResolution.size
	var FinalResolution = str(RawResolutionSize.floor()).replace("(", "").replace(")", "").replace(", ", "x")
	if FinalResolution == "1280x720":
		ResolutionButton.select(0)
	elif FinalResolution == "1920x1080":
		ResolutionButton.select(1)
	elif FinalResolution == "2540x1440":
		ResolutionButton.select(2)
	else:
		ResolutionButton.select(3)
	
	ResolutionButton.text = FinalResolution
	MusicVolumeSlider.value = db2linear((AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))))*100
	VolumeSlider.value = db2linear((AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))))*100
	tweenMain.interpolate_property(mainInnerContainer, "rect_position", mainInnerStartRect-Vector2(3000,320), mainInnerStartRect+Vector2(0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenMain.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
	MainMenu.show()



func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)



func _on_OptionButton_item_selected(id):
	if id == 1:
		Root.size = Vector2(1920, 1080)
		OS.window_size = Vector2(1920, 1080)
	elif id == 0:
		Root.size = Vector2(1280, 720)
		OS.window_size = Vector2(1280, 720)
	elif id == 2:
		Root.size = Vector2(2540, 1440)
		OS.window_size = Vector2(2540, 1440)
	else:
		Root.size = Vector2(3840, 2160)
		OS.window_size = Vector2(3840, 2160)


func _on_HSliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	if value == 50:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -100)


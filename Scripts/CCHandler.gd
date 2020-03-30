extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_MainMenu_pressed():
	$"/root/SceneHandler".goto_scene("res://Scenes/TitleScreenOffline.tscn")


func _on_BackSelect_pressed():
	$CharSelect.show()
	$Creator.hide()


func _on_NewChar_pressed():
	$CharSelect.hide()
	$Creator.show()

extends Node


func _on_login_pressed():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	var email = $Container/HBoxContainer/InnerContainer/email.text
	var password = $Container/HBoxContainer/InnerContainer/password.text
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request("http://localhost/FetchLoginData.php?email="+email+"&password="+password, headers, true)


# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if json.result == null or []:
		$Container/HBoxContainer/InnerContainer/Error.text = "	Email or password incorrent!"
	else:
		get_parent().get_node("Login").hide()
		get_parent().get_node("MainMenu").show()
		$"/root/AccountDataHandler".setEmail(json.result["email"])

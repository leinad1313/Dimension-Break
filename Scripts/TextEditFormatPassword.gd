extends TextEdit

func _input(event):

	var final_text = ""

	var regex = RegEx.new()
	regex.compile("[a-zA-Z0-9!?]")

	var regex_match = regex.search_all(text)
	if regex_match:
		for i in range(0,regex_match.size()):
			final_text += regex_match[i].get_string()

	text = final_text
	cursor_set_column(text.length())

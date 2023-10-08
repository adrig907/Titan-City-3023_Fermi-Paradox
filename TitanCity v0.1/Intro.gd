extends Panel



func _process(delta):
	if Input.is_action_pressed("click_left"):
		visible = false;

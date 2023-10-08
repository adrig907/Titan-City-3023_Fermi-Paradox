extends Panel

func _on_quest_time_timeout():
	visible = true;

func _process(delta):
	if visible == true:
		if Input.is_key_pressed(KEY_SPACE):
			visible = false;
			$TimerQuestion1.start()



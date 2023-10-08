extends Panel

func _on_quest_time_timeout():
	visible = true;

func _process(delta):
	if Input.is_action_pressed("click_left"):
		visible = false;
		$TimerQuestion1.start()



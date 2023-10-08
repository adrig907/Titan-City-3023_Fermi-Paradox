extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	#if Input.is_key_pressed(KEY_SPACE):
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_D):
		visible = false;


func _on_timer_question_1_timeout():
	visible=true;

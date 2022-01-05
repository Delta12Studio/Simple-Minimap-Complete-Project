extends CanvasLayer

func _ready():
	if get_parent().name == "Level1":
		$Label.text = "Welcome to Level 1"
	show_name()
	if get_parent().name == "Level2":
		$Label.text = "Welcome to Level 2"
	show_name()
	if get_parent().name == "Level3":
		$Label.text = "Welcome to Level 3"
	show_name()
	if get_parent().name == "Level4":
		$Label.text = "Welcome to Level 4"
	show_name()
	if get_parent().name == "Central":
		$Label.text = "Welcome to Central Level"
	show_name()

func show_name():
	$AnimationPlayer.play("ShowName")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

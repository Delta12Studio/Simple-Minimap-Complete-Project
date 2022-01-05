extends ColorRect

var selected_menu = 0
var can_load      = false

func _ready():
	change_menu_color()

	var file = File.new()
	if file.file_exists("user://savegame.json"):
		can_load = true
	file.close()

func change_menu_color():

	$Save/ColorRect.color    = Color("ffd0a0")
	$Load/ColorRect.color    = Color("ffd0a0")
	$Restart/ColorRect.color = Color("ffd0a0")
	$Quit/ColorRect.color    = Color("ffd0a0")

	match selected_menu:

		0:
			$Save/ColorRect.color    = Color("dcff64")
		1:
			$Load/ColorRect.color    = Color("dcff64")
		2:
			$Restart/ColorRect.color = Color("dcff64")
		3:
			$Quit/ColorRect.color    = Color("dcff64")

func _input(_event):

	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 4;
		change_menu_color()

	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 3
		change_menu_color()

	elif Input.is_action_just_pressed("ui_accept"): #Enter

		match selected_menu:

			0:
				Global.save_game()
				$Save/Label.text = "Saved"
			1:
				if can_load == true:
					Global.load_game()
				else:
					$Load/ColorRect.color = Color("ff3737")
				
			2:
				Global.restart_game()
			3:
				get_tree().quit()

	elif Input.is_action_just_pressed("ui_menu"):
		get_tree().paused = false
		self.queue_free()







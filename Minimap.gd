extends ColorRect

var visited = Global.visited

func _ready():
	show_doors()
	hide_map()
	blink()

func hide_map():
	if "Level1" in visited:
		$Level1/Hide.visible = false
	if "Level2" in visited:
		$Level2/Hide.visible = false
	if "Level3" in visited:
		$Level3/Hide.visible = false
	if "Level4" in visited:
		$Level4/Hide.visible = false
	if "Central" in visited:
		$Central/Hide.visible = false

func blink():
	if get_parent().name == "Level1":
		$Level.text = "Level 1"
		$Position.text = "Left"
		$Level1/Blink.visible = true
	if get_parent().name == "Level2":
		$Level.text = "Level 2"
		$Position.text = "Top"
		$Level2/Blink.visible = true
	if get_parent().name == "Level3":
		$Level.text = "Level 3"
		$Position.text = "Right"
		$Level3/Blink.visible = true
	if get_parent().name == "Level4":
		$Level.text = "Level 4"
		$Position.text = "Bottom"
		$Level4/Blink.visible = true
	if get_parent().name == "Central":
		$Level.text = "Central"
		$Position.text = "Central"
		$Central/Blink.visible = true

func show_doors():
	if not "Door2" in Global.key_founded:
		$Central/Door2.color = Color(1,0,0)
	if "Door2" in Global.key_founded:
		$Central/Door2.color = Color(0,0,1)
	if "Door2" in Global.opened_doors:
		$Central/Door2.color = Color(0,1,0)

	if not "Door4" in Global.key_founded:
		$Central/Door4.color = Color(1,0,0)
	if "Door4" in Global.key_founded:
		$Central/Door4.color = Color(0,0,1)
	if "Door4" in Global.opened_doors:
		$Central/Door4.color = Color(0,1,0)

func _input(_event):
	if Input.is_action_just_pressed("ui_map"):
		get_tree().paused = false
		self.queue_free()

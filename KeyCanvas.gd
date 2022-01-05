extends CanvasLayer

func _ready():
	show_key()
	hide_key()
	delete_canvas()

func show_key():
	if "Door2" in Global.key_founded and not "Door2" in Global.opened_doors:
		$Door2.visible = true
	if "Door4" in Global.key_founded and not "Door4" in Global.opened_doors:
		$Door4.visible = true

func hide_key():
	if "Door2" in Global.opened_doors:
		$Door2.visible = false
	if "Door4" in Global.opened_doors:
		$Door4.visible = false

func delete_canvas():
	if "Door2" in Global.opened_doors and "Door4" in Global.opened_doors:
		self.queue_free()

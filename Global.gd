extends Node2D

var from_level
var auto_move_direction = Vector2.ZERO
var visited             = []
var key_founded         = []
var opened_doors        = []
var current_level
var data

func save_game():
	data = {
		"auto_move_direction" : [auto_move_direction.x , auto_move_direction.y],
		"from_level"          : from_level,
		"visited"             : visited,
		"key_founded"         : key_founded,
		"opened_doors"        : opened_doors,
		"current_level"       : current_level,
	}

	var file = File.new()
	file.open("user://savegame.json", File.WRITE) 
	#Windows -> C:\Users\(User Name)\%AppData%\Roaming\Godot\app_userdata\(Project Name)
	#Linux   -> /home/(User Name)/.local/share/godot/app_userdata/(Project Name)
	#Mac     -> ???????????????????????
	var json = to_json(data)
	file.store_line(json)
	file.close()

func load_game():
		var file = File.new()
		file.open("user://savegame.json", File.READ)
		data = parse_json(file.get_as_text())
		file.close()

		auto_move_direction = Vector2(data.auto_move_direction[0] , data.auto_move_direction[1])
		from_level          = data.from_level
		visited             = data.visited
		key_founded         = data.key_founded
		opened_doors        = data.opened_doors
		current_level       = data.current_level

# warning-ignore:return_value_discarded
		get_tree().change_scene("res://" + current_level + ".tscn")
		get_tree().paused = false

func restart_game():
	from_level          = null
	auto_move_direction = Vector2.ZERO
	visited             = []
	key_founded         = []
	opened_doors        = []

# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Level1.tscn")
	get_tree().paused = false

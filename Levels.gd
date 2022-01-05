extends Node2D

onready var Level          = preload("res://LevelName.tscn")
onready var Map            = preload("res://Minimap.tscn")
onready var Canvas         = preload("res://KeyCanvas.tscn")
onready var Menu           = preload("res://Menu.tscn")
var visited                = Global.visited
var current_level_name

func _ready():

	current_level_name = self.name
	if not current_level_name in visited:
		visited.append(current_level_name)
		var level_name = Level.instance()
		add_child(level_name)

	if Global.from_level != null:
		get_node("Player").set_position(get_node(Global.from_level + "Pos").position)
		get_node("Player").auto_move()

	key_collect()
	Global.current_level = self.name

func key_collect():
	if Global.key_founded != []:
		if not has_node("KeyCanvas"):
			var canvas = Canvas.instance()
			add_child(canvas)
		else:
			get_node("KeyCanvas").show_key()

func _input(_event):

	if Input.is_action_just_pressed("ui_map"):
		if not has_node("Minimap"):
			var map = Map.instance()
			add_child(map)
			get_tree().paused = true

	if Input.is_action_just_pressed("ui_menu"):
		if not has_node("Menu"):
			var menu = Menu.instance()
			add_child(menu)
			get_tree().paused = true

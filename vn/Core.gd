extends Node

class_name Core

var _root: Node
var _animation_system: AnimationSystem
var _event_handler: EventHandler
var _background: Background
var _textbox: TextBox
var _text: Text
var _fonts: Dictionary
var _textures: Dictionary
var _screen_stack: Dictionary
var _characters: Dictionary
var _expr: CommandExpression

const TEXT_SPEED: float = 1.0

signal mouse_click

func _init(context):
	_root = context
	
	_textures[System.st("default_sprite_texture")] = load("res://res/img/Dv.png")
	_textures[System.st("default_textbox_texture")] = load("res://res/img/textbox.png")
	
	_animation_system = AnimationSystem.new(self)
	_event_handler = EventHandler.new(self)
	_expr = CommandExpression.new(self)
	_background = Background.new(self)
	_textbox = TextBox.new(self)
	_text = Text.new(self)
		
	_root.add_child(_animation_system)
	_root.add_child(_background)
	_root.add_child(_textbox)
	_root.add_child(_text)

func event_listener(event) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		emit_signal("mouse_click")

func load_vne_file(file_path: String) -> PoolStringArray:
	var file = File.new()
	file.open("res://" + file_path, file.READ)
	var text = file.get_as_text()
	file.close()
	return text.split("\n", true)

func define_font(type: String, font_path: String, font_size: int = 16):
	match type:
		"normal_font":
			_text.set_font(type, "res://" + font_path, font_size)
		"bold_font":
			_text.set_font(type, "res://" + font_path, font_size)
		_:
			push_error("Unknown font type.")
			assert(false)

func define_texture(id: String, texture_path: String) -> void:
	if _textures.has(System.ut(id)):
		push_error("This texture id already exists.")
		assert(false)
	_textures[System.ut(id)] = load("res://" + texture_path)
	
func define_character(id: String, name: String, hex_color: String = "#FFFFFF", texture_id: String = "s_default_sprite_texture") -> void:
	if _characters.has(System.ut(id)):
		push_error("This character id already exists.")
		assert(false)
	var character = Character.new(self, System.ut(id), name, hex_color, _textures[System.ut(texture_id)])
	_characters[System.ut(id)] = character
	_root.add_child(character)

func render(string_commands: Array) -> void:
	var commands = _expr.parse_raw_strings(string_commands)
	if commands == null:
		push_error("Script syntax error.")
		assert(false)
	for command in commands:
		match command[0]:
			"SHOW_BG":
				command.pop_front()
				_event_handler.emit("show_bg", command)
				if command.size() == 2:
					yield(_animation_system, "animation_finished")
			"SHOW_SP":
				command.pop_front()
				_event_handler.emit("show_sp", command)
				if command.size() == 3:
					yield(_animation_system, "animation_finished")
			"HIDE_BG":
				command.pop_front()
				if command.size() == 1:
					_event_handler.emit("hide_bg", command)
					yield(_animation_system, "animation_finished")
					_background.hide()
				else:
					_event_handler.emit("hide_bg")
			"TEXT_EMPTY":
				command.pop_front()
				_event_handler.emit("text_empty", command)
			"TEXT":
				command.pop_front()
				_event_handler.emit("text", command)
				yield(self, "mouse_click")
			"END":
				command.pop_front()
				_event_handler.emit("end")

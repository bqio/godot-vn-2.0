extends Node2D

class_name Text

var _self
var _value: RichTextLabel

func _init(context):
	z_index = 3
	
	_self = context
	_value = RichTextLabel.new()
	_value.visible_characters = 0
	_value.set_size(Vector2(1160, 100))
	_value.set_position(Vector2(80, 500))
	_value.bbcode_enabled = true
	
	add_child(_value)

func set_font(type: String, font_path: String, size: int):
	var font = DynamicFont.new()
	font.font_data = load(font_path)
	font.size = size
	_value.add_font_override(type, font)

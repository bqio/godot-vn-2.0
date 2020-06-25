extends Node

class_name EventHandler

var _self

func _init(context):
	_self = context
	
func emit(method: String, args: Array = []):
	callv(method, args)

func text_empty(text: String):
	_self._text._value.clear()
	_self._text._value.add_text(text)

func text(id: String, text: String):
	var character = _self._characters[System.ut(id)]
	_self._text._value.bbcode_text = ""
	_self._text._value.visible_characters = 0
	_self._text._value.bbcode_text = "[color=%s][b]%s[/b][/color]\n%s" % [character._color, character._name, text]
	_self._animation_system.text_typewriter(_self._text._value.text.length())
	_self._animation_system.play("text_typewriter")

func show_bg(id: String, anim: String = ""):
	if !_self._textures.has(System.ut(id)):
		push_error("This texture id not exists.")
		assert(false)
	_self._background._id = System.ut(id)
	_self._background._rect.texture = _self._textures[System.ut(id)]
	match anim:
		"":
			_self._background.show()
		"fadeIn":
			_self._animation_system.fadeIn(System.ut(id), _self._background)

func show_sp(id: String, pos: String, anim: String = ""):
	var uid = System.ut(id)
	match pos:
		"left":
			_self._characters[uid].set_pos(0.0)
		"center":
			_self._characters[uid].set_pos(0.4)
		"right":
			_self._characters[uid].set_pos(0.7)
		_:
			_self._characters[uid].set_pos(0.1)
	
	match anim:
		"":
			_self._characters[uid].show()
		"fadeIn":
			_self._animation_system.fadeIn(uid, _self._characters[uid])

func hide_bg(anim: String = ""):
	match anim:
		"":
			_self._background.hide()
		"fadeOut":
			_self._animation_system.fadeOut(_self._background)

func end():
	_self._root.get_tree().quit()

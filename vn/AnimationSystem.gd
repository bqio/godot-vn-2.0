extends AnimationPlayer

class_name AnimationSystem

var _self

func _init(context):
	_self = context
	
func text_typewriter(count: float):
	var anim = Animation.new()
	var idx = anim.add_track(Animation.TYPE_VALUE)
	
	anim.track_set_path(idx, str(_self._text._value.get_path()) + ":visible_characters")
	
	var lps = 15
	var l = 0.0
	var sec = 0.0
	
	while (l <= count):
		anim.track_insert_key(idx, sec, l)
		sec += 1
		l += lps
	anim.track_insert_key(idx, sec, l)
	anim.length = sec
	
	var err = add_animation("text_typewriter", anim)
	if err != OK:
		push_error("Core error.")
		assert(false)
	play("text_typewriter")
	yield(self, "animation_finished")
	yield(_self, "mouse_click")

func fadeIn(id: String, node: Node2D):
	var anim = Animation.new()
	var idx = anim.add_track(Animation.TYPE_VALUE)
	var r = node.modulate.r
	var g = node.modulate.g
	var b = node.modulate.b
	node.modulate = Color(r, g, b, 0.0)
	anim.length = .8
	anim.track_set_path(idx, str(node.get_path()) + ":modulate")
	anim.track_insert_key(idx, 0.0, Color(r, g, b, 0.0))
	anim.track_insert_key(idx, .8, Color(r, g, b, 1.0))
	
	var err = add_animation(id + "_fadeIn", anim)
	if err != OK:
		push_error("Core error.")
		assert(false)
	
	node.show()
	play(id + "_fadeIn")

func fadeOut(node: Node2D):
	var anim = Animation.new()
	var idx = anim.add_track(Animation.TYPE_VALUE)
	var r = node.modulate.r
	var g = node.modulate.g
	var b = node.modulate.b
	node.modulate = Color(r, g, b, 0.0)
	anim.length = 1
	anim.track_set_path(idx, str(node.get_path()) + ":modulate")
	anim.track_insert_key(idx, 0.0, Color(r, g, b, 1.0))
	anim.track_insert_key(idx, 1.0, Color(r, g, b, 0.0))
	
	var err = add_animation(node._id + "_fadeOut", anim)
	if err != OK:
		push_error("Core error.")
		assert(false)
	
	play(node._id + "_fadeOut")

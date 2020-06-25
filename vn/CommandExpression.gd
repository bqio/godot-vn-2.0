extends Node

class_name CommandExpression

const TEXT_EMPTY_EXPRESSION: String = "^\"(.*?)\"$"
const TEXT_EXPRESSION: String = "^(\\w+)\\s\"(.*?)\"$"
const SHOW_BG_EXPRESSION: String = "^showbg\\s(\\w+)\\s?(\\w+)?$"
const SHOW_SP_EXPRESSION: String = "^showsp\\s(\\w+)\\s(\\w+)\\s?(\\w+)?$"
const HIDE_BG_EXPRESSION: String = "^hidebg\\s?(\\w+)?$"
const END_EXPRESSION: String = "^end$"

var _self
var _expr: RegEx

func _init(context):
	_self = context
	_expr = RegEx.new()

func parse_raw_string(raw_string: String):
	var _stack: Array = []
	var _match: RegExMatch
	var _err
	
	_err = _expr.compile(TEXT_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)

	if _match:
		_stack.append("TEXT")
		_stack.append(_match.get_string(1))
		_stack.append(_match.get_string(2))
		return _stack
	
	_err = _expr.compile(TEXT_EMPTY_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)
	
	if _match:
		_stack.append("TEXT_EMPTY")
		_stack.append(_match.get_string(1))
		return _stack
	
	_err = _expr.compile(SHOW_BG_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)
	
	if _match:
		_stack.append("SHOW_BG")
		_stack.append(_match.get_string(1))
		var anim = _match.get_string(2)
		if anim.length() > 0:
			_stack.append(_match.get_string(2))
		return _stack
	
	_err = _expr.compile(SHOW_SP_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)
	
	if _match:
		_stack.append("SHOW_SP")
		_stack.append(_match.get_string(1))
		_stack.append(_match.get_string(2))
		var anim = _match.get_string(3)
		if anim.length() > 0:
			_stack.append(_match.get_string(3))
		return _stack
	
	_err = _expr.compile(HIDE_BG_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)
	
	if _match:
		_stack.append("HIDE_BG")
		var anim = _match.get_string(1)
		if anim.length() > 0:
			_stack.append(_match.get_string(1))
		return _stack
	
	_err = _expr.compile(END_EXPRESSION)
	if _err != OK:
		push_error("Core error.")
		assert(false)
	_match = _expr.search(raw_string)
	
	if _match:
		_stack.append("END")
		return _stack
	
	return null

func parse_raw_strings(raw_strings: Array):
	var strings: Array = []
	for s in raw_strings:
		var string = parse_raw_string(s)
		if string == null:
			return null
		strings.append(parse_raw_string(s))
	return strings

extends Node2D

var vn

# init event listener (required)
func _input(ev):
	vn.event_listener(ev)

func _ready():
	# init
	vn = Core.new(self)
	
	# define textures
	vn.define_texture("default_bg", "res/img/bg0.jpg")
	vn.define_texture("main_bg", "res/img/bg1.jpg")
	vn.define_texture("alisa_char_idle", "res/img/Dv.png")
	vn.define_texture("lena_char_idle", "res/img/Lena.png")
	
	# define characters
	vn.define_character("lyba", "Люба", "#FF0000", "alisa_char_idle")
	vn.define_character("alina", "Алина", "#FCD511", "lena_char_idle")
	
	# define fonts
	vn.define_font("normal_font", "res/fonts/Ubuntu-Bold.ttf", 20)
	vn.define_font("bold_font", "res/fonts/Ubuntu-BoldItalic.ttf", 20)

	var vne = vn.load_vne_file("res/scripts/script.vne")
	vn.render(vne)

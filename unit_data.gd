extends Node2D

# resources are currently by summed up into an elixr like (clash ref) system.
# so when creating a unit, u can select characteristics below and
# it costs more to deploy the better it is. so high stamina, large size,
# units maybe to defend the frontline, really fast units to flank the 
# enemy,

# stamina represents the stamina for the unit. units that go through
# a round in rest (without movement, attack, defense, etc.) will gain an 
# increase in their stamina.
var max_stamina = 100.0
var stamina = max_stamina

# a unit starts out with a size. units, if merged, with idk if im adding 
# yet can increase in size, but otherwise can only decrease in size.
var size = 1000 # by number of troops

# speed is obvious im not describing ts. but it'll be in pixels/sec.
# ensure adjustment for framerate (deltatime) when using speed.
var speed = 30

# an arbitrary measurement of damage upon impact with another unit.
var attack = 67

# the country it belongs to, Germany or France.
var country = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# base width of the flag for the smallest unit
const base_flag_width = 50
var base_flag_scale = 0

func create_sprite():
	var sprite = Sprite2D.new()
	if country == "Germany":
		sprite.texture = load("res://flags/germany.png")
	elif country == "France":
		sprite.texture = load("res://flags/france.png")
	else:
		# uhh how do i panic in godot...
		print("shlog u might be fried what country is ts unit for: ", country)
	
	# get the scale for the flag and adjust from there where any
	# changes made to "size" will be reflected on the flag scale
	# a 10,000 size unit should NOT be the same size as a 100 size unit
	# 
	base_flag_scale = base_flag_width/sprite.texture.get_width()
	sprite.apply_scale(Vector2(base_flag_scale, base_flag_scale))

extends Node2D

# resources are currently by summed up into an elixr like (clash ref) system.
# so when creating a unit, u can select characteristics below and
# it costs more to deploy the better it is. so high stamina, large size,
# units maybe to defend the frontline, really fast units to flank the 
# enemy,

## stamina represents the stamina for the unit. units that go through
## a round in rest (without movement, attack, defense, etc.) will gain an 
## increase in their stamina.
#var max_stamina = 100.0
#var stamina = max_stamina

# the level of troop. this affects the power in attacking, the stamina
# of troops, the speed of troops, and defensive blocks.
var level = 1

# a unit starts out with a size. units, if merged, with idk if im adding 
# yet can increase in size, but otherwise can only decrease in size.
var size = 1000 # by number of troops

# the country it belongs to, Germany or France.
var country = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#update_flag_scale()
	
# base width of the flag for the smallest unit
const base_flag_width = 50
var base_flag_scale: float = 0.0

func create_sprite():
	print("getting readY!")
	var sprite = Sprite2D.new()
	sprite.name = "sprite"
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
	base_flag_scale = base_flag_width/float(sprite.texture.get_width())
	sprite.apply_scale(Vector2(base_flag_scale, base_flag_scale))
	print(base_flag_scale)
	add_child(sprite)

# update flag scale adjusts the scale of the flag to match the current size of the unit
#func update_flag_scale():
	#var new_scale = max(base_flag_scale * 2 * float(size/1000), base_flag_scale)
	#var sprite = get_node("sprite")
	#sprite.apply_scale(Vector2(new_scale, new_scale))

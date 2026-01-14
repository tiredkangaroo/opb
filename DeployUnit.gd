extends Node2D

var levelPressed = 1
@onready var resources = get_node("../resources")
@onready var root = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cl: Label = get_node("ColorRect/CostLabel")
	if !resources.has_enough(get_current_cost()):
		cl.add_theme_color_override("font_color", Color(1, 0, 0))
	else:
		cl.add_theme_color_override("font_color", Color(0, 0, 0))


func _on_h_slider_value_changed(value: float) -> void:
	# updat size label
	get_node("ColorRect/SizeNode/SizeLabel").text = "%d troops" % value
	updateCost()

func updateCost():
	var cost = get_current_cost()
	var cl: Label = get_node("ColorRect/CostLabel")
	cl.text = "cost: %d resource pts" % cost
	return cost

func get_current_cost():
	var size: HSlider = get_node("ColorRect/SizeNode/HSlider")
	var cost: float = float(size.value)/6.7
	cost *= float(levelPressed)/2.0
	return max(cost, 85)


func _on_level_1_toggled(toggled_on: bool) -> void:
	if toggled_on:
		levelPressed = 1
	updateCost()


func _on_level_2_toggled(toggled_on: bool) -> void:
	if toggled_on:
		levelPressed = 2
	updateCost()


func _on_level_3_toggled(toggled_on: bool) -> void:
	if toggled_on:
		levelPressed = 3
	updateCost()


func _on_button_pressed() -> void:
	# deploy the unit!!
	var cost = updateCost()
	if !resources.use(cost):
		return
	
	var unit: Node2D = load("res://Unit.tscn").instantiate()
	unit.level = levelPressed
	unit.size = get_node("ColorRect/SizeNode/HSlider").value
	unit.country = "France"
	unit.set_position(Vector2(500, 500))
	root.add_child(unit)

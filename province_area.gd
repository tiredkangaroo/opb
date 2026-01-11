extends Area2D

var province_name = ""
var province_country = ""
var province_color = Color()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	# all those little add_child calls end up calling this
	if node.is_class("Polygon2D"):
		if province_country == "Germany":
			province_color = Color(.71, .24, .23, 1)
		else:
			province_color = Color(.21, .25, .67) # hehe 67
		node.color = province_color
		
func _on_mouse_entered():
	print("yall mighta just hovered ts: ", province_name)
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(0, 0, 0, .7)

func _on_mouse_exited():
	# mouse left after entering
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = province_color

func _on_input_event(viewport, event, shape_idx):
	# handle click on the polygon
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print(str(province_name) + " clicked")

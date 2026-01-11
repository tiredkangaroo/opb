extends Area2D

var province_name = ""
var province_country = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_mouse_entered() -> void:
	print("mouse entered ", province_name, " in ", province_country)

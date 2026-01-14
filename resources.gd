extends Node2D

var resource_points = 67.0
var points_per_second = 1
var max_resource_points = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pb = get_node("ProgressBar")
	pb.max_value = max_resource_points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	resource_points += (delta * points_per_second)
	var pb = get_node("ProgressBar")
	pb.value = resource_points

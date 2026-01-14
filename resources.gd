extends Node2D

var resource_points = 200
var points_per_second = 0.2
var max_resource_points = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# note: should i be using onload for this?
	var pb = get_node("ProgressBar")
	pb.max_value = max_resource_points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# add to resource points
	resource_points = min(resource_points + (delta * points_per_second), max_resource_points)
	
	# set progress bar value
	var pb = get_node("ProgressBar")
	pb.value = (resource_points/max_resource_points)*100
	
	# set progress label val
	var pl: Label = get_node("ProgressBar/ProgressLabel")
	pl.text = "%.1f points" % resource_points

func use(points):
	if points > resource_points:
		return false
	resource_points -= points
	return true

func has_enough(points):
	return points <= resource_points

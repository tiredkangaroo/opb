extends Node

@onready var mapImage = $map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_provinces()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_provinces():
	var image = mapImage.get_texture().get_image()
	#var pixel_color_dict = get_pixel_color_dict(image)
	var provinces_dict = unmarshal_file("res://map/data.json")
	
	for province_color in provinces_dict: # key
		var province = load("res://province_area.tscn").instantiate()
		
		var province_name_with_country: String = provinces_dict[province_color]
		var name_parts = province_name_with_country.split(" ")
		var country_code = name_parts[-1]
		var province_name = " ".join(name_parts.slice(0, name_parts.size() - 1))
		
		province.province_name = province_name
		if country_code == "DE":
			province.province_country = "Germany"
		elif country_code == "FR":
			province.province_country = "France"
		else:
			print("unexpected country code", country_code)
			return
		
		get_node("provinces").add_child(province)

func unmarshal_file(filepath: String):
	# open file w read and just parse
	# i miss golang 😭
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file == null:
		print("error: failed to open file")
		return
	else:
		return JSON.parse_string(file.get_as_text())


func get_pixel_color_dict(image):
	var d = {}
	for y in range(image.get_height()): # top to bottom
		for x in range(image.get_width()): # left to right
			# prepend # to the color at the pixel
			var pixel_color = "#" + str(image.get_pixel(int(x), int(y)).to_html(false))
			if pixel_color not in d:
				d[pixel_color] = []
			d[pixel_color].append(Vector2(x, y)) # keep a list of every color to the pixels with that color
	return d

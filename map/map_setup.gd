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
	var pixel_color_dict = get_pixel_color_dict(image)
	var provinces_dict = unmarshal_file("res://map/data.json")
			
	for province_color in provinces_dict: # key
		var province = load("res://province_area.tscn").instantiate()
		
		var province_name_with_country: String = provinces_dict[province_color]
		var name_parts = province_name_with_country.split(" ")
		var country_code = name_parts[-1]
		var province_name = " ".join(name_parts.slice(0, name_parts.size() - 1))
		
		province.set_name(province_color)
		province.province_name = province_name
		if country_code == "DE":
			province.province_country = "Germany"
		elif country_code == "FR":
			province.province_country = "France"
		else:
			print("unexpected country code", country_code)
			return
		
		
		# polygons for the province
		var polygons = get_polygons(image, pixel_color_dict, province_color)
		for polygon in polygons:
			var pv_collision = CollisionPolygon2D.new()
			var pv_polygon := Polygon2D.new()
			
			pv_collision.polygon = polygon
			pv_polygon.polygon = polygon
			
			province.add_child(pv_collision)
			province.add_child(pv_polygon)
		
		get_node("provinces").add_child(province)

# polygon for a province
func get_polygons(image, pixel_color_dict, province_color):
	# recreate the img but with all provinces only and with them being white
	var image_size = image.get_size()
	var targetImage = Image.create(image_size.x, image_size.y, false, Image.FORMAT_RGBA8)
	for value in pixel_color_dict[province_color]:
		targetImage.set_pixel(value.x, value.y, "#ffffff")
	
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(targetImage)
	# make the polygons (an array that contains arrays of vector points)
	var polygons = bitmap.opaque_to_polygons(
		Rect2(
			Vector2(0, 0),
			bitmap.get_size(),
		),
		0.1
	)
	return polygons

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

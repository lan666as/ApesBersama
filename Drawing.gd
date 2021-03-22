extends Node2D

# (0,0) coordinate
var center = Vector2(200, 400)
var radius = 80
var angle_from = 0
var angle_to = 180
var color = Color(1.0, 0.0, 0.0)

var source = PoolVector2Array()
var next = PoolVector2Array()

var trans_x: float
var trans_y: float

var rot: float

var scale_x: float = 1
var scale_y: float = 1

var shear_x: float = 0
var shear_y: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Default Triangle
	triangle()
	
# Triangle matrix
func triangle():
	# Clear array
	source = PoolVector2Array()
	
	source.append(Vector2(5,5))
	source.append(Vector2(0,0))
	source.append(Vector2(1,6))
	
	next = source
	
	# updates the viewport
	update()
	
# Square matrix
func square():
	source = PoolVector2Array()
	
	source.append(Vector2(0,0))
	source.append(Vector2(0,2))
	source.append(Vector2(2,2))
	source.append(Vector2(2,0))
	
	next = source
	update()

# Bear coordinates
func bear():
	source = PoolVector2Array()
	
	source.append(Vector2(1,2.25))
	source.append(Vector2(1.25,2.25))
	source.append(Vector2(1.75,2.75))
	source.append(Vector2(1.5,1.25))
	source.append(Vector2(1.75,1))
	source.append(Vector2(2.25,2))
	source.append(Vector2(2.75,1))
	source.append(Vector2(3,1.25))
	source.append(Vector2(2.75,2.75))
	source.append(Vector2(3.25,2.25))
	source.append(Vector2(3.5,2.25))
	source.append(Vector2(3.5,2.5))
	source.append(Vector2(2.75,3.5))
	source.append(Vector2(3,3.75))
	source.append(Vector2(3,4.25))
	source.append(Vector2(3.25,4.5))
	source.append(Vector2(3.25,4.75))
	source.append(Vector2(3,5))
	source.append(Vector2(2.75,5))
	source.append(Vector2(2.5,4.75))
	source.append(Vector2(2,4.75))
	source.append(Vector2(1.75,5))
	source.append(Vector2(1.5,5))
	source.append(Vector2(1.25,4.75))
	source.append(Vector2(1.25,4.5))
	source.append(Vector2(1.5,4.25))
	source.append(Vector2(1.5,3.75))
	source.append(Vector2(1.75,3.5))
	source.append(Vector2(1,2.5))
	
	next = source
	update()
	
func change_translation_x(value: float):
	# Range from -50 to 50
	trans_x = (value - 50) / 10
	transform()

func change_translation_y(value: float):
	trans_y = (50 - value) / 10
	transform()
	
func rotate(value: float):
	rot = value
	transform()
	
func change_scale_x(value: float):
	scale_x = value
	transform()

func change_scale_y(value: float):
	scale_y = value
	transform()
	
func change_shear_x(value: float):
	shear_x = value
	transform()
	
func change_shear_y(value: float):
	shear_y = -value
	transform()

# Applies transformations
func transform():
	for i in range(len(source)):
		source[i] = next[i]
		
		var new = Vector2()
		# Set scale
		new.x = next[i].x * scale_x
		new.y = next[i].y * scale_y
		
		var new2 = Vector2()
		
		# Set shear
		new2.x = new.x + new.y * shear_x
		new2.y = -new.y + new.x * shear_y
		
		# Set rotation
		source[i].x = new2.x * cos(rot * PI / 180) - new2.y * sin(rot * PI / 180)
		source[i].y = new2.x * sin(rot * PI / 180) + new2.y * cos(rot * PI/180)
		
		# Set translation
		source[i] = source[i] + Vector2(trans_x, trans_y)
	update()

func draw_image():
	var points_arc = PoolVector2Array()
	
	# Change center 
	for i in range(len(source)):
		i -= 1
		points_arc.push_back(center + source[i]*50)
	
	# Connects all coordinates
	for index_point in range(len(source)):
		index_point -= 1
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
func _draw():
	transform()
	draw_image()

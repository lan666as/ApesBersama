
extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var source = PoolVector3Array()
var next = PoolVector3Array()
var uvs = PoolVector2Array()

var mesh : MeshInstance

var trans_x: float = 0
var trans_y: float = 0
var trans_z: float = 0

var rot_x: float
var rot_y: float
var rot_z: float

var scale_x: float = 1
var scale_y: float = 1
var scale_z: float = 1

var shear_x: float = 0
var shear_y: float = 0
var shear_z: float = 0

var mat = SpatialMaterial.new()
var color = Color(0.9, 0.1, 0.1)


# Called when the node enters the scene tree for the first time.
func _ready():
	source = PoolVector3Array()
	
	source.push_back(Vector3(1,0,0))
	source.push_back(Vector3(1,0,1))
	source.push_back(Vector3(0,0,1))
	source.push_back(Vector3(0,0,0))
	
#	source.push_back(Vector3(1,1,0))
#	source.push_back(Vector3(1,1,1))
#	source.push_back(Vector3(0,1,1))
#	source.push_back(Vector3(0,1,0))


	uvs.push_back(Vector2(0,0))
	uvs.push_back(Vector2(0,1))
	uvs.push_back(Vector2(1,1))
	uvs.push_back(Vector2(1,0))
	
#	uvs.push_back(Vector2(0,0))
#	uvs.push_back(Vector2(0,0))
#	uvs.push_back(Vector2(0,0))
#	uvs.push_back(Vector2(0,0))
	
#	uvs.push_back(Vector2(1,0))
#	uvs.push_back(Vector2(1,1))
#	uvs.push_back(Vector2(0,1))
#	uvs.push_back(Vector2(0,0))
	

	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = next
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_FAN, arrays)
	
	next = source

	mesh = MeshInstance.new()
	mesh.mesh = arr_mesh
	add_child(mesh)


	transform()
	
	# pass # Replace with function body.

func change_translation_x(value: float):
	# Range from -50 to 50
	trans_x = (value - 50)
	transform()

func change_translation_y(value: float):
	trans_y = (50 - value)
	transform()
	
func change_translation_z(value: float):
	trans_z = (50 - value)
	transform()
	
func rotate_x(value: float):
	rot_x = value
	transform()
	
func rotate_y(value: float):
	rot_y = value
	transform()
	
func rotate_z(value: float):
	rot_z = value
	transform()
	
func change_scale_x(value: float):
	scale_x = value
	transform()

func change_scale_y(value: float):
	scale_y = value
	transform()

func change_scale_z(value: float):
	scale_z = value
	transform()
	
func change_shear_x(value: float):
	shear_x = value
	transform()
	
func change_shear_y(value: float):
	shear_y = value
	transform()
	
func change_shear_z(value: float):
	shear_z = value
	transform()

func update_mesh():
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = next
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_FAN, arrays)
	
	mesh.queue_free()
	mesh = MeshInstance.new()
	mesh.mesh = arr_mesh
	add_child(mesh)
#	pass

func transform():
	for i in range(len(source)):
		next[i] = source[i]
		
		var new = Vector3()
		# Set scale
		new.x = next[i].x * scale_x
		new.y = next[i].y * scale_y
		new.z = next[i].z * scale_z
#
		var new2 = Vector3()
#
#		# Set shear
		new2.x = new.x + new.y * shear_x + new.z * shear_x
		new2.y = new.y + new.x * shear_y + new.z * shear_y
		new2.z = new.z + new.x * shear_z + new.y * shear_z

#Jadikan satubaris
		# Set rotation X axis
		next[i].x = new2.x * cos(rot_z * PI / 180) - new2.y * sin(rot_z * PI/180)
		next[i].y = new2.x * sin(rot_z * PI / 180) + new2.y * cos(rot_z * PI/180)
		next[i].z = new2.z

		# Set rotation Y axis
		next[i].x = new2.x * cos(rot_z * PI / 180) - new2.y * sin(rot_z * PI/180)
		next[i].y = new2.x * sin(rot_z * PI / 180) + new2.y * cos(rot_z * PI/180)
		next[i].z = new2.z
#		# Set rotation Z axis
		next[i].x = new2.x * cos(rot_z * PI / 180) - new2.y * sin(rot_z * PI/180)
		next[i].y = new2.x * sin(rot_z * PI / 180) + new2.y * cos(rot_z * PI/180)
		next[i].z = new2.z
		
		# Set translation
		next[i] = next[i] + Vector3(trans_x, trans_y, trans_z)
	update_mesh()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

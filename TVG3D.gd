extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var source = PoolVector3Array()
var next = PoolVector3Array()

var mesh : MeshInstance

var trans_x: float = -5
var trans_y: float = 10
var trans_z: float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	source = PoolVector3Array()
	source.push_back(Vector3(0, 1, 0))
	source.push_back(Vector3(1, 0, 0))
	source.push_back(Vector3(0, 0, 1))
	# Initialize the ArrayMesh.
	next = source
	
	mesh = MeshInstance.new()
#	mesh.mesh = arr_mesh
	add_child(mesh)

	transform()
	
	# pass # Replace with function body.
	
func update_mesh():
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = next
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	mesh.queue_free()
	mesh = MeshInstance.new()
	mesh.mesh = arr_mesh
	add_child(mesh)
#	pass

func transform():
	for i in range(len(source)):
		source[i] = next[i]
		
		var new = Vector3()
		# Set scale
#		new.x = next[i].x * scale_x
#		new.y = next[i].y * scale_y
#
#		var new2 = Vector2()
#
#		# Set shear
#		new2.x = new.x + new.y * shear_x
#		new2.y = -new.y + new.x * shear_y
#
#		# Set rotation
#		source[i].x = new2.x * cos(rot * PI / 180) - new2.y * sin(rot * PI / 180)
#		source[i].y = new2.x * sin(rot * PI / 180) + new2.y * cos(rot * PI/180)
		
		# Set translation
		next[i] = next[i] + Vector3(trans_x, trans_y, trans_z)
	update_mesh()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

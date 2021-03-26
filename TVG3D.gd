extends Spatial

var source = PoolVector3Array()
var next = PoolVector3Array()
var uvs = PoolVector2Array()

var mesh : MeshInstance

var trans_x: float = 0
var trans_y: float = 0
var trans_z: float = 0

var rot_x: float = 0
var rot_y: float = 0
var rot_z: float = 0

var scale_x: float = 1
var scale_y: float = 1
var scale_z: float = 1

var shear_x: float = 0
var shear_y: float = 0
var shear_z: float = 0

var mat = SpatialMaterial.new()
var color = Color(0.9, 0.1, 0.1)

var normals = PoolVector3Array()
var indices = PoolIntArray()

func _ready():
	$Hud/VBoxContainer/GridContainer/TranslationSX_Label.text = str(trans_x)
	$Hud/VBoxContainer/GridContainer/TranslationSY_Label.text = str(trans_y)
	$Hud/VBoxContainer/GridContainer/TranslationSZ_Label.text = str(trans_z)
	
	$Hud/VBoxContainer/GridContainer/RotSX_Label.text = str(rot_x)
	$Hud/VBoxContainer/GridContainer/RotSY_Label.text = str(rot_y)
	$Hud/VBoxContainer/GridContainer/RotSZ_Label.text = str(rot_z)
	
	$Hud/VBoxContainer/GridContainer/ScaleSX_Label.text = str(scale_x)
	$Hud/VBoxContainer/GridContainer/ScaleSY_Label.text = str(scale_y)
	$Hud/VBoxContainer/GridContainer/ScaleSZ_Label.text = str(scale_z)
	
	$Hud/VBoxContainer/GridContainer/ShearSX_Label.text = str(shear_x)
	$Hud/VBoxContainer/GridContainer/ShearSY_Label.text = str(shear_y)
	$Hud/VBoxContainer/GridContainer/ShearSZ_Label.text = str(shear_z)
	
	mesh = $MeshInstance
	mesh.use_in_baked_light = true
	var arr_mesh = ArrayMesh.new()
	var mesh_arrays = []
	mesh_arrays.resize(ArrayMesh.ARRAY_MAX)
	make_cube(0,0,0)
	mesh_arrays[Mesh.ARRAY_VERTEX] = source
	mesh_arrays[Mesh.ARRAY_NORMAL] = normals
	mesh_arrays[Mesh.ARRAY_INDEX] = indices
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_arrays)
	mesh.mesh = arr_mesh
	next = source
	add_child(mesh)
	
	
	
func make_cube(x,y,z):
	#left
	make_quad(Vector3(x,y,z), Vector3(x,y+1,z), Vector3(x,y+1,z+1), Vector3(x,y,z+1))
	#right
	make_quad(Vector3(x+1,y,z+1), Vector3(x+1,y+1,z+1), Vector3(x+1,y+1,z), Vector3(x+1,y,z))
	#down
	make_quad(Vector3(x+1,y,z), Vector3(x,y,z), Vector3(x,y,z+1), Vector3(x+1,y,z+1))
	#up
	make_quad(Vector3(x+1,y+1,z+1), Vector3(x,y+1,z+1), Vector3(x,y+1,z), Vector3(x+1,y+1,z))
	#back
	make_quad(Vector3(x+1,y,z), Vector3(x+1,y+1,z), Vector3(x,y+1,z), Vector3(x,y,z))
	#front
	make_quad(Vector3(x,y,z+1), Vector3(x,y+1,z+1), Vector3(x+1,y+1,z+1), Vector3(x+1,y,z+1))

func make_quad(a,b,c,d):
	var length = len(source)
	indices.append_array([length, length+1, length+2, length, length+2, length+3])
	source.append_array([a,b,c,d])
	normals.append_array([a.normalized(),b.normalized(),c.normalized(),d.normalized()])

func change_translation_x(value: float):
	trans_x = (value)
	$Hud/VBoxContainer/GridContainer/TranslationSX_Label.text = str(trans_x)
	transform()

func change_translation_y(value: float):
	trans_y = (value)
	$Hud/VBoxContainer/GridContainer/TranslationSY_Label.text = str(trans_y)
	transform()
	
func change_translation_z(value: float):
	trans_z = (value)
	$Hud/VBoxContainer/GridContainer/TranslationSZ_Label.text = str(trans_z)
	transform()
	
func rotate_x(value: float):
	rot_x = value
	$Hud/VBoxContainer/GridContainer/RotSX_Label.text = str(rot_x)
	transform()
	
func rotate_y(value: float):
	rot_y = value
	$Hud/VBoxContainer/GridContainer/RotSY_Label.text = str(rot_y)
	transform()
	
func rotate_z(value: float):
	rot_z = value
	$Hud/VBoxContainer/GridContainer/RotSZ_Label.text = str(rot_z)
	transform()
	
func change_scale_x(value: float):
	scale_x = value
	$Hud/VBoxContainer/GridContainer/ScaleSX_Label.text = str(scale_x)
	transform()

func change_scale_y(value: float):
	scale_y = value
	$Hud/VBoxContainer/GridContainer/ScaleSY_Label.text = str(scale_y)
	transform()

func change_scale_z(value: float):
	scale_z = value
	$Hud/VBoxContainer/GridContainer/ScaleSZ_Label.text = str(scale_z)
	transform()
	
func change_shear_x(value: float):
	shear_x = value
	$Hud/VBoxContainer/GridContainer/ShearSX_Label.text = str(shear_x)
	transform()
	
func change_shear_y(value: float):
	shear_y = value
	$Hud/VBoxContainer/GridContainer/ShearSY_Label.text = str(shear_y)
	transform()
	
func change_shear_z(value: float):
	shear_z = value
	$Hud/VBoxContainer/GridContainer/ShearSZ_Label.text = str(shear_z)
	transform()

func update_mesh():
	var arr_mesh = ArrayMesh.new()
	var mesh_arrays = []
	mesh_arrays.resize(ArrayMesh.ARRAY_MAX)
	mesh_arrays[Mesh.ARRAY_VERTEX] = next
	mesh_arrays[Mesh.ARRAY_NORMAL] = normals
	mesh_arrays[Mesh.ARRAY_INDEX] = indices
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_arrays)
	mesh.mesh = arr_mesh
	

func transform():
	for i in range(len(source)):
		next[i] = source[i]
		
		
		# Set scale
		var new = Vector3()
		
		new.x = next[i].x * scale_x
		new.y = next[i].y * scale_y
		new.z = next[i].z * scale_z

		# Set shear
		var new2 = Vector3()
		new2.x = new.x + new.y * shear_x + new.z * shear_x
		new2.y = new.y + new.x * shear_y + new.z * shear_y
		new2.z = new.z + new.x * shear_z + new.y * shear_z

#Jadikan satubaris
		var new3 = Vector3()
		# Set rotation X axis
		new3.x = new2.x
		new3.y = new2.y * cos(rot_x * PI / 180) - new2.z * sin(rot_x * PI / 180)
		new3.z = new2.y * sin(rot_x * PI / 180) + new2.z * cos(rot_x * PI / 180)

		# Set rotation Y axis
		var new4 = Vector3()
		new4.x = new3.x * cos(rot_y * PI / 180) + new3.z * sin(rot_y * PI / 180)
		new4.y = new3.y
		new4.z = new3.x * -sin(rot_y * PI / 180) + new3.z * cos(rot_y * PI / 180)
		
#		# Set rotation Z axis
		next[i].x = new4.x * cos(rot_z * PI / 180) - new4.y * sin(rot_z * PI / 180)
		next[i].y = new4.x * sin(rot_z * PI / 180) + new4.y * cos(rot_z * PI / 180)
		next[i].z = new4.z
		
		# Set translation
		next[i] = next[i] + Vector3(trans_x, trans_y, trans_z)
	update_mesh()

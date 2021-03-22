extends Control

export(NodePath) var DrawingPath
onready var Drawing: Node2D = get_node(DrawingPath)

func _ready():
	pass
	
func _on_TranslationSX_value_changed(value):
	Drawing.change_translation_x(value)

func _on_TranslationSY_value_changed(value):
	Drawing.change_translation_y(value)

func _on_RotS_value_changed(value: float):
	Drawing.rotate(value)

func _on_ScaleSX_value_changed(value: float):
	Drawing.change_scale_x(value)

func _on_ScaleSY_value_changed(value: float):
	Drawing.change_scale_y(value)

func _on_ShearSX_value_changed(value):
	Drawing.change_shear_x(value)

func _on_ShearSY_value_changed(value):
		Drawing.change_shear_y(value)

func _on_Reset_pressed():
	get_tree().reload_current_scene()

func _on_Triangle_pressed():
	Drawing.triangle()

func _on_Square_pressed():
	Drawing.square()
	
func _on_Bear_pressed():
	Drawing.bear()

extends Node2D

@export var translational_velocity: Vector2 = Vector2(0, 0)
@export var translational_velocity_modifier: float = 1000
@export var translational_velocity_deceration_modifier: float = 1.05

@export var zoom_in_max: float = 2
@export var zoom_out_max: float = 0.1
@export var zoom_velocity: float = 0
@export var zoom_velocity_modifier: float = 10
@export var zoom_velocity_deceration_modifier: float = 1.05

@onready var camera = get_child(0)

func _process(delta: float) -> void:
	if Input.is_action_pressed("Up"):
		translational_velocity.y -= translational_velocity_modifier * delta / camera.zoom.x
	if Input.is_action_pressed("Down"):
		translational_velocity.y += translational_velocity_modifier * delta / camera.zoom.x
	if Input.is_action_pressed("Left"):
		translational_velocity.x -= translational_velocity_modifier * delta / camera.zoom.x
	if Input.is_action_pressed("Right"):
		translational_velocity.x += translational_velocity_modifier * delta / camera.zoom.x
	
	if Input.is_action_pressed("In"):
		zoom_velocity += zoom_velocity_modifier * delta * camera.zoom.x
	if Input.is_action_pressed("Out"):
		zoom_velocity -= zoom_velocity_modifier * delta * camera.zoom.x
	
	position += translational_velocity * delta
	translational_velocity /= translational_velocity_deceration_modifier
	
	var next_zoom = camera.zoom + Vector2(1, 1) * zoom_velocity * delta
	if next_zoom.x > zoom_in_max:
		next_zoom = Vector2(1, 1) * zoom_in_max
		zoom_velocity = 0
	elif next_zoom.x < zoom_out_max:
		next_zoom = Vector2(1, 1) * zoom_out_max
		zoom_velocity = 0
	camera.zoom = next_zoom
	zoom_velocity /= zoom_velocity_deceration_modifier
	

func _on_main_menu_button_pressed() -> void:
	get_parent().quit_request()

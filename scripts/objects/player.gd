extends Area2D

signal collect
signal lost
signal pause

@onready var popup_label = preload("res://scenes/HUDs/PopupLabel.tscn")
@onready var animated_sprite = $AnimatedSprite2D

@export var speed: float = 50.0

var viewport_width: float

var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_width = get_viewport_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if direction != 0 && !paused:
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
	else:
		animated_sprite.stop()
	
	position.x += direction * speed * delta 
	position.x = clamp(position.x, 0, viewport_width)
	
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		pause.emit(paused)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('collectable'):
		var current_position := position
		var label_child = popup_label.instantiate()
		add_child(label_child)
		label_child.render_text("+1", current_position)
		collect.emit()
	else:
		lost.emit()
	body.queue_free()
	


func _on_pause_hud_resume() -> void:
	paused = !paused

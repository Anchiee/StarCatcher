extends Area2D

signal collect

@onready var popup_label = preload("res://scenes/HUDs/PopupLabel.tscn")

@export var speed: float = 50.0

var viewport_width: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_width = get_viewport_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if(direction != 0):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		$AnimatedSprite2D.stop()
	
	position.x += direction * speed * delta 
	position.x = clamp(position.x, 0, viewport_width)


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	var current_position := position
	var label_child = popup_label.instantiate()
	add_child(label_child)
	label_child.render_text("+1", current_position)
	
	collect.emit()

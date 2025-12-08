extends Node

@export var collectable: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_collectable_timer_timeout() -> void:
	var item := collectable.instantiate()
	
	var spawn_location = $Path2D/PathFollow2D
	spawn_location.progress_ratio = randf()
	
	item.position = spawn_location.position
	add_child(item)

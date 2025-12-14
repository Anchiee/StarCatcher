extends Node

@export var collectable: PackedScene
@export var xmark: PackedScene

signal score_changed(new_score)
signal lost_game(current_score)

var score: int = 0

var lose_sound: Resource = load("res://assets/sounds/lose.mp3")
var collect_sound: Resource = load("res://assets/sounds/collect.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_collectable_timer_timeout() -> void:
	
	#xmark 10% probability
	var probability := randi_range(0, 100)
	
	print(probability)
	
	var spawn_location := $Path2D/PathFollow2D
	spawn_location.progress_ratio = randf()
	
	var item: Node
	
	if probability > 10:
		item = collectable.instantiate()
		item.lost.connect(on_lose)
	else:
		item = xmark.instantiate()
		
	item.position = spawn_location.position
	
	add_child(item)


func _on_player_collect() -> void:
	score += 1
	score_changed.emit(score)
	play_sound(collect_sound)
	
func on_lose():
	lost_game.emit(score)
	$LoseHUD.show()
	$GameHUD.hide()
	$Player.queue_free()
	$CollectableTimer.stop()
	
	play_sound(lose_sound)


func play_sound(sound: Resource):
	$VFX.stream = sound
	$VFX.play()

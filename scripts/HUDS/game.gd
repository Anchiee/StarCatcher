extends CanvasLayer

@onready var score_label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_game_score_changed(new_score: Variant) -> void:
	score_label.text = "Score: " + str(new_score)

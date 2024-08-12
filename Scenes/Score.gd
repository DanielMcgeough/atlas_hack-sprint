extends Label


var time_out = 1
var time = time_out
var score = 0
func _process(delta: float) -> void:
	if time > 0:
		time -= delta
	else:
		time = time_out
		score += 1
		text = str(score)

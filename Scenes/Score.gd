extends Label


var score = 0
func _on_Timer_timeout() -> void:
	score += 1
	print(score)
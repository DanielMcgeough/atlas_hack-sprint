extends Label



var time_out = 0.1
var time = time_out
var score = 0


func _process(delta: float) -> void:
    if Global.gameover == true:
        return
    if time > 0:
        time -= delta
    else:
        time = time_out
        score += 1
        text = str(score)
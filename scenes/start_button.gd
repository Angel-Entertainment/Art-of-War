extends Button

var start = false
signal start_button_focus_entered

func _ready() -> void:
	grab_focus()
	start = true


func _on_focus_entered() -> void:
	if start:
		start_button_focus_entered.emit()

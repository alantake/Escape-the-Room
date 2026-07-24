extends Area3D

@onready var interaction_label = $InteractionLabel
@onready var main = get_tree().current_scene

var joueur_proche = false


func _ready() -> void:
	interaction_label.visible = false


func _process(_delta: float) -> void:
	if joueur_proche and Input.is_action_just_pressed("interact"):
		ramasser()


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		joueur_proche = true
		interaction_label.visible = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		joueur_proche = false
		interaction_label.visible = false


func ramasser() -> void:
	main.ajouter_cle()
	
	visible = false
	monitoring = false
	monitorable = false
	interaction_label.visible = false

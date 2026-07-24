extends Node3D

var cles = 0
var position_depart_joueur : Vector3
var rotation_depart_porte : Vector3

@onready var compteur_label = $CanvasLayer/Label
@onready var porte_animation = $PortePivot/Porte/AnimationPlayer
@onready var porte_pivot = $PortePivot
@onready var victory_screen = $CanvasLayer/VictoryScreen
@onready var victory_sound = $VictorySound
@onready var player = $Player
@onready var cles_parent = $Cles


func _ready() -> void:
	compteur_label.text = "Clés : 0/3"
	victory_screen.visible = false
	
	position_depart_joueur = player.global_position
	rotation_depart_porte = porte_pivot.rotation
	
	placer_cles_aleatoirement()


func ajouter_cle() -> void:
	cles += 1
	compteur_label.text = "Clés : " + str(cles) + "/3"

	if cles == 3:
		ouvrir_porte()


func ouvrir_porte() -> void:
	porte_animation.play("OPEN")


func _on_exit_zone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		victoire()


func victoire() -> void:
	victory_screen.visible = true
	victory_sound.play()

	await get_tree().create_timer(5.0).timeout

	recommencer_partie()


func recommencer_partie() -> void:
	victory_screen.visible = false
	
	cles = 0
	compteur_label.text = "Clés : 0/3"
	
	player.global_position = position_depart_joueur
	
	porte_pivot.rotation = rotation_depart_porte
	
	for cle in cles_parent.get_children():
		cle.visible = true
		cle.monitoring = true
		cle.monitorable = true
		
		var label = cle.get_node("InteractionLabel")
		label.visible = false
		
	placer_cles_aleatoirement()


func placer_cles_aleatoirement() -> void:
	var random = RandomNumberGenerator.new()
	random.randomize()

	for cle in cles_parent.get_children():
		var x = random.randf_range(-9.0, 9.0)
		var z = random.randf_range(-15.0, 15.0)
		var y = random.randf_range(0.8, 1.2)

		cle.position = Vector3(x, y, z)

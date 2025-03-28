BALQIS A. LUMBUN - 2106751184 - LAB 7
- Mengimplementasikan tutorial sesuai langkah-langkah yang dikerjakan. 
- Sempat terjadi permasalahan akibat lupa menambahkan raycasting
- Mengimplementasikan sprinting dan crouching dengan:
	if Input.is_action_pressed("movement_forward") and Input.is_action_pressed("jump"):
		movement_vector -= 2 * head.basis.z (Sprint)
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z * (0.05 if Input.is_action_pressed("interact") else 1) (Crouch)
		
- Mengimplementasikan inventory (tekstual)
	Player:
	if Input.is_key_pressed(KEY_Y):
		var text_output = "Object Taken: " 
		for word in get_database():
				word = word.to_upper()
				text_output += word + " - "
		text_2d.text = text_output
		text_2d.visible = true
	elif Input.is_key_pressed(KEY_Z):
		text_2d.visible = false
	
	Area3D:
		func _on_body_entered(body: Node3D) -> void:
			if body.get_name() == "Player":
				lamp.visible = false
				body.set_database("lamp")

- Implementasi GUI lihat inventori teks:
	https://www.youtube.com/watch?v=Bp3z-DQHO3k
	
	Membuat Sprite3D dengan SubViewport, Panel, dan Label, yang dikontrol dengan tombol Y dan Z

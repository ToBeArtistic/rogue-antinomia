extends Node

#game
signal start_game
signal pause_game
signal unpause_game
signal toggle_mouse_visibility
signal objective_completed

#levels
signal next_level_selected
signal hub_area_selected

#player
signal player_position_updated(player : Player, position:Vector3)
signal player_died(player : Player)
signal player_interact_status_updated(player : Player, can_interact : bool)
signal player_interact_with(player:Player, object:Object)
signal player_select_equipment(player:Player, type : Enum.EQUIPMENT)
signal on_player_move(player : Player)
signal on_player_stop(player : Player)
signal player_data_updated(player : Player)

#camera
signal active_camera_changed(camera : Camera3D)
signal activate_player_camera(camera : Camera3D)

#enemy
signal enemy_died(enemy : Enemy)

#projectiles
signal create_projectile(data : ProjectileData)


#hud
signal create_damage_number(number:float)
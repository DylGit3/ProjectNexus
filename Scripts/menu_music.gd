extends AudioStreamPlayer

const menu_music_first = preload("res://Assets/Audio/Music/goodVibes.ogg")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_menu():
	_play_music(menu_music_first)

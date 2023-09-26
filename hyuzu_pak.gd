extends Node

@export var song: HyuzuSong = HyuzuSong.new()

var uetools = load("res://hyuzu_uetools.cs")
var uetools_node = uetools.new()

var magic = 0x5A6F12E1
var buf_size = 32 * 1024

var stream = AudioStreamOggVorbis.new()

func _ready():
	song = HyuzuSong.new()
	song._init()
	
	var mogg = FileAccess.open("E:/projects/SJS_AllTheWay_1936158573.mogg", FileAccess.READ)
	var mogg_data = mogg.get_buffer(mogg.get_length())
	
	var offset = mogg_data.decode_u32(0)
	
	print(len(mogg_data.slice(offset, len(mogg_data))))
	stream = AudioStreamOggVorbis.load_from_buffer(mogg_data.slice(offset, len(mogg_data)))
	
	$Audio.stream = stream
	$Audio.play()
	
	_load_pak()
			
func _load_pak():
	uetools_node.load_pak("E:/projects/RockMeAmadeus_Falco_hatoving_P.pak")
	
	var short_name = ""
	var album_art = null
	
	for e in len(uetools_node.paths):
		if short_name == "":
			var pos = uetools_node.paths[e].find("DLC/Songs/")
		
			if pos != -1:
				for si in range(pos + 10, len(uetools_node.paths[e]), 1):
					if (uetools_node.paths[e])[si] == '/':
						break
					short_name += (uetools_node.paths[e])[si]
					
		if album_art == null:
			var pos = uetools_node.paths[e].find("UI/AlbumArt")
		
			if pos != -1:
				if uetools_node.paths[e].substr(len(uetools_node.paths[e]) - 5) == ".uexp":
					pos = uetools_node.paths[e].find("_small")
					
					if pos != -1:
						album_art = ImageTexture.new()
						var img_data = uetools_node.get_entry_data(uetools_node.paths[e])
						
						var img = load_pak_img(img_data)
						album_art.set_image(img)
						
		
		$AlbumArt.texture = album_art
				
	print(short_name)

func load_pak_img(data: PackedByteArray):
	var img = Image.new()
	
	var header = null
	var footer = null
	
	var header_size = 355
	var footer_size = 0x10
	
	var mip_count = 10
	
	var bad_switch_1 = data.decode_u64(0)
	var bad_switch_2 = data.decode_u64(8)
	
	if bad_switch_2 == 5:
		header_size = 329
		mip_count = 9
	
	header = data.slice(16, 16 + header_size)
	var mip_len_1 = data.decode_u32(16 + header_size + 12)
	
	var image_data = data.slice(16 + header_size + 28, 16 + header_size + 28 + mip_len_1)
	
	var width = data.decode_u32(16 + header_size + 28 + mip_len_1)
	var height = data.decode_u32(16 + header_size + 28 + mip_len_1 + 4)
	
	data.clear()
	
	img.set_data(width, height, false, Image.FORMAT_DXT1, image_data)
	return img
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

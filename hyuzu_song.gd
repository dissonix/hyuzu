extends Resource
class_name HyuzuSong

enum SongKeys {
	C = 0,
	Db = 1,
	D = 2,
	Eb = 3,
	E = 4,
	F = 5,
	Gb = 6,
	G = 7,
	Ab = 8,
	A = 9,
	Bb = 10,
	B = 11
}

enum SongMode {
	Major,
	Minor
}

enum SongDiscLength {
	BARS_8,
	BARS_16,
	BARS_32,
	BARS_64
}

enum SongGenre {
	Classical,
	Country,
	Rock,
	Pop,
	RnB,
	HipHop,
	Dance,
	International,
	AlternativeIndie,
	Soundtrack, #used for games, movies, etc.
	Misc
}

enum SongInstrument {
	None,
	Guitar,
	Drums,
	Vocal,
	Synth,
	Sampler,
	Horns,
	Strings
}

enum SongCelType {
	Beat,
	Bass,
	Loop,
	Lead
}

enum SongKeymapPreset {
	Major,
	Minor,
	Shared,
	Custom
}

@export var creator: String = ""
@export var short_name: String = ""

@export var title: String = ""
@export var artist: String = ""

@export var key: SongKeys = SongKeys.C
@export var mode: SongMode = SongMode.Major

@export var year: int = 1999
@export var bpm: int = 90

@export var transposes: Array

func _init():
	if transposes == null:
		for i in range(0, 12):
			var offset = i - int(key)
			
			if offset < -6: offset += 12
			elif offset > 6: offset -= 12
			
			print(offset)
			
			transposes.append(offset)

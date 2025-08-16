extends WorldEnvironment

var seed : float = 0.0
@export var panorama : PanoramaSkyMaterial
@export var noise : NoiseTexture2D
@export var noise_type : FastNoiseLite

func _ready() -> void:
	noise.noise = noise_type
	panorama.panorama = noise
	environment.sky.sky_material = panorama

func _process(delta: float) -> void:
	seed += delta*0.1
	noise_type.seed = seed

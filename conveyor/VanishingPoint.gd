extends Position2D


export var num_lines = 1 setget set_num_lines
var lines = []

export var a = 1
export var b = 1

export var speed = 1.0

var t = 0

export var width = 3 setget set_width
export(Color) var color setget set_color


func set_width(value):
    width = value
    for line in lines:
        line.width = width


func set_color(value):
    color = value
    for line in lines:
        line.default_color = color


func set_num_lines(value):
    num_lines = value
    init_lines()
    
    
func init_lines():
    for line in lines:
        line.queue_free()
    lines = []
    for i in range(num_lines):
        var line = Line2D.new()
        line.add_point(Vector2.ZERO)
        line.add_point(Vector2.ZERO)
        line.width = width
        line.default_color = color
        add_child(line)
        lines.append(line)


func _ready():
    init_lines()


func _process(delta):
    t = fmod((t + delta * speed), (2*PI))

    var i = 0
    for line in lines:
        var phase_shift = i * (2 * PI / num_lines)
        var t_ = t + phase_shift
        var u = tan(t_/2)
        var x = a * (1 - pow(u, 2)) / (pow(u, 2) + 1)
        var y = (2 * b * u) / (pow(u, 2) + 1)
    
        line.set_point_position(1, Vector2(x, y))
        i += 1

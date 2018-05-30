
class NXUIColor {

    private var _color: SDL_Color

    var r: UInt8 {
        return _color.r
    }

    var g: UInt8 {
        return _color.g
    }

    var b: UInt8 {
        return _color.b
    }

    var a: UInt8 {
        return _color.a
    }

    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self._color = SDL_Color(r: r, g: g, b: b, a: a)
    }

}

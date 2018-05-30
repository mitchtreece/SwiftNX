
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

    static var white: NXUIColor {
        return NXUIColor(r: 255, g: 255, b: 255, a: 255)
    }

    static var black: NXUIColor {
        return NXUIColor(r: 0, g: 0, b: 0, a: 255)
    }

    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self._color = SDL_Color(r: r, g: g, b: b, a: a)
    }

    func withAlphaComponent(_ alpha: UInt8) -> NXUIColor {
        return NXUIColor(r: r, g: g, b: b, a: alpha)
    }

}

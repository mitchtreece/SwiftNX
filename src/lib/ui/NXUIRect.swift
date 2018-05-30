
class NXUIRect {

    // TODO: Equatable?

    private(set) var _rect: SDL_Rect

    var x: Int32 {
        return _rect.x
    }

    var y: Int32 {
        return _rect.y
    }

    var width: Int32 {
        return _rect.w
    }

    var height: Int32 {
        return _rect.h
    }

    static var zero: NXUIRect {
        return NXUIRect(x: 0, y: 0, width: 0, height: 0)
    }

    init(x: Int32, y: Int32, width: Int32, height: Int32) {
        self._rect = SDL_Rect(x: x, y: y, w: width, h: height)
    }

    var isEmpty: Bool {
        return (width <= 0 || height <= 0)
    }

    func contains(point: NXUIPoint) -> Bool {
        return (point.x >= x && (point.x < (x + width))) && (point.y >= y && (point.y < (y + height)))
    }

}

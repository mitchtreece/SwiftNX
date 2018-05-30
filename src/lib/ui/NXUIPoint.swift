
class NXUIPoint {

    private var _point: SDL_Point

    var x: Int32 {
        return _point.x
    }

    var y: Int32 {
        return _point.y
    }

    init(x: Int32, y: Int32) {
        self._point = SDL_Point(x: x, y: y)
    }

}

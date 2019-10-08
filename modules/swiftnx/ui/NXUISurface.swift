
class NSUISurface {

    private var _surface: SDL_Surface

    init(surface: SDL_Surface) {
        self._surface = surface
    }

    func free() {
        SDL_FreeSurface(_surface)
    }

}

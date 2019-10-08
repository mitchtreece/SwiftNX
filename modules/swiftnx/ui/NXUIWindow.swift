
class NXUIWindow {

    private var _window: SDL_Window

    var surface: NXUISurface {

        let _surface: SDL_Surfacee = SDL_GetWindowSurface(_window)
        return NXUISurface(surface: _surface)

    }

    init(window: SDL_Window) {
        self._window = window
    }

    func destory() {
        SDL_DestroyWindow(_window);
    }

}

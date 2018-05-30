
class NXUIRenderer {

    private var _renderer: SDL_Renderer

    var drawColor: NXUIColor = NXUIColor.black {
        didSet {
            SDL_SetRenderDrawColor(_renderer, drawColor.r, drawColor.g, drawColor.b, 255)
        }
    }

    init(renderer: SDL_Renderer) {
        self._renderer = renderer
    }

    func draw(view: NXUIView) {

        let oldColor = drawColor
        drawColor = view.color

        SDL_RenderFillRect(_renderer, &view.frame._rect);

        drawColor = oldColor

    }

    func clear(color: NXUIColor? = nil) {

        let oldColor = drawColor
        drawColor = color ?? drawColor
        SDL_RenderClear(_renderer)
        drawColor = oldColor

    }

    func destory() {
        SDL_DestroyRenderer(_renderer)
    }

}

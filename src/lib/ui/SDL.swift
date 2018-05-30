
class SDL {

    static func start() {

        SDL_Init(SDL_INIT_EVERYTHING)
        // SDL_SetRenderDrawBlendMode(SDL_RENDERER, SDL_BLENDMODE_BLEND);
        // SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");

    }

    static func createWindowAndRenderer(width: Int32, height: Int32) -> (window: SDL_Window, renderer: SDL_Renderer) {

        var window: SDL_Window
        var renderer: SDL_Renderer

        SDL_CreateWindowAndRenderer(width, height, 0, &window, &renderer)

        return (window, renderer)

    }

    // void SDL_DrawText(TTF_Font *font, int x, int y, SDL_Color color, char *text) {
    //
    // 	SDL_Surface *surface = TTF_RenderText_Blended_Wrapped(font, text, color, 1280);
    // 	SDL_SetSurfaceAlphaMod(surface, 255);
    // 	SDL_Rect position = {x, y, surface->w, surface->h};
    // 	SDL_BlitSurface(surface, NULL, SDL_WINDOW_SURFACE, &position);
    // 	SDL_FreeSurface(surface);
    //
    // }
    //
    // void SDL_LoadImage(SDL_Renderer* renderer, SDL_Texture **texture, char *path) {
    //
    // 	SDL_Surface *loaded_surface = NULL;
    // 	loaded_surface = IMG_Load(path);
    // 	*texture = SDL_CreateTextureFromSurface(renderer, loaded_surface);
    // 	SDL_FreeSurface(loaded_surface);
    //
    // }
    //
    // void SDL_DrawImage(SDL_Renderer* renderer, SDL_Texture *texture, int x, int y, int w, int h) {
    //
    // 	SDL_Rect rect;
    // 	rect.x = x; rect.y = y; rect.w = w; rect.h = h;
    // 	SDL_RenderCopy(renderer, texture, NULL, &rect);
    //
    // }

    static func quit() {
        SDL_Quit()
    }

}

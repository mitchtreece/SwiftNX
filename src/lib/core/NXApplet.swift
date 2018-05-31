
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: NXApplet.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

class NXApplet {

    static var current = NXApplet()

    // private(set) var renderer: NXUIRenderer
    // private(set) var window: NXUIWindow
    // private(set) var surface: NXUISurface

    private init() {

        // SDL.start()
        //
        // let out = SDL.createWindowAndRenderer(width: 1280, height: 720)
        // self.window = NXUIWindow(window: out.window)
        // self.renderer = NXUIRenderer(renderer: out.renderer)
        // self.surface = self.window.surface

    }

    func mainLoop(_ loop: ()->()) {

        while(appletMainLoop()) {
            loop()
        }

    }

    func exit(_ code: Int) -> Int {

        // SDL

        // renderer.destory()
        // surface.free()
        // window.destory()
        // SDL.quit()

        // Return code

        return code

    }

}

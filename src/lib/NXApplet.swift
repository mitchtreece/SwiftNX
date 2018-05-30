
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

    // private(set) var window: NXUIWindow
    // NXUISurface?
    // NXUIRenderer?

    private init() {
        SDL.init()
    }

    func main(_ loop: ()->()) {

        while(appletMainLoop()) {
            loop()
        }

    }

}

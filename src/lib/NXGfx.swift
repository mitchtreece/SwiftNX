
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: NXGfx.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

class NXGfx {

    init() {
        gfxInitDefault()
    }

    func _flush() {
        gfxFlushBuffers()
    }

    func _swap() {
        gfxSwapBuffers()
    }

    func _waitForVsync() {
        gfxWaitForVsync()
    }

    func clean() {

        _flush()
        _swap()
        _waitForVsync()

    }

    func exit(_ code: Int) -> Int {

        gfxExit()
        return code

    }

}

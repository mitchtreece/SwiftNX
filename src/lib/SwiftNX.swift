
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: SwiftNX.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

// TODO: Fix include.py paths so they're relative to the current include file's path
// i.e. "NXApplet.swift" from this directory should resolve to: ../path/to/project/src/lib/NXApplet.swift"

// MARK: Core

include "lib/core/NXApplet.swift"
include "lib/core/NXConsole.swift"
include "lib/core/NXGfx.swift"
// include "lib/core/NXInput.swift"

// MARK: SDL

// include "lib/sdl/SDL.swift"

// MARK: UI

// include "lib/ui/NXUIRenderer.swift"
// include "lib/ui/NXUIWindow.swift"
// include "lib/ui/NXUISurface.swift"
// include "lib/ui/NXUIView.swift"
//
// include "lib/ui/NXUIPoint.swift"
// include "lib/ui/NXUIRect.swift"
// include "lib/ui/NXUIColor.swift"

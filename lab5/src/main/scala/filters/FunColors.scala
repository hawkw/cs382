package filters

import processing.core._
import PConstants._
import PApplet._

/**
 * Mixin trait for `PApplet`s that provides a better functional color API.
 * @author Hawk Weisman
 */
trait FunColors
extends PApplet {

  implicit class Color(val c: Int) {
    def red: Int
      = red c
    def blue: Int
      = blue c
    def green: Int
      = green c

    def red_=(r: Int): Color
      = color(r, blue, green)

    def green_=(g: Int): Color
      = color(red, blue, g)

    def blue_=(b: Int): Color
      = color(red, b, green)
  }

}

package filters

import processing.core._
import PConstants._
import PApplet._

/**
 * Mixin trait for `PApplet`s that provides a Scala idiomatic color API.
 *
 * The [[FunColors]] API is both more functional and more fun to use,
 * thus the name. :)
 *
 * Unfortunately, it is necessary to set the color mode quite frequently within
 * the [[FunColors]] API, which may cause some minor performance issues. This
 * is because we cannot guarantee that Processing is in the correct color mode.
 * It might be possible to figure out a more efficient way to do this if we can
 * find a way to guarantee that Processing is in a particular color mode
 * prior to using this API.
 *
 * @author Hawk Weisman
 */
trait FunColors
extends PApplet {

  implicit class Color(val c: Int) {
    def red: Int
      = red c

    def green: Int
      = green c

    def blue: Int
      = blue c

    def red_=(r: Int): Color
      = { colorMode(RGB)
          color(r, blue, green)
        }

    def green_=(g: Int): Color
      = { colorMode(RGB)
          color(red, g, blue)
        }

    def blue_=(b: Int): Color
      = { colorMode(RGB)
          color(red, green, b)
        }

    def red_+=(r: Int): Color
      = { colorMode(RGB)
          color(red + r, blue, green)
        }

    def green_+=(g: Int): Color
      = { colorMode(RGB)
          color(red, green + g, blue)
        }

    def blue_+=(b: Int): Color
      = { colorMode(RGB)
          color(red, green, blue + b)
        }

    def red_-=(r: Int): Color
      = { colorMode(RGB)
          color(red - r, blue, green)
        }

    def green_-=(g: Int): Color
      = { colorMode(RGB)
          color(red, green - g, blue)
        }

    def blue_-=(b: Int): Color
      = { colorMode(RGB)
          color(red, green, blue - b)
        }
  }

}

trait FunRGBColors
extends FunColors {

  object Color {
    def unapply(c: Color): Option[(Int, Int, Int)]
      = Some((c.red, c.blue, c.green))

    def apply(red: Int, blue: Int, green: Int): Color
      = { colorMode(RGB)
          color(red, green, blue)
        }
  }
}

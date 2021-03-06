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
    // -- RGB accessors ------------
    def red: Float
      = FunColors.this.red(c)

    def green: Float
      = FunColors.this.green(c)

    def blue: Float
      = FunColors.this.blue(c)

    // -- HSV accessors ------------
    def hue: Float
      = FunColors.this.hue(c)

    def saturation: Float
      = FunColors.this.saturation(c)

    def value: Float
      = FunColors.this.brightness(c)

    // -- RGB mutators -------------
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
    def unapply(c: Color): Option[(Float,Float,Float)]
      = Some((c.red, c.blue, c.green))

    def apply(red: Float, blue: Float, green: Float): Color
      = { colorMode(RGB)
          color(red, green, blue)
        }
  }
}

trait FunHSVColors
extends FunColors {

  object Color {
    def unapply(c: Color): Option[(Float,Float,Float)]
      = Some((c.hue, c.saturation, c.value))

    def apply(h: Int, s: Int, v: Int): Color
      = { colorMode(HSB)
          color(h, s, v)
        }
  }
}

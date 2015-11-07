package filters

import scala.language.postfixOps

trait ImageProcessing
extends FunColors {

  type Image = Array[Array[Color]]

  implicit class PixelsToImage(val ps: Array[Color]) {
    def toImage: Image
      = { val result = Array.ofDim[Color]()

      }
  }

  implicit class Partitionable(val x: Image) {
    def partition(h: Int, w: Int): Array[Image]
      = (0 until x.length - h) map { q ⇒
          (q until q + h) map { i ⇒
            x(i) slice (q, w)
          } toArray
        } toArray
  }

}

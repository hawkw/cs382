package filters

import scala.language.postfixOps

trait ImageProcessing {

  type Pixel = Int
  type Image = Array[Array[Pixel]]

  implicit class PixelsToImage(val ps: Array[Pixel]) {
    def toImage: Image
      = ???
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

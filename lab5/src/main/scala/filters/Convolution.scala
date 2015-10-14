package filters

import processing.core._
import PApplet._

import scala.language.postfixOps

trait Convolution
  extends ImageProcessing
  with FunColors {

  type Weights = Array[Array[Float]]

  implicit class ArrayWithZip2DIndex[A](val xs: Array[Array[A]]) {

    def zipWith2DIndex: Array[Array[(A, Int, Int)]]
    = for {(row, i) ← xs.zipWithIndex
           j ← row indices}
      yield row map {
        (_, i, j)
      }

  }

  def convolution(matrix: Weights)(i: Image): Image
  = {
    val offset = floor(matrix.length / 2)

    val convolute: (Pixel, Int, Int) ⇒ Pixel
    = ???

    i.zipWith2DIndex
      .map {
        _ map (convolute tupled)
      }

  }

}

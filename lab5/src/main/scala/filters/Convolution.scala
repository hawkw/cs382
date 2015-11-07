package filters

import processing.core._
import PApplet._

import scala.language.postfixOps

trait Convolution
extends PApplet
  with ImageProcessing
  with FunRGBColors {

  type Weights = Array[Array[Float]]

  implicit class ArrayWithZip2DIndex[A](val xs: Array[Array[A]]) {

    def zipWith2DIndex: Array[Array[(A, Int, Int)]]
      = for { (row, i) ← xs.zipWithIndex
              j ← row indices }
        yield row map { (_, i, j) }

  }

  def laplacianEdgeDetection(i: Image)
    = convolution(Array( Array( 0f, -1f,  0f)
                       , Array(-1f,  4f, -1f)
                       , Array( 0f, -1f,  0f)
                       )
                  )(i)

  def convolution(matrix: Weights)(i: Image): Image
    = { val offset = floor(matrix.length / 2)
        def convolute(p: Color, px: Int, py: Int): Color
          = matrix.zipWith2DIndex
                  .map { _ map { case (weight, nx, ny) =>
                    val p_prime =
                      i(constrain(px + nx - offset, 0, i.length - 1))(constrain(py + ny - offset, 0, i(0).length - 1))

                    Color( p_prime.red * weight
                         , p_prime.green * weight
                         , p_prime.blue  * weight
                         )
                   }
                 }.flatten
                  .fold(Color(0)){ case (acc: Color, p: Color) =>
                    Color(acc.red + p.red, acc.green + p.green, acc.blue + p.blue)}

        i.zipWith2DIndex
         .map { _ map { case (p, px, py) => convolute(p, px, py) } }
       }

}

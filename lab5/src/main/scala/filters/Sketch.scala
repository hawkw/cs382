package filters;

import processing.core._
import PConstants._
import PApplet._

class Sketch
extends PApplet
  with Convolution {

  override def setup() {
    size(200,200)
    val pwd = System.getProperty("user.dir")
    println(pwd)
    println(s"$pwd/data/lennon.jpg")
    val img = loadImage(s"$pwd/data/lennon.jpg")

    for { i <- 0 to height by 100
          j <- 0 to width by 100
        } { image(img, i, j) }

    loadPixels()

    val a = Array.ofDim[Color](height,width)
    for { i <- a.indices
          j <- a(i).indices
        } {
          a(i)(j) = pixels((i * 3) + j)
        }

    var imgs = a.partition(100,100)
    imgs(0) = laplacianEdgeDetection(imgs(0))
    imgs(1) = imgs(1).map { _ map { p: Color => Color(p.red, 0, 0)}}
    imgs.map(_ flatten)
        .flatten
        .zipWithIndex
        .takeWhile { case (_, i) => i < height * width }
        .foreach   { case (p, i) => pixels(i) = p.c }
    updatePixels()
  }

}

object Sketch
extends App {
  PApplet.main(Array("filters.Sketch"))
}

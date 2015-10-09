package filters;

import processing.core.color

trait Convolution {

  type Pixel = Int
  type Image = Array[Array[Pixel]]
  type Weights = Array[Array[Float]]

  def convolution(w: Weights)(i: Image): Image
    = ???

}

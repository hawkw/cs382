package filters;

trait Convolution
extends ImageProcessing {

  type Weights = Array[Array[Float]]

  def convolution(w: Weights)(i: Image): Image
    = ???

}

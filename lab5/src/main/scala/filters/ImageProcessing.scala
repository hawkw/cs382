package filters

trait ImageProcessing {

  type Pixel = Int
  type Image = Array[Array[Pixel]]

  implicit class PixelsToImage(val ps: Array[Pixels]) {
    def toImage: Image
      = ???
  }

  implicit class Partition(val i: Image) {
    def partition(x: Int, y: Int): Array[Image]
      = ??
  }

}

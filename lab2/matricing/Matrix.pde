import java.util.Arrays;
import java.util.stream.IntStream;

/**
 * Takes the dot product of two vectors (represented as arrays).
 * The vectors must have the same size.
 */
private static float dot_vec(float[] a, float[] b) {
  assert a.length == b.length: 
    "vectors must be of equal length to compute dot product";
  return (float) IntStream.range(0, a.length)
                          .mapToDouble(i -> a[i] * b[i])
                          .sum();
}

class Matrix {
  // let m = our matrix
  final float[][] m;
  
  /**
   * Constructs a new matrix with the given dimensions.
   * The matrix is initially filled with zeroes.
   */
  Matrix(int xdim, int ydim) { m = new float[xdim][ydim]; }
  /**
   * Create a new matrix from a 2D array.
   */
  Matrix(float[][] m) { this.m = m; }
  
  int rows() { return m.length;    }
  
  int cols() { return m[0].length; }
  
  /**
   * Test if this matrix is the same size as another matrix.
   */
  boolean is_same_size_as (Matrix that) {
    return that.rows() == this.rows() &&
           that.cols() == this.cols();
  }
  
  /**
   * Adds this matrix to another matrix.
   * (assuming they have the same dimensions)
   */
  Matrix add(Matrix that) {
    assert this.is_same_size_as(that): 
      "matrices to add must be the same length";
    return new Matrix(
      // "Don't be to proud of this functional terror you've 
      //  constructed. The power to map over a `Stream` is 
      //  insiginificant next to the power of the `for`s."
      //     – Not Darth Vader
      IntStream.range(0, rows())
               .mapToObj(i -> 
                  IntStream.range(0, cols())
                           .mapToDouble(j -> this.m[i][j] + that.m[i][j])
                           .toArray())
               .toArray(float[][]::new)
     );
   }
  /**
   * Multiply this matrix by another matrix.
   * (assuming they have the same dimensions)
   */
   Matrix multiply(Matrix that) {
     assert this.is_same_size_as(that):
       "matrices to multiply must be the same length";
     return new Matrix(
       IntStream.range(0, rows())
                .mapToObj(i ->
                  IntStream.range(0, cols())
                           .mapToDouble(j -> dot_vec(this.m[i], that.m[j]))
                           .toArray())
               .toArray(float[][]::new)
     );
   }
  
  String toString() { return m.toString(); }
  
}
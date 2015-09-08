import java.util.Arrays;
import java.util.stream.IntStream;
/**
 * THIS REQUIRES JAVA 8
 */
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
  boolean isSameSizeAs (Matrix that) {
    return that.rows() == this.rows() &&
           that.cols() == this.cols();
  }
  
  /**
   * Adds this matrix to another matrix.
   * (assuming they have the same dimensions)
   */
  Matrix add(Matrix that) {
    assert(this.isSameSizeAs(that));
    return new Matrix(
      // "Don't be to proud of this functional terror you've 
      //  constructed. The power to map over a `Stream` is 
      //  insiginificant next to the power of the `for`s."
      //     – Not Darth Vader
      IntStream.range(0, rows())
               .mapToObj(i -> 
                  IntStream.range(0, cols())
                           .mapToObj(j -> this.m[i][j] + that.m[i][j])
                           .toArray(Float[]::new))
               .toArray(float[][]::new)
     );
   }
  
  String toString() { return m.toString(); }
  
}
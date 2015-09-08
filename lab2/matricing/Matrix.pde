import java.util.Arrays;
import java.util.stream.IntStream;

class Matrix {
  // let m = our matrix
  float[][] m;
  
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
  
  boolean isSameSizeAs (Matrix that) {
    return that.rows() == this.rows() &&
           that.cols() == this.cols();
  }
  
  Matrix add(Matrix that) {
    assert(this.isSameSizeAs(that));
    float[][] m_prime = new float[rows()][cols()];
    // I hate that I have to do it this way; Java would
    // not permit me to zip the two matrices together & then
    // map sum over them....
    for (int i = 0; i <= rows(); i++) {
      for (int j = 0; j <= cols(); j++) {
        m_prime[i][j] = this.m[i][j] + that.m[i][j];
      }
    }
    return new Matrix(m_prime); // ugh
  }
  
  String toString() { return m.toString(); }
  
}
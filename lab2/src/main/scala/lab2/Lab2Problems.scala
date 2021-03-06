package lab2

import me.hawkweisman.math.{ Linear
                           , SequentialAlgebra
                           , SurfaceNormals
                           }

object Lab2Problems
extends SequentialAlgebra
  with SurfaceNormals {

  implicit class PrettyVector[N](v: Vector[N]) {
    lazy val prettyPrint: String
      = "[" + (v mkString ", ") + "]"
  }

  implicit class PrettyMatrix[N](m: Matrix[N]) {
    lazy val prettyPrint: String
      = "[" + (m.map{v: Vector[N] => v.prettyPrint} mkString ", ") + "]"
  }

  def printHeader(problem: String)
    = println(s"\n$problem " + ("-" * (77 - problem.length)))

  def problem1() {
    printHeader("Problem 1:")
    val v = Array[Double](12, 17, -3)
    val u = Array[Double](-6, 1.2, -1)
    println(s"${v.prettyPrint} + ${u.prettyPrint} = ${(u + v).prettyPrint}" )
    println("-" * 78)
  }

  def problem2() {
    printHeader("Problem 2:")
    val v = Array[Double](8, -7, -3)
    val u = Array[Double](0, 2, -1)
    val answer = 5d *^ (v - u)
    println(s"5(${v.prettyPrint} - ${u.prettyPrint} = ${answer.prettyPrint}" )
    println("-" * 78)
  }

  def problem4() {
    printHeader("Problem 4:")
    val v = Array[Double](-7, 5, 3, 1)
    println(s"||v|| = sqrt(${v.prettyPrint} • ${v.prettyPrint}) = ${v.magnitude}")
    println("-" * 78)
  }

  def problem5() {
    printHeader("Problem 5:")
    val u = Array[Double](12, 17, -3)
    val v = Array[Double](-6, 1.2, -1)
    println(s"Angle between ${u.prettyPrint} and ${v.prettyPrint} = ${u angleTo v}°")
    println("-" * 78)
  }

  def problem6() {
    printHeader("Problem 6:")
    val u = Array[Double](12, 17,  -3)
    val v = Array[Double](-6, 1.2, -1)
    println(s"${u.prettyPrint} x ${v.prettyPrint} = ${u * v}")
    println("-" * 78)
  }


  def problem7() {
    printHeader("Problem 7:")

    val p1 = Array[Double](1, 0, 0)
    val p2 = Array[Double](0, 1, 0)
    val p3 = Array[Double](0, 0, 1)

    println(s"The surface normal for the face including ${p1.prettyPrint}, ${p2.prettyPrint} and\n ${p3.prettyPrint} is ${surfaceNormal(p1,p2,p3) prettyPrint}")
    println("-" * 78)
  }

  def problem8() {
    printHeader("Problem 8:")
    val m = Array[Array[Double]](
        Array[Double](5, 7)
      , Array[Double](1, -8)
    )
    val v = Array[Double](3, 2)
    println(s"${m.prettyPrint} x ${v.prettyPrint} = ${(m * v).prettyPrint}")
    println("-" * 78)
  }


  def problem9() {
    printHeader("Problem 9:")
    val m = Array[Array[Double]](
        Array[Double](3, 5, 2)
      , Array[Double](2, 1, -4)
    )
    val n = Array[Array[Double]](
        Array[Double](2,6)
      , Array[Double](4, 3)
    )
    println(s"${m.prettyPrint} x ${n.prettyPrint} = ${(m * n).prettyPrint}")
    println("-" * 78)
  }

  def problem10() {
    printHeader("Problem 10:")
    val m = Array[Array[Double]](
        Array[Double](1, 3)
      , Array[Double](5, 7)
      , Array[Double](9, 12)
    )
    val n = Array[Array[Double]](
        Array[Double](12, 10, 8)
      , Array[Double](6, 4, 2)
    )

    println(s"${m.prettyPrint} x ${n.prettyPrint}\n\t= ${(m * n).prettyPrint}")
    println("-" * 78)
  }


  def main(args: Array[String]) {
    println("Hawk Weisman\nCMPSC382 Lab 2\n")

    problem1()
    problem2()
    printHeader("Problem 3:")
    // I did this one manually 'cause I was too lazy to figure out a
    // general algerizm for expressing a vector in terms of basis vectors
    println("Please see assignment sheet.")
    println("-" * 78)
    problem4()
    problem5()
    problem6()
    problem7()
    problem8()
    problem10()
  }

}

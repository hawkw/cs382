package lab2

import me.hawkweisman.math.{ Linear, SequentialAlgebra }

object Lab2Problems
extends SequentialAlgebra {

  implicit class PrettyVector[N](v: Vector[N]) {
    lazy val prettyPrint: String
      = "[" + (v mkString ", ") + "]"
  }

  implicit class PrettyMatrix[N](m: Matrix[N]) {
    lazy val prettyPrint: String
      = "[" + (m.map{v: Vector[N] => v.prettyPrint} mkString ", ") + "]"
  }

  def printHeader(problem: String)
    = println(s"$problem " + ("-" * (77 - problem.length)))

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

  def problem8() {
    printHeader("Problem 8:")
    val m = Array[Array[Double]](
        Array[Double](5, 7)
      , Array[Double](1, -8)
    )
    val v = Array[Double](3, 2)
    println(s"${m.prettyPrint} x ${v.prettyPrint} = ${(m * v).prettyPrint}")
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
    problem1()
    problem2()
    problem4()
    problem5()
    problem6()
    problem10()
  }

}

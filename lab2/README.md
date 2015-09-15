CMPSC382 Lab 2 - Hawk Weisman
=============================

What is it?
-----------

I got a bit carried away, and rather than just implementing the simple matrix class described in the assignment, I wrote an entire library that provides an embedded linear algebra domain-specific language in Scala. Since Scala runs on the JVM, it can call into Processing, so I will be able to use this code in future assignments.

Additionally, I was interested in trying to write high performance linear algebra code, since multiplying large matrices and vectors is often a performance-critical component of some scientific and statistical software. Therefore, I've written both a sequential implementation and a parallel implementation. I then performed some benchmarks on both implementations.

I also used my DSL to solve the linear algebra questions on the assignment sheet.

### Contents

Since I anticipated re-using my linear algebra code, I included it in [`hawkw/scala-common`](https://github.com/hawkw/scala-common), a little library of general purpose Scala code that I reuse on multiple projects. `scala-common` is included as a Git submodule in the `lab2/` directory.

The linear algebra code is in the file `scala-common/src/main/scala/me/hawkweisman/math/Linear.scala`, while the tests for the linear algebra library is in `scala-common/src/test/scala/me/hawkweisman/util/tests/LinearSpec.scala` and `LinearGenerators.scala` in the same directory. The benchmarks are in `src/bench/scala/me/hawkweisman/bench/LinearBenchmark.scala`

My code for solving the linear algebra problems on the assignment sheet using my DSL is included in the `src/` directory. It depends on the local `scala-common` submodule.

Finally, I've included the results of a large scale benchmark of my linear algebra library, in the `large_benchmark/` directory. This benchmark data includes an HTML report which visualizes some of the data collected while melting my laptop multiplying unnecessarily large matrices overnight.

### Instructions

All my Scala code is built using [`sbt`](http://www.scala-sbt.org/), Scala's Simple Build Tool. You'll need `sbt` installed on your system to build my project.

From the root `lab2/` directory, the command `$ sbt run` will run the code for solving the questions on the lab handout sheet.

From the `scala-common` directory:

+ `$ sbt test` will run all of `scala-common`'s unit tests, including the ones for the linear algebra library.
+ `$ sbt bench:test` will run the benchmarks for the linear algebra library. Note that the maximum size on these benchmarks has been reduced significantly from the ones I ran overnight.
+ `$ sbt doc` will build `scala-common`'s ScalaDoc documentation, including the docs for `Linear`

Implementation Details
----------------------

My linear algebra library is fully generic, and works directly on arrays of any element which implements Scala's [`Numeric` typeclass](http://www.scala-lang.org/api/current/index.html#scala.math.Numeric). Vectors are represented by arrays, while matrices are represented by multidimensional arrays.

The `Linear` trait is an abstract interface into the linear algebra library. It provides function prototypes for all of the common operations, but does not define them. Concrete implementations are present in `SequentialAlgebra` and `ParallelAlgebra`, which contain the sequential and parallel implementations, respectively.

`Linear` also includes [implicit classes](http://docs.scala-lang.org/overviews/core/implicit-classes.html), which provide operator methods allowing the linear algebra methods to be performed on arrays using a more pleasing syntax. These implicit classes will automatically wrap arrays and numeric values (scalars) to provide those operators when they are used. This is similar to the pattern used by the Scala standard library's numeric typeclasses.

For example, consider the `MatrixOps[N]` implicit class:

```scala
implicit class MatrixOps[N: Numeric : ClassTag](m: Matrix[N]) {
  require(m.length > 0, "Matrices must have 1 or more columns")
  require(m(0).length > 0, "Matrices must have 1 or more rows")

  def +(that: Matrix[N]): Matrix[N]
    = matrixAdd(m, that)

  def -(that: Matrix[N]): Matrix[N]
    = matrixSub(m, that)

  def *(that: Matrix[N]): Matrix[N]
    = crossProduct(m, that)

  def *(that: Vector[N]): Matrix[N]
   = vectorMatrixMul(that, m)

  def ^+(s: N): Matrix[N]
    = matrixScalarAdd(m, s)

  def ^-(s: N): Matrix[N]
    = matrixScalarSub(m, s)

  def ^*(s: N): Matrix[N]
    = matrixScalarMul(m, s)
}
```

This class dispatches calls to the `+`, `-`, and `*` operators to the appropriate linear algebra functions.  Since Scala allows function application with space notation as well as dot notation, this means that when `MatrixOps[N]` is in scope, the expression `m * n` is equivalent to `crossProduct(m, n)`, assuming `m` and `n` are matrices.

Similar implicit lasses are provided to wrap scalar values and provide matrix-scalar and vector-scalar operators over them. Unfortunately, due to JVM type erasure concerns, it was necessary to use different operators for scalar operations. The scalar operations use a similar syntax to Haskell's [`Linear.Vector`](https://hackage.haskell.org/package/linear-0.6.1/docs/Linear-Vector.html), with caret (`^`) characters on the matrix/vector side of the operator.

#### Parallel and Sequential Implementations

The sequential implementation uses Scala collection traversals, such as `map` and `fold` to implement linear operations. The parallel implementation uses similar traversals, but over Scala's [parallel array](http://www.scala-lang.org/api/2.11.7/index.html#scala.collection.parallel.mutable.ParArray) types.

For example, consider the implementations of the `crossProduct(m,n)` function:
```scala
// SequentialAlgebra
override def crossProduct[N : Numeric : ClassTag]
                         (a: Matrix[N], b: Matrix[N]): Matrix[N]
  = { require ( a.length == b(0).length
              , "X-cardinality of matrix A must equal y-cardinality of B." )
      for (row ← a) yield for (col ← b transpose)
        yield row * col
    }
// ParallelAlgebra
override def crossProduct[N : Numeric : ClassTag]
                         (a: Matrix[N], b: Matrix[N]): Matrix[N]
  = { require ( a.length == b(0).length
              , "X-cardinality of matrix A must equal y-cardinality of B." )
      (for ( row ← a.par )
        yield for ( col ← b.transpose )
          yield row * col) toArray
    }
```

These two implementations are essentially the same, except that the `ParallelAlgebra` implementation converts both arrays to parallel arrays before applying the traversal, and then back to standard arrays afterwards. 

I found that the parallel implementation performs much slower than the sequential one for small matrices and vectors, likely due to the added overhead of converting to and from parallel arrays. However, as the size of the matrices and vectors increase, it will eventually offer better performance than the sequential approach. In my large benchmark, I observed this to occur when multiplying 350*350 or larger matrices. This crossover did not occur in my benchmark for other operations, but the trends in the measurements indicate that if I tested against larger arrays, it would occur.

#### Testing

Unit tests were written using the [ScalaTest](http://www.scalatest.org/) library. Two sets of tests were written: `LinearLaws`, which tests against the linear arithmetic properties, and `LinearCorrectness`, which tests linear algebra operations against naive iteration-based algorithms to ensure that they produce the correct result. The [ScalaCheck](https://www.scalacheck.org/) property testing library was used to generate random matrices, vectors, and scalars for use in these tests.

Benchmarks were written using the [ScalaMeter](http://scalameter.github.io/) micro-benchmarking framework.

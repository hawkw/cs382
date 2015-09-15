scalaVersion := "2.11.7"

lazy val root = Project("lab2", file(".")) dependsOn common
lazy val common = RootProject(file("scala-common"))

mainClass in (Compile, run) := Some("lab2.Lab2Problems")

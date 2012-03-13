import sbt._
import Keys._
import PlayProject._

object ApplicationBuild extends Build {

    val appName         = "mockboard2"
    val appVersion      = "1.0-SNAPSHOT"

    val appDependencies = Seq(
      // Add your project dependencies here,
    )

 	val main = PlayProject(appName, appVersion, mainLang = SCALA).settings(
   		lessEntryPoints <<= baseDirectory(_ / "app" / "assets" / "stylesheets" ** "main.less")
 	)

}

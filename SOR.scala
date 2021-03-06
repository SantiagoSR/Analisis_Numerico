import scala.io.Source
import javax.print.DocFlavor.INPUT_STREAM
import javax.print.attribute.standard.PrinterURI
import math._
object SOR {
	def main(args: Array[String]) {
        var C = readCSV()
        
        var B = Array.ofDim[Double](C.length,1)
        var BtoArray = Array.fill(C.length){0.0}
       
          for(i <- 0 to B.length-1){
                  B(i)(0) = C(i)(C(1).length-1)
                  BtoArray.update(i,B(i)(0))
          }
        var A = Array.ofDim[Double](C.length,C(1).length-1)

        for(i <- 0 to C.length-1){
             for(j <- 0 to C(1).length-2){
                A(i)(j) = C(i)(j)
             }
          }

	    var tol = Array.ofDim[Double](C.length,C.length)
        var X0  = Array.ofDim[Double](C.length)
        
        var matMul = A.zip(tol) map (_.zipped map (_ * _)) map (_.sum)
        
        var aiuda = distance(matMul,BtoArray)

        var tolerancia: Double = 0.00001
        var iteracionMax: Int = 100
        var Omega: Double = 0.5
        
        var n: Int = C.size    
        var m: Int = C.size

        var X = X0
        var iteracion : Int = 0
        
        while ((aiuda > tolerancia || iteracion > 100)){
            for(fila <- 0 to n - 1){
                var suma: Double = 0
                var sigma: Double = 0
                for(columna <- 0 to m - 1){
                    if(fila != columna){
                        sigma = sigma + ((A(fila)(columna)) * (X(columna))) 
                    }
                }
                var phi = (1-Omega) * X(fila) + (Omega / A(fila)(fila)) * (B(fila)(0)-sigma)

                X.update(fila, phi)                
                tol.update(fila,X)
            }
            var matMul = A.zip(tol) map (_.zipped map (_ * _)) map (_.sum)

            aiuda = distance(matMul,BtoArray)
            iteracion = iteracion + 1
        }       
        
        var Xt = Array(Array(X(0)))
        for(i <- 1 to X.length-1){
            Xt ++= Array(Array(X(i)))
        }

        if(iteracion > iteracionMax){
            Xt = Array(Array(0),
                     Array(0),
                     Array(0))
        }

        var revision = Array(0.0, 0.0, 0.0)
        
        
        
        println("Respuesta X : ")
        for(i <- 0 to Xt.length-1){
            print("["+ Xt(i)(0) + " ]")
        }
    }

    def readCSV() : Array[Array[Double]] = {
    io.Source.fromFile("test.csv")
    .getLines()
    .map(_.split(",").map(_.trim.toDouble))
    .toArray
}
def distance(xs: Array[Double], ys: Array[Double]) = {
  sqrt((xs zip ys).map { case (x,y) => pow(y - x, 2) }.sum)
}

}
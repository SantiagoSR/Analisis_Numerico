import scala.io.Source
import javax.print.DocFlavor.INPUT_STREAM
object SOR {
	def main(args: Array[String]) {
        var A = readCSV()
        
        var B = Array.ofDim[Double](A.length,1)
       
          for(i <- 0 to B.length-1){
                  B(i)(0) = A(i)(A(1).length-1)
          }
        var C = Array.ofDim[Double](A.length,A(1).length-1)

        for(i <- 0 to A.length-1){
             for(j <- 0 to A(1).length-2){
                C(i)(j) = A(i)(j)
             }
          }
          for(i <- 0 to C.length-1){
             for(j <- 0 to C(1).length-1){
                print(C(i)(j))
             }
             println()
          }
	          
        var X0:Array[Double] = new Array[Double](A.length)
        
        var matMul = C.zip(X0) map (_.zipped map (_ * _)) map (_.sum)
        
        val bMap = B.toMap

        var subMat = matMul.map{ case (k,v) => (k, v - bMap.getOrElse(k,0)) }.filter(_._2 != 0)
        // var tol = (A,X0).zipped.map((x,y) => (x,B).zipped.map(_*_).sum )

        // print(tol)
        var tolerancia: Double = 0.00001
        var iteracionMax: Int = 100
        var Omega: Double = 0.5
        
        var n: Int = A.size    
        var m: Int = A.size

        var X = X0
        
        var diferencia = Array(1.0, 1.0, 1.0)
        
        var errado = tolerancia*2
        var iteracion : Int = 0
        
        while (!(errado <= tolerancia || iteracion > iteracionMax)){
            for(fila <- 0 to n - 1){
                var suma: Double = 0
                var sigma: Double = 0
                for(columna <- 0 to m - 1){
                    if(fila != columna){
                        sigma = sigma + ((A(fila)(columna)) * (X(columna))) 
                    }
                }
                var phi = (1-Omega) * X(fila) + (Omega / A(fila)(fila)) * (B(fila)(0)-sigma)
                diferencia.update(fila,(phi - (X(fila))).abs)
                X.update(fila, phi)
            }
            errado = diferencia.max
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
        // A*Xt
        for(i <- 0 to A.length - 1){
            for(j <- 0 to Xt(0).length - 1){
                for(k <- 0 to Xt.length - 1){
                    revision.update(i, (revision(i)+(A(i)(k) * Xt(k)(j)))) 
                }
            }
        }  
        
        print("Error: ")
        print(errado)
        print(" --- Iteraciones hechas: ")
        print(iteracion)
        println("")
        println("Respuesta X : ")
        for(i <- 0 to Xt.length-1){
            print(Xt(i)(0) + " \n")
        }
        println("")
        println("Verificar A*X=B: ")
        for(i <- 0 to revision.length-1){
            print(revision(i) + " \n")
        }
        println("")
    }

    def readCSV() : Array[Array[Double]] = {
    io.Source.fromFile("test.csv")
    .getLines()
    .map(_.split(",").map(_.trim.toDouble))
    .toArray
}


}
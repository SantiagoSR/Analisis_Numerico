package main

import (
	"fmt"
	"math"
	"time"
	// "github.com/gonum/matrix/mat64"
)

func main() {
	start := time.Now()

	A := [][]float64{
		{3., -0.1, -0.2},
		{0.1, 7, -0.3},
		{0.3, -0.2, 10},
	}

	B := [][]float64{
		{7.85},
		{-19.3},
		{71.4},
	}

	// Ax := mat64.Matrix(A)
	// norm := mat64.Norm(A, 2)
	X0 := [][]float64{
		{0., 0., 0.},
	}

	var tolerancia float64 = 0.0000001
	var iteracionMax int = 100

	var n int = len(A)
	var m int = len(A)
	var omega float64 = 0.5
	var X = X0

	diferencia := [][]float64{
		{1, 1, 1},
	}

	var errado = tolerancia * 2
	var iteracion int = 0

	for !(errado <= tolerancia || iteracion > iteracionMax) {
		for fila := 0; fila < n; fila++ {
			var suma float64 = 0
			for columna := 0; columna < m; columna++ {
				if fila != columna {
					suma = (A[fila][columna]) * (X[0][columna])
				}
			}
			var nuevo = (1.0-omega)*X[0][fila] + (omega/A[fila][fila])*(B[fila][0]-suma)

			diferencia[0][fila] = math.Abs(nuevo - X[0][fila])

			X[0][fila] = nuevo

		}
		var max float64
		for _, j := range diferencia {
			var n float64
			for _, v := range j {
				if v > n {
					n = v
					max = n
				}
			}
		}
		errado = max
		iteracion = iteracion + 1
	}

	if iteracion > iteracionMax {
		X = [][]float64{{0., 0., 0.}}
	}

	//revision, _ := multiply(A, X)

	fmt.Println("Error:", errado, "--- Iteraciones hechas:", iteracion)
	fmt.Println("")
	fmt.Println("Respuesta X: ", X)
	fmt.Println("")
	//fmt.Println("Verificar A*X=B: ", revision)
	fmt.Println("")

	elapsed := time.Since(start)
	fmt.Println("Tiempo de ejecucion:", elapsed)
}

func transpose(x [][]float64) [][]float64 {
	out := make([][]float64, len(x[0]))
	for i := 0; i < len(x); i += 1 {
		for j := 0; j < len(x[0]); j += 1 {
			out[j] = append(out[j], x[i][j])
		}
	}
	return out
}

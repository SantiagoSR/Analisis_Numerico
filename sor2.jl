using LinearAlgebra
@time begin

# Create symmetric, positive definite matrix
A = [3 -0.1 -0.2;
    0.1 7 -0.3;
    0.3 -0.2 10]

b = [7.85;
    -19.3;
    71.4]

    
X0 = zeros(size(A,1))   # initial guess
w = 1.5#1.25

tolerancia = Float64(0.00001) 
iteracionMax = Int(100)

tol = Float64(0.00001)
maxiter = Int(100)

x = copy(X0)

iter = Int(0)

n = size(A,1)

norma =norm(b - A * X0,2)


    
diferencia = [1. 1. 1.]
    
errado = tolerancia * 2
iteracion = Int(0)


while !( norma <= tolerancia || iteracion > iteracionMax)
    if iter == maxiter
        println("Maximum number of iterations reached: $(iter)")
         break
    end

    for i = 1:n
        sigma = Float64(0)
        for j = 1:n
            if j != i
                sigma = sigma + A[i, j]*X0[j]
            end
            
        end
        # ALTERNATIVE IMPLEMENTATION
        global X0[i] = (1-w)*X0[i] + ((w/A[i,i]) * (b[i] - sigma))
        
    end
    global iter += 1
    global norma = norm(b - A * X0,2)
end

X = X0
#println("Error: ", errado, "--- Iteraciones hechas: ", iteracion)
println("")
println("Respuesta X: ", X)
println("")
#println("Verificar A*X=B: ", revision)
println("")
print("Tiempo de ejecución: ")
end
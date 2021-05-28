import numpy as np
import time

def sor_solver(A, b, omega, initial_guess, convergence_criteria, kmax):
    step = 0
    phi = initial_guess[:]
    residual = np.linalg.norm(np.matmul(A, phi) - b)  # Initial residual
    print(np.matmul(A, phi))
    print(np.linalg.norm(np.matmul(A, phi) - b))

    while (residual > convergence_criteria or kmax < 100) :
        for i in range(A.shape[0]):
            sigma = 0
            for j in range(A.shape[1]):
                if j != i:
                    sigma += A[i, j] * phi[j]
            phi[i] = (1 - omega) * phi[i] + (omega / A[i, i]) * (b[i] - sigma)
        residual = np.linalg.norm(np.matmul(A, phi) - b)
        step += 1
        kmax += 1
        # print("Step {} Residual: {:10.6g}".format(step, residual))
    return phi


def main():
# An example case that mirrors the one in the Wikipedia article
    residual_convergence = 1e-8
    omega = 0.5 # Relaxation factor

    
    
    A = np.array([[3., -0.1, -0.2],
		        [0.1, 7, -0.3],
		        [0.3, -0.2, 10]])

    b = np.array([7.85, -19.3, 71.4])

    initial_guess = np.zeros(A.shape[0])
    t = time.time()
    kmax = 0

    phi = sor_solver(A, b, omega, initial_guess, residual_convergence, kmax)
    
    print(phi)
    print("El tiempo fue de [{0:6.4f}]".format(t))

main()
import os 
# os.system('julia installpkg.jl')
os.system('python3 SOR.py')
os.system('julia sor2.jl')
os.system('scalac SOR.scala')
os.system('scala SOR')
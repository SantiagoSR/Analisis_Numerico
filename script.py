import os 
os.system('julia -e "using Pkg; Pkg.add([\"DataFrames\"])"')
os.system('julia -e "using Pkg; Pkg.add([\"CSV\"])"')
os.system('python SOR.py')
os.system('julia sor2.jl')
os.system('scalac SOR.scala')
os.system('scala SOR')
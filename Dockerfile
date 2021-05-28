FROM python:3
RUN pip install numpy
RUN sudo yum-config-manager --add-repo https://copr.fedorainfracloud.org/coprs/nalimilan-nightlies/julia/repo/epel-7/nalimilan-julia-epel-7.repo
RUN sudo yum install julia
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl

FROM python:3
RUN pip install numpy
RUN sudo apt install julia
RUN which julia
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl

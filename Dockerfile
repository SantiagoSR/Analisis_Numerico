FROM julia:latest
FROM python:3
RUN pip install numpy
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl

FROM python:3
RUN apt-get update -y
RUN pip install numpy
RUN sudo yum install wget -y
RUN apt-get install -y julia
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl
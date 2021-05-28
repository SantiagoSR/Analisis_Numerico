FROM python:3
RUN apt-get update -y
RUN pip install numpy
RUN apt-get install wget -y
RUN apt-get install -y julia
RUN apt-get install default-jdk
RUN apt-get install scala
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl
RUN scalac SOR.scala
RUN scala SOR
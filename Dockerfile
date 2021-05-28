FROM python:3
RUN apt-get update -y
RUN pip install numpy \
    apt-get install wget -y \
    apt-get install -y julia \
    apt-get install -y default-jdk \
    apt-get install -y scala
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl
RUN scalac SOR.scala
RUN scala SOR
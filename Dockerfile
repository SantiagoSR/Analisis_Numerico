FROM python:3
RUN apt-get update -y
RUN pip install numpy
RUN apt-get install wget -y
FROM julia:latest
RUN apt-get update && apt-get -y install
RUN julia -e "Pkg.add(\"CSV\")" && \
    julia -e "Pkg.add(\"DataFrames\")"
RUN apt-get install -y default-jdk
RUN apt-get install -y scala
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
CMD ["script.py"]
ENTRYPOINT ["python3"]
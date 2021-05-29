RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip install numpy
RUN apt-get install wget -y
RUN apt-get install -y default-jdk
RUN apt-get install -y scala
FROM julia:latest
RUN apt-get update && apt-get -y install
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("CSV"); using CSV' && \
    julia -e 'import Pkg; Pkg.add("DataFrames"); using DataFrames'
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
ENTRYPOINT ["python3"]
CMD ["script.py"]

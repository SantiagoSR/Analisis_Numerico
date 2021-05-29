FROM python:3
RUN apt-get update -y
RUN pip install numpy
RUN apt-get install wget -y
RUN apt-get install -y julia
RUN julia -e 'import Pkg; Pkg.update()' &&\
    julia -e 'import Pkg; Pkg.add("CSV"); using CSV' && \
    julia -e 'import Pkg; Pkg.add("DataFrames"); using DataFrames'
RUN apt-get install -y default-jdk
RUN apt-get install -y scala
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
CMD ["script.py"]
ENTRYPOINT ["python3"]
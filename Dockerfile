FROM openjdk:7
RUN apt-get update && apt-get -y install
RUN apt-get install -y scala
RUN apt-get update && apt-get -y install
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.0-linux-x86_64.tar.gz
RUN tar -xvzf julia-1.6.0-linux-x86_64.tar.gz
RUN cp -r julia-1.6.0 /opt/
RUN ln -s /opt/julia-1.6.0/bin/julia /usr/local/bin/julia
RUN apt-get update && apt-get -y install
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("CSV"); using CSV' && \
    julia -e 'import Pkg; Pkg.add("DataFrames"); using DataFrames'
FROM python:3.8
RUN pip install numpy
RUN apt-get install wget -y
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
ENTRYPOINT ["python3"]
CMD [ "python3", "script.py" ]

FROM python:3
RUN pip install numpy
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.1-linux-x86_64.tar.gz
RUN export PATH="$PATH:/path/to/<Julia directory>/bin"
RUN tar zxvf julia-1.6.1-linux-x86_64.tar.gz
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
RUN python SOR.py
RUN julia sor2.jl

FROM python:3.8
RUN pip install numpy
RUN apt-get install wget -y
COPY . /Analisis_Numerico
WORKDIR /Analisis_Numerico
ENTRYPOINT ["python3"]
CMD [ "python3", "script.py" ]
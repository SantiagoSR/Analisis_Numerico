FROM julia:latest
FROM python:3
RUN pip install numpy
RUN python SOR.py
RUN julia sor2.jl

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y python3 python3-numpy python python-numpy \
    pep8 python3-pip
RUN pip install numpy
RUN pip install tabulate
RUN pip install matplotlib
RUN pip install tensorboard
RUN pip install scipy
RUN pip install tqdm
RUN pip install opencv-python

RUN git clone https://github.com/fajilatun/segformer.git
WORKDIR ./segformer

RUN python -m pip install -r ./requirements.txt

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1QK1qgaKOPAatx-DHNmv7Mu0S0cE1fHCN' -O hardnet70_cityscapes.pth

RUN git clone https://github.com/anastasia-yasakova/segformer_unn.git

RUN python tools/infer.py --cfg segformer/custom.yaml

CMD ["python", "test_segformer.py"]


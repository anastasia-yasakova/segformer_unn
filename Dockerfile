FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y python3 python3-numpy python python-numpy git wget\
    pep8 python3-pip

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN pip install opencv-python
RUN pip install torch
RUN pip install pyyaml

RUN git clone https://github.com/fajilatun/segformer.git
WORKDIR ./segformer

RUN pip install -r ./requirements.txt

RUN pip install torchvision

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1QK1qgaKOPAatx-DHNmv7Mu0S0cE1fHCN' -O hardnet70_cityscapes.pth

RUN git clone https://github.com/anastasia-yasakova/segformer_unn.git

CMD ["python3", "tools/infer.py", "--cfg", "segformer_unn/custom.yaml"]

CMD ["python3", "segformer_unn/test_segformer.py"]


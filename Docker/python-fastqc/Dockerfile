FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    default-jre \
    wget \
    unzip \
    perl \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /opt/fastqc.zip https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
    unzip /opt/fastqc.zip -d /opt/ && \
    chmod +x /opt/FastQC/fastqc && \
    ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc

RUN python3 --version && fastqc --version

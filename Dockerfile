FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    notebook \
    jupyterlab \
    pandas \
    numpy \
    matplotlib

WORKDIR /app

EXPOSE 3000

CMD ["jupyter", "notebook", "--port=3000", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

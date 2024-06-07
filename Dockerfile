# Dockerfile

# Utiliza a imagem base do Ubuntu
FROM ubuntu:20.04

# Define o mantenedor do Docker
LABEL maintainer="seuemail@dominio.com"

# Atualiza a lista de pacotes e instala dependências
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -y \
    libglib2.0-0 \
    libglib2.0-dev \
    libpixman-1-0 \
    libpixman-1-dev \
    flex \
    bison \
    build-essential \
    git \
    wget \
    xz-utils \
    python3 \
    python3-pip \
    python3-venv \
    ninja-build \
    pkg-config \
    python3-sphinx \
    python3-setuptools

# Instala as bibliotecas Sphinx e sphinx-rtd-theme
RUN pip3 install sphinx>=1.6.0 sphinx-rtd-theme

# Baixa e extrai o QEMU
RUN wget https://download.qemu.org/qemu-8.1.1.tar.xz && \
    tar -xvf qemu-8.1.1.tar.xz && \
    rm qemu-8.1.1.tar.xz    

# Configura o QEMU
WORKDIR /qemu-8.1.1
RUN ./configure --target-list=sparc-softmmu


# Cria e define o diretório de trabalho para compilação
WORKDIR /qemu-8.1.1/build

# Compila o QEMU
RUN make -j$(nproc)

# Comando padrão para manter o contêiner ativo
CMD ["bash"]


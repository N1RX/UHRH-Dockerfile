FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive


# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    libasound2-dev \
    portaudio19-dev \
    libpam0g-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    git \
    curl \
    ca-certificates \
    build-essential \
    autoconf \
    automake \
    libtool \
    swig \
    librtlsdr0 \
    librtlsdr-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Install Hamlib
WORKDIR /opt

RUN git clone https://github.com/Hamlib/Hamlib.git

# Build Hamlib with Python bindings
WORKDIR /opt/Hamlib
RUN ./bootstrap && \
    mkdir build && cd build && \
    ../configure --with-python-binding PYTHON=$(which python3) --prefix=/usr/local && \
    make -j$(nproc) && \
    make install




# Create a Python virtual environment
RUN python3 -m venv /opt/venv


# Configure Dynamic Linker Run-Time Bindings
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/hamlib.conf && ldconfig

# Make sure the Hamlib Python bindings are available in the virtual environment
RUN echo "/usr/local/lib/python3.11/site-packages" > /opt/venv/lib/python3.11/site-packages/hamlib.pth

# Activate the virtual environment
ENV PATH="/opt/venv/bin:$PATH"


# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install \
        numpy \
        tornado \
        pyserial \
        pyaudio \
        pyalsaaudio \
        pytest \
        pyrtlsdr \
        python-pam


# Clone the Universal HamRadio Remote HTML5 repository in backup so it can be mounted later
WORKDIR /uhrh_backup
RUN git clone https://github.com/F4HTB/Universal_HamRadio_Remote_HTML5.git .

WORKDIR /uhrh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["python3", "UHRR"]



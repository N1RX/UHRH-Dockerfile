
# Universal HamRadio Remote (UHRR) – Dockerized

  

This repository provides a Docker container for the excellent [Universal HamRadio Remote HTML5](https://github.com/F4HTB/Universal_HamRadio_Remote_HTML5) project by [F4HTB](https://github.com/F4HTB).

It includes all dependencies, including Hamlib with Python bindings and SDR support, packaged in a portable container.

  

>  **Credits**:

> Full credit for the core project goes to [F4HTB](https://github.com/F4HTB) and contributors. This Docker setup simply packages it for convenient deployment.

  

---

  

## 📦 Features

  

Prebuilt with:

- Hamlib (from source)

- pyrtlsdr, pyaudio, pyserial, PAM auth

- Exposes `/uhrh` volume for persistence and and easy configuration

- Python virtual environment isolation

  

---

  

## 🚀 Quickstart

  

### 1. Install Docker & Docker Compose (if not already done)

  

Run the official convenience script:

  

```bash

curl -fsSL  https://get.docker.com  -o  get-docker.sh

sh get-docker.sh

```

  

### 2. Clone this repository

  

```bash

git clone  https://github.com/n1rx/uhrh-dockerfile.git

cd uhrh-dockerfile

```

  

### 3. Start the container

  

```bash

docker compose  up  -d

```

  

The UHRR web interface will be available at: [https://YOUR-IP:8888](https://YOUR-IP:8888)  
Make sure you access it via **HTTPS** to ensure proper functionality.



  

---

  

## 🔧 Configuration

  

-  `/uhrh`: Volume mount where the runtime app lives (backed up from GitHub repo at build time)

- Devices:

	-  `/dev/ttyUSB0`: For serial-connected radios. Change it to your tty device

	-  `/dev/snd`: For audio passthrough

  

You may need to adjust device mappings or add your user to `dialout` and `audio` groups.

  

---

  

  ## 🛠️ Build From Source (Optional)

If you want to build the image yourself instead of pulling from GHCR:

✏️ **Before building**, make sure to uncomment the `build: .` line in your `docker-compose.yml`:

```yaml
services:
  uhrh:
    build: .
    # image: ghcr.io/n1rx/uhrh-dockerfile:main
```


```bash

docker compose  build

```

  

Then start:

  

```bash

docker compose  up  -d

```

  

---

  

## 🙏 Acknowledgements

  

- Project by **[F4HTB](https://github.com/F4HTB)**: [Universal_HamRadio_Remote_HTML5](https://github.com/F4HTB/Universal_HamRadio_Remote_HTML5)

- Hamlib team: [https://github.com/Hamlib/Hamlib](https://github.com/Hamlib/Hamlib)

- pyrtlsdr, PyAudio, and other contributors to the SDR and audio ecosystem

  

---

  

## 🧪 Troubleshooting

 The image is tested on a Raspberry Pi. 

If the container fails to start:

  

- Ensure your user has permissions for `/dev/snd` and `/dev/ttyUSB0`

- Check logs with:

  

```bash

docker logs  -f  uhrh

```

  

- Confirm no other app is already binding to port `8888`

Be sure to visit the [Official Wiki](https://github.com/F4HTB/Universal_HamRadio_Remote_HTML5/wiki) for more information.
  

---

  

## 📄 License

  

This Docker setup is MIT licensed.

Refer to upstream repositories for their respective licenses.

73 DL3NW

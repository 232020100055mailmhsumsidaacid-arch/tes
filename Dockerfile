# Gunakan image dasar Ubuntu terbaru (misalnya 24.04 LTS, atau yang saat ini dianggap "latest")
# Kami menggunakan 'ubuntu:latest' untuk mendapatkan versi terbaru yang stabil.
FROM ubuntu:latest

# Atur variabel lingkungan agar instalasi Python tidak meminta input interaktif
ENV DEBIAN_FRONTEND=noninteractive

# --- Instalasi Prasyarat dan Python ---
# Perbarui daftar paket, instal utilitas dasar, Python3, pip, dan dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# --- Instalasi Jupyter ---
# Instal Jupyter Notebook dan beberapa library umum untuk data science (opsional, tapi disarankan)
RUN pip install --no-cache-dir \
    notebook \
    jupyterlab \
    pandas \
    numpy \
    matplotlib

# --- Konfigurasi Lingkungan ---
# Atur direktori kerja di mana notebook akan disimpan
WORKDIR /app

# Buat direktori dan atur permission untuk user non-root (opsional, tapi praktik yang baik)
# Di lingkungan produksi, Anda harus menjalankan container sebagai user non-root.
# Namun, untuk kesederhanaan, kita akan menjalankan sebagai root/default user image Ubuntu.

# Expose port yang diinginkan (3000)
# Ini hanya mendokumentasikan port, bukan memublikasikannya secara otomatis.
EXPOSE 3000

# --- Perintah Startup ---
# Jalankan Jupyter Notebook saat container diluncurkan.
# Argumen yang digunakan:
# --port=3000: Mengatur port internal container ke 3000
# --ip=0.0.0.0: Membuat notebook dapat diakses dari luar container (semua interface)
# --allow-root: Diperlukan jika Anda menjalankan container sebagai user root (default Ubuntu).
# --no-browser: Mencegah Jupyter mencoba membuka browser di dalam container.
# --NotebookApp.token='': Opsional, untuk kemudahan akses tanpa token (tidak disarankan untuk produksi!)
CMD ["jupyter", "notebook", "--port=3000", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

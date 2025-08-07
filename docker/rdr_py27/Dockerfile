FROM continuumio/miniconda3

# -------------------------------
# Copy Conda environment file and create Python 2.7 environment
# -------------------------------
COPY rdr_py27_docker.yml /tmp/rdr_py27.yml
RUN conda env create -f /tmp/rdr_py27.yml

# -------------------------------
# Add mamba and install samtools
# -------------------------------
RUN conda install -n base -c conda-forge mamba && \
    mamba install -n rdr_py27 -c bioconda samtools=1.9

# -------------------------------
# Install curl and Java (OpenJDK 11)
# -------------------------------
USER root
RUN apt-get update && \
    apt-get install -y curl && \
    curl -L https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22+7/OpenJDK11U-jre_x64_linux_hotspot_11.0.22_7.tar.gz \
    -o /tmp/openjdk11.tar.gz && \
    mkdir -p /opt/java/openjdk && \
    tar -xzf /tmp/openjdk11.tar.gz -C /opt/java/openjdk --strip-components=1 && \
    rm /tmp/openjdk11.tar.gz

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# -------------------------------
# Install R and required packages
# -------------------------------
RUN apt-get update && \
    apt-get install -y \
        r-base \
        r-base-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev && \
    Rscript -e 'install.packages(c("data.table", "R.utils"), repos="https://cloud.r-project.org")'

# -------------------------------
# Switch to Conda env for remaining steps
# -------------------------------
SHELL ["conda", "run", "-n", "rdr_py27", "/bin/bash", "-c"]

# -------------------------------
# Copy your pipeline scripts
# -------------------------------
COPY RDREstimator.py /usr/local/bin/RDREstimator.py
COPY Utils.py /usr/local/bin/Utils.py
COPY runrdr /usr/local/bin/runrdr
RUN chmod +x /usr/local/bin/runrdr

# -------------------------------
# Copy and register R post-processing script
# -------------------------------
COPY process_chr.R /usr/local/bin/process_chr
RUN chmod +x /usr/local/bin/process_chr

# -------------------------------
# Default to interactive shell
# -------------------------------
CMD ["bash"]

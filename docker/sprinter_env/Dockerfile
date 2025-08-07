FROM continuumio/miniconda3

# Set up channels
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge

# Create the sprinter environment
RUN conda create -n sprinter -c bioconda -c conda-forge sprinter -y

# Activate environment in entrypoint and expose binaries in PATH
ENV PATH="/opt/conda/envs/sprinter/bin:$PATH"
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Java 11 (for Nextflow)
RUN apt-get update && \
    apt-get install -y curl && \
    curl -L https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22+7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.22_7.tar.gz \
    -o /tmp/openjdk11.tar.gz && \
    mkdir -p /opt/java/openjdk && \
    tar -xzf /tmp/openjdk11.tar.gz -C /opt/java/openjdk --strip-components=1 && \
    rm /tmp/openjdk11.tar.gz

# Default command
CMD ["bash"]

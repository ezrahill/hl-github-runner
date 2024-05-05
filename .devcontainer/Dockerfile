FROM debian:bullseye-slim

# Set Environment variables
ENV TF_VERSION=1.8.2 \
    PIP_PACKAGES="ansible" \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install essential system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl gcc git libffi-dev openssh-client \
    libssl-dev unzip python3-pip python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --upgrade pip \
    && pip install ${PIP_PACKAGES}

# Determining architecture for Terraform binary and installing Terraform
RUN dpkgArch="$(dpkg --print-architecture)" \
    && case "${dpkgArch##*-}" in \
        amd64) ARCH='amd64' ;; \
        arm64) ARCH='arm64' ;; \
        armhf) ARCH='arm' ;; \
        armel) ARCH='arm' ;; \
        *) echo "unsupported architecture" >&2; exit 1 ;; \
    esac \
    && curl -fsSL -o terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${ARCH}.zip" \
    && unzip terraform.zip -d /usr/bin \
    && rm terraform.zip \
    && chmod +x /usr/bin/terraform

CMD ["/bin/bash"]

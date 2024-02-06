FROM nvcr.io/nvidia/pytorch:21.12-py3

ARG USER
ARG GROUP
ARG UID
ARG GID

# Install Dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update

# Add User and Group
RUN groupadd --gid $GID $GROUP
RUN useradd --uid $UID $USER -g $GROUP --create-home
USER $USER:$GROUP
WORKDIR /home/$USER
ENV TZ "UTC-9"
ENV PATH "/home/$USER/.local/bin:$PATH"
ENV TORCH_HOME "/home/$USER/data/torch"

# Install Python Packages
RUN pip install --upgrade pip
RUN pip install --upgrade gpustat
RUN pip install --upgrade torch==2.0.0 torchvision==0.15.1
RUN pip install --upgrade accelerate==0.23.0
RUN pip install --upgrade tqdm numpy scipy scikit-image matplotlib pandas wget linear_attention_transformer
RUN pip install --upgrade "jsonargparse[all]"
RUN pip install --upgrade einops

# Set Working Directory
WORKDIR /home/$USER/workspace
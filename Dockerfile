FROM fedora:41

ARG PRIVATE_KEY=""
ARG PUBLIC_KEY=""

RUN dnf update -y
RUN dnf install git neovim ShellCheck shfmt bash-language-server fzf python3 pip3 -y
RUN dnf install python3 python3-pip
RUN pip3 install jedi-language-server

COPY . /root/.config/nvim

RUN mkdir /root/.ssh
RUN echo "${PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN echo "${PUBLIC_KEY}" > /root/.ssh/id_rsa.pub

RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub

WORKDIR /root

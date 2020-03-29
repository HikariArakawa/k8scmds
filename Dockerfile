FROM alpine:3.8.5
RUN apk update
RUN apk add curl
USER root

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl
RUN mkdir /kubeconfig
COPY kubeconfig/* /kubeconfig/
# docker-compose
ENV KUBECONFIG /kubeconfig/config

# helm
# https://github.com/helm/
RUN mkdir helm-tmp \
 && cd helm-tmp \
 && curl -LO https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz \
 && tar -xvzf helm-v3.1.2-linux-amd64.tar.gz \
 && mv ./linux-amd64/helm /usr/local/bin/helm \
 && chmod +x /usr/local/bin/helm \
 && rm -R /helm-tmp
 
# kubeseal
# RUN curl -L https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.12.0/kubeseal-linux-amd64 -o /usr/local/bin/kubeseal \
#  && chmod +x /usr/local/bin/kubeseal 



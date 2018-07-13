FROM ubuntu:18.04
MAINTAINER Sonny Scroggin <sonny@scrogg.in>

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qq && \
    apt install -y \
    wget \
    curl \
    locales \
    build-essential \
    libpq-dev \
    git \
    apt-utils

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb

RUN apt update -qq && \
    apt install -y esl-erlang elixir

#Set Locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Build hex
RUN mix local.hex --force && mix local.rebar --force

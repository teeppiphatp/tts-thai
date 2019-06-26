# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Copyright 2018 Google, Inc.

FROM langtech/base-language-resources:v1_1

RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

# As suggested by a user, for some people this line works instead of the first one. Use whichever works for your case
# RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list


RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get  -o Acquire::Check-Valid-Until=false  update && apt-get install -y \
      automake \
      bc \
      curl \
      g++ \
      git \
      libc-dev \
      libreadline-dev \
      libtool \
      make \
      ncurses-dev \
      nvi \
      pkg-config \
      python \
      python-dev \
      python-setuptools \
      unzip \
      wavpack \
      wget \
      zip \
      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Fetch and prepare Festival & friends
WORKDIR /usr/local/src/tools
ENV FESTIVAL_SUIT_PATH /usr/local/src/tools
RUN /usr/local/src/language-resources/festival_utils/setup_festival.sh

RUN rm /usr/local/src/tools/festival/lib/festival.el

# Set env variables
ENV ESTDIR /usr/local/src/tools/speech_tools
ENV FESTVOXDIR /usr/local/src/tools/festvox
ENV FESTIVALDIR /usr/local/src/tools/festival
ENV FLITEDIR /usr/local/src/tools/flite
ENV SPTKDIR /usr/local/src/tools/
ENV EXDIR /usr/local/src/tools/examples

# Add festival to path
ENV PATH="/usr/local/src/tools/festival/bin:${PATH}"
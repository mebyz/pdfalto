FROM ubuntu:18.04
RUN mkdir -p /app
WORKDIR /app
RUN apt-get update
RUN apt-get install -y libmotif-dev git cmake libxml2 libxml2-dev wget
RUN wget http://download.icu-project.org/files/icu4c/62.1/icu4c-62_1-src.tgz -O /app/icu4c.tgz
RUN cd /app && gunzip -d < icu4c.tgz | tar xvf -
RUN cd /app/icu/source && chmod +x runConfigureICU configure install-sh && ./runConfigureICU Linux --enable-static --disable-shared && make
RUN apt-get install -y gcc-5 g++-5
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 1
COPY . /app/
RUN cd /app && git submodule update --init --recursive && cmake -D'ICU_PATH=/app/icu/source/' -D'XPDF_SUBDIR=/app/xpdf-4.00'
RUN make
CMD ["./run.sh"]

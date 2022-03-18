FROM ubuntu:impish
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Davin
RUN echo Davin
CMD echo Davin
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate -nv "https://workupload.com/start/E5atKBeeYW8" -O M11.2_bin.7z \
&& 7z e M11.2_bin.7z && rm M11.2_bin.7z

#add variant books 
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/antichess.bin" -O antichess.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/atomic.bin" -O atomic.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/horde.bin" -O horde.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/racingKings.bin" -O racingKings.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/threeCheck.bin" -O threeCheck.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/kingOfTheHill.bin" -O kingofthehill.bin

RUN wget --no-check-certificate "https://github.com/Nimsilu/bots-un/raw/master/engines/fsf_linux" -O fsf
RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/f3a2296e591d09dd50323fc3f96e800f5538d8bb/linux64modern/stockfish_22031308_x64_modern.zip" -O chess-engine.zip
RUN wget --no-check-cerificate "https://github.com/TheDarkGrandmaster2/masterbotheroku/raw/master/engines/fsf" msf
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x fsf
RUN chmod +x msf
# Engine name is here ^^^^^^

CMD python3 run.py

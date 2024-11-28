FROM haskell:8

WORKDIR /opt/chester

RUN cabal update

COPY ./chester.cabal /opt/chester/chester.cabal
RUN cabal build --only-dependencies -j4

COPY . /opt/chester
RUN cabal install

CMD ["chester"]

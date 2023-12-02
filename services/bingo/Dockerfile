FROM debian:bookworm-slim

WORKDIR /opt/bingo

RUN apt-get update && apt-get -y install curl

RUN adduser bingo

COPY --chown=bingo:bingo src/bingo .
RUN chmod 0755 bingo

# echo -n maksim@natalich.ru | sha1sum | head -c 10
# c457cc00f8
RUN mkdir -p /opt/bongo/logs/c457cc00f8/
RUN chown bingo:bingo -R /opt/bongo/*

USER bingo

# А вот как генерится порт я не разобрался)
EXPOSE 22974

CMD ["./bingo", "run_server"]

HEALTHCHECK --interval=4s --timeout=3s --start-period=50s \
  CMD curl -f http://localhost:22974/ping || exit 1

FROM alpine:3.17

RUN apk update && apk add bash curl util-linux

COPY check_response.sh /check_response.sh

RUN chmod +x /check_response.sh

CMD ["watch", "-n", "30", "./check_response.sh"]

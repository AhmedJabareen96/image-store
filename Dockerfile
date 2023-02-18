FROM alpine:latest
WORKDIR /image-store
COPY . .
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add py3-pip
RUN pip3 install -r requirements.txt
CMD ["python3","main.py"]
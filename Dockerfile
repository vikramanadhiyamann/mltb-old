FROM ghcr.io/hsjsa/hekoru:abuser

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r fukker.txt

COPY . .

CMD ["bash", "start.sh"]

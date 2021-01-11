FROM python:3.9

WORKDIR /usr/src/app

ENV THINGSBOARD_HOST='<host>' 
ENV THINGSBOARD_USERNAME='<username>' 
ENV THINGSBOARD_PASSWORD='<password>'

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python" ]
CMD [ "thingsboard-json-enhancer" ]

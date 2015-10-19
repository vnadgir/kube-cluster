FROM alpine

RUN echo "[localhost]" > ~/.ansible_hosts \
 && echo '127.0.0.1 ansible_python_interpreter=$VIRTUAL_ENV/bin/python' >> ~/.ansible_hosts \
 && apk --update add py-pip py-virtualenv gcc python-dev build-base bash \
 && mkdir .venv \
 && virtualenv .venv \
 && . .venv/bin/activate \
 && pip install ansible boto awscli

ADD provision.sh /
ADD ansible/ /ansible

CMD /bin/bash provision.sh


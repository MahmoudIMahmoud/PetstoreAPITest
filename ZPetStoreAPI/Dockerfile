FROM python:3

#RUN python3 -m pip install robotframework
RUN	pip install -U \
		pip \
		robotframework==3.1.2 \
		robotframework-requests==0.6.2

ENV PATH=/user/src:$PATH
WORKDIR /usr/src

#COPY ./*  /usr/src/
#CMD ["cd","/usr/src"]
#CMD ["ls",">ls.txt"]
#CMD ["echo","$(pwd)"]
CMD ["chmod", "a+x", "./script.sh"]
CMD ["./script.sh"]

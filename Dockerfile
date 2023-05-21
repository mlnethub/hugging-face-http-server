# Copyright (c) Microsoft. All rights reserved.

FROM huggingface/transformers-pytorch-gpu

RUN apt install -y wget
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt update 
RUN rm packages-microsoft-prod.deb
RUN apt-get install -y dotnet-runtime-7.0

COPY ./requirements.txt /app/requirements.txt


# switch working directory
WORKDIR /app

# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python3" ]

CMD ["inference_app.py" ]
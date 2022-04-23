ARG FUNCTION_DIR="/function"

FROM mcr.microsoft.com/playwright/python:latest

ARG FUNCTION_DIR

# Create function directory
RUN mkdir -p ${FUNCTION_DIR}

# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

# Copy function code and requirements
COPY app/* ${FUNCTION_DIR}/

# Install the runtime interface client
RUN python -m pip install -r ${FUNCTION_DIR}/requirements.txt 


EXPOSE 5000

CMD python -m gunicorn main:app

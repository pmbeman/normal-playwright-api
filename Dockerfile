ARG FUNCTION_DIR="/function"

FROM mcr.microsoft.com/playwright/python:latest as build-image
ARG FUNCTION_DIR

# Create function directory
RUN mkdir -p ${FUNCTION_DIR}

# Copy function code and requirements
COPY app/* ${FUNCTION_DIR}/

# Install the runtime interface client
RUN python -m pip install -r ${FUNCTION_DIR}/requirements.txt \
        --target ${FUNCTION_DIR} \
        --no-cache-dir 

# Multi-stage build: grab a fresh copy of the base image
FROM mcr.microsoft.com/playwright/python:latest

ARG FUNCTION_DIR
# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

# Copy in the build image dependencies
COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}

ENV PORT=80
EXPOSE ${PORT}

CMD python -m gunicorn main:app

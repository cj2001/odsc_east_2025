FROM jupyter/datascience-notebook

USER root

COPY requirements.txt ./
RUN pip install -U pip
RUN pip install --no-cache-dir -r requirements.txt

ENV JUPYTER_ENABLE_LAB=yes

# Ensure directory is created with correct ownership
RUN mkdir -p /home/jovyan/work && chown -R ${NB_UID}:${NB_GID} /home/jovyan/work

# Switch to the jovyan user
USER ${NB_UID}

# Copy files as jovyan user
COPY --chown=${NB_UID}:${NB_GID} . /home/jovyan/work
WORKDIR /home/jovyan/work

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/home/jovyan/work", "--allow-root"]

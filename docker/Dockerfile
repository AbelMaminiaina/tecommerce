FROM odoo:18.0

# Switch to root for installations
USER root

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    python3-dev \
    git \
    postgresql-client \
    vim \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install additional Python packages for development
RUN pip3 install --no-cache-dir \
    watchdog \
    debugpy \
    pytest \
    pytest-odoo \
    pylint-odoo \
    black \
    ipython

# Create directories for custom addons
RUN mkdir -p /mnt/extra-addons \
    /mnt/custom-addons

# Copy entrypoint and wait scripts
COPY ./docker/entrypoint.sh /entrypoint.sh
COPY ./docker/wait-for-psql.sh /wait-for-psql.sh
RUN chmod +x /entrypoint.sh /wait-for-psql.sh

# Switch back to odoo user
USER odoo

# Set working directory
WORKDIR /mnt/custom-addons

# Expose ports (8069 for Odoo, 8072 for long-polling, 5678 for debugger)
EXPOSE 8069 8072 5678

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]

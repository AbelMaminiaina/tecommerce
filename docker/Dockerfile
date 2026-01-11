FROM ubuntu:24.04

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Create odoo user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Build tools
    build-essential \
    wget \
    git \
    curl \
    vim \
    # Python
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    # PostgreSQL client and dev headers
    postgresql-client \
    libpq-dev \
    # Image processing
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libtiff5-dev \
    # XML/XSLT
    libxml2-dev \
    libxslt1-dev \
    # LDAP
    libldap2-dev \
    libsasl2-dev \
    # SSL
    libssl-dev \
    # Fonts
    fonts-liberation \
    # Tools
    node-less \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf (for PDF generation)
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_amd64.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends ./wkhtmltox_0.12.6.1-3.jammy_amd64.deb \
    && rm wkhtmltox_0.12.6.1-3.jammy_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Switch to odoo user
USER odoo

# Clone Odoo 18.0 from GitHub
WORKDIR /opt/odoo
RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git odoo

# Install Python dependencies with fixed versions
WORKDIR /opt/odoo/odoo
RUN pip3 install --no-cache-dir --user --break-system-packages \
    -r requirements.txt

# Create custom addons directories
RUN mkdir -p /opt/odoo/custom-addons /opt/odoo/extra-addons

# Switch back to root for final setup
USER root

# Copy entrypoint scripts
COPY ./docker/entrypoint.sh /entrypoint.sh
COPY ./docker/wait-for-psql.sh /wait-for-psql.sh
RUN chmod +x /entrypoint.sh /wait-for-psql.sh

# Set ownership
RUN chown -R odoo:odoo /opt/odoo

# Switch to odoo user
USER odoo

# Set working directory
WORKDIR /opt/odoo/custom-addons

# Expose Odoo ports
EXPOSE 8069 8072 5678

# Set environment variables
ENV ODOO_RC=/etc/odoo/odoo.conf
ENV PATH="/opt/odoo/.local/bin:${PATH}"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["python3", "/opt/odoo/odoo/odoo-bin"]

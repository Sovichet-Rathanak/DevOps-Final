FROM php:8.2-fpm

# Install system dependencies + SSH
RUN apt update && apt install -y \
    unzip curl git nodejs npm libzip-dev \
    openssh-server

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# SSH config
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN rm -rf /var/www/*
RUN composer create-project laravel/laravel /var/www/laravel

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set working directory
WORKDIR /var/www

CMD ["/start.sh"]

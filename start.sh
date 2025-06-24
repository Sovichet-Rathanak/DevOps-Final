#!/bin/bash
# Start SSH server
/usr/sbin/sshd

# Start PHP-FPM in the foreground (important for container to keep running)
php-fpm

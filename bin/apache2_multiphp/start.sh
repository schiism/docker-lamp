#!/bin/bash
sed -i 's/user = www-data/user = www/g' /etc/php/5.6/fpm/pool.d/www.conf
sed -i 's/user = www-data/user = www/g' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/user = www-data/user = www/g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/5.6/fpm/pool.d/www.conf
sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=www/g' /etc/apache2/envvars
/usr/sbin/service php5.6-fpm start
/usr/sbin/service php7.2-fpm start
/usr/sbin/service php7.4-fpm start
/usr/sbin/service apache2 start
sudo -u www -H sh -c "git config --global credential.helper store;
cat > /var/www/.git-credentials <<EOF
http://USER:PASSWORD@gitlab.nextup.cloud
https://USER:PASSWORD@gitlab.nextup.cloud
EOF
"
sh -c "echo 'alias ll=\"ls -la --color -I .DS_Store\"' >> /var/www/.bashrc"
sh -c "chown www:www /var/www/.bashrc"
tail -f /dev/null
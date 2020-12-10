#!/usr/bin/env bash

if [ "0" == "${IS_XDEBUG_ENABLED}" ]
then
    sudo rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

set -e

RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${RED}Please, wait until MySQL wakes up${NC}"

set -e

while ! mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD" -e 'show databases;'; do
  >&2 echo "MySQL is unavailable - sleeping. Please wait"
  sleep 15
done

>&2 echo "MySQL is up - executing command"

if [ ! -f /var/www/source/app/etc/env.php ]; then
#	 wait some time to make sure mysql server is up & running
	sleep 5

	echo "Create databases"
    mysql -u${MYSQL_USER} -p"${MYSQL_ROOT_PASSWORD}" -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET UTF8; \
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

  echo "Install magento"

  cd /var/www/source;
  php /usr/local/bin/composer install

	php /var/www/source/bin/magento setup:install \
	  --base-url=$MAGENTO_URL \
	  --backend-frontname=$MAGENTO_BACKEND_FRONTNAME \
	  --language=$MAGENTO_LANGUAGE \
	  --currency=$MAGENTO_DEFAULT_CURRENCY \
	  --db-host=$MYSQL_HOST \
	  --db-name=$MYSQL_DATABASE \
	  --db-user=$MYSQL_USER \
	  --db-password=$MYSQL_ROOT_PASSWORD \
	  --use-secure=$MAGENTO_USE_SECURE \
	  --base-url-secure=$MAGENTO_BASE_URL_SECURE \
	  --use-secure-admin=$MAGENTO_USE_SECURE_ADMIN \
	  --use-rewrites=$MAGENTO_USE_REWRITES \
	  --admin-firstname=$MAGENTO_ADMIN_FIRSTNAME \
	  --admin-lastname=$MAGENTO_ADMIN_LASTNAME \
	  --admin-email=$MAGENTO_ADMIN_EMAIL \
	  --admin-user=$MAGENTO_ADMIN_USERNAME \
	  --admin-password=$MAGENTO_ADMIN_PASSWORD \
	  --session-save=redis \
	  --session-save-redis-host=$MAGENTO_SESSION_REDIS_HOST \
	  --session-save-redis-port=$MAGENTO_REDIS_PORT \
	  --session-save-redis-timeout=$MAGENTO_REDIS_TIMEOUT \
	  --session-save-redis-db=$MAGENTO_SESSION_REDIS_DB \
	  --session-save-redis-compression-threshold=$MAGENTO_SESSION_REDIS_COMPRESSION_THRESHOLD \
	  --session-save-redis-compression-lib=$MAGENTO_SESSION_REDIS_COMPRESSION_LIB \
	  --session-save-redis-log-level=$MAGENTO_SESSION_REDIS_LOG_LEVEL \
	  --session-save-redis-max-concurrency=$MAGENTO_SESSION_REDIS_MAX_CONCURRENCY \
	  --session-save-redis-break-after-frontend=$MAGENTO_SESSION_REDIS_BREAK_AFTER_FRONTEND \
	  --session-save-redis-break-after-adminhtml=$MAGENTO_SESSION_REDIS_BREAK_AFTER_ADMINHTML \
	  --session-save-redis-first-lifetime=$MAGENTO_SESSION_REDIS_FIRST_LIFETIME \
	  --session-save-redis-bot-first-lifetime=$MAGENTO_SESSION_REDIS_BOT_FIRST_LIFETIME \
	  --session-save-redis-bot-lifetime=$MAGENTO_SESSION_REDIS_BOT_LIFETIME \
	  --session-save-redis-disable-locking=$MAGENTO_SESSION_REDIS_DISABLE_LOCKING \
	  --session-save-redis-min-lifetime=$MAGENTO_SESSION_REDIS_MIN_LIFETIME \
	  --session-save-redis-max-lifetime=$MAGENTO_SESSION_REDIS_MAX_LIFETIME \
	  --cache-backend=redis \
	  --cache-backend-redis-server=$MAGENTO_CACHE_BACKEND_REDIS_SERVER \
	  --cache-backend-redis-db=$MAGENTO_CACHE_BACKEND_REDIS_DB \
	  --cache-backend-redis-port=$MAGENTO_REDIS_PORT \
	  --page-cache=redis \
	  --page-cache-redis-server=$MAGENTO_PAGE_CACHE_REDIS_SERVER \
	  --page-cache-redis-db=$MAGENTO_PAGE_CACHE_REDIS_DB \
	  --page-cache-redis-port=$MAGENTO_REDIS_PORT \
	  --page-cache-redis-compress-data=$MAGENTO_PAGE_CACHE_REDIS_COMPRESS_DATA \
	  --amqp-host=$RABBITMQ_HOST \
	  --amqp-port=$RABBITMQ_PORT \
	  --amqp-user=$RABBITMQ_DEFAULT_USER \
	  --amqp-password=$RABBITMQ_DEFAULT_PASS
fi

composer global require --dev mage2tv/magento-cache-clean;
composer global require --dev magento-ecg/coding-standard
composer global require --dev magento/magento-coding-standard

exec "$@"

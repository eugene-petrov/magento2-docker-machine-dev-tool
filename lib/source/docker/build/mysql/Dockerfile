FROM mysql:5.7

RUN echo "[mysqld]" >> /etc/mysql/my.cnf && \
    echo "innodb_buffer_pool_size=512M" >> /etc/mysql/my.cnf && \
    echo "innodb_log_file_size=512M" >> /etc/mysql/my.cnf && \
    echo "innodb_log_buffer_size=8M" >> /etc/mysql/my.cnf && \
    echo "innodb_flush_log_at_trx_commit=2" >> /etc/mysql/my.cnf && \
    echo "query_cache_size=64M" >> /etc/mysql/my.cnf && \
    echo "max_connections=256" >> /etc/mysql/my.cnf

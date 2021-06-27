FROM php:7.4-cli

# change timezone from UTC to KST
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# install extension
RUN apt-get update && \
    apt-get install -y libzip-dev unzip git ssh && \
    apt-get -y --no-install-recommends install g++ zlib1g-dev && \
    docker-php-ext-install opcache && \
	docker-php-ext-install zip && \
	docker-php-ext-install pdo_mysql && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# install extension
RUN pecl install redis && docker-php-ext-enable redis && \
    pecl install grpc && docker-php-ext-enable grpc && \
    pecl install protobuf && docker-php-ext-enable protobuf
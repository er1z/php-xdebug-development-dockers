build:
	cd php && docker build . -t php-fpm
	cd nginx && docker build . -t nginx

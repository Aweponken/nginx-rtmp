FROM alpine:latest

ENV NGINX_VERSION 1.13.7

# Prereqs
RUN	apk update		&&	\
	apk add				\
		gcc			\
		binutils-libs		\
		binutils		\
		gmp			\
		isl			\
		libgomp			\
		libatomic		\
		libgcc			\
		openssl			\
		pkgconf			\
		pkgconfig		\
		mpfr3			\
		mpc1			\
		libstdc++		\
		ca-certificates		\
		libssh2			\
		curl			\
		expat			\
		pcre			\
		musl-dev		\
		libc-dev		\
		pcre-dev		\
		zlib-dev		\
		openssl-dev		\
		make			

# Download and install nginx and RTMP module
RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz			&&	\ 
 	wget https://github.com/arut/nginx-rtmp-module/archive/master.zip		&&	\
	tar -zxvf nginx-${NGINX_VERSION}.tar.gz						&&	\
 	unzip master.zip								&&	\
	cd nginx-${NGINX_VERSION} 							&& 	\
	./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master 	&&	\
	make 										&& 	\
 	make install

# Create config 
RUN	echo "rtmp {" >> /usr/local/nginx/conf/nginx.conf				&&	\
	echo "	server {" >> /usr/local/nginx/conf/nginx.conf				&&	\
	echo "		listen 1935;" >> /usr/local/nginx/conf/nginx.conf		&&	\
	echo "		chunk_size 4096;" >> /usr/local/nginx/conf/nginx.conf		&&	\
	echo "		application live {" >> /usr/local/nginx/conf/nginx.conf		&&	\
	echo "			live on;" >> /usr/local/nginx/conf/nginx.conf		&&	\
	echo "			record off;" >> /usr/local/nginx/conf/nginx.conf	&&	\
	echo "		}" >> /usr/local/nginx/conf/nginx.conf				&&	\
	echo "	}" >> /usr/local/nginx/conf/nginx.conf					&&	\
	echo "}" >> /usr/local/nginx/conf/nginx.conf

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

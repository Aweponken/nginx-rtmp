# Docker RTMP server
## Prereqs
In order to run the image, [Docker](https://www.docker.com/) is reqiured.
## Setup
There are two ways of downloading the images.
**Recommended build:** the easiest way is to pull it directly from docker hub by running:   
```docker pull aweponken/nginx-rtmp```

**Manual build:** if you want to build it your self you can clone this repo and then build the docker by running the following commands:
* ```git clone https://github.com/Aweponken/docker-nginx-rtmp.git```
* ```cd docker-nginx-rtmp ```
* ```docker build -t docker-nginx-rtmp . ```

### Configurations
This image exposes port 1935 for RTMP Steams and has 1 channel open: "live".
The configuration file can be found in ```/usr/local/nginx/conf/nginx.conf```

### Running
To run the container and bind the port 1935 to the host machine; run the following:   
```docker run -p 1935:1935 -p 8080:8080 aweponken/nginx-rtmp```

### OBS Configuration
Under broadcast settigns, set the follwing parameters:
```
Streaming Service: Custom
Server: rtmp://<your server ip>/live
Play Path/Stream Key: test
```

### Watching the steam
In your favorite RTMP video player connect to the stream using the URL:
```
rtmp://<your server ip>/live/test
```

## Credits
Big thanks to: 
* [André 'MG' Wisén](http://andrewisen.se/) for helping out with the installation steps. 
* [Jason Rivers](https://github.com/JasonRivers/Docker-nginx-rtmp/) for supplying an awesome GitHub repo.

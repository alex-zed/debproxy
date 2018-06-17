docker-acestream
=========================

Debian based docker image for acestream.

![logo-text-test](https://user-images.githubusercontent.com/24189833/36645710-3deca456-1a6d-11e8-8bf0-84f078703d8d.png) (v3.1.31)&#174; https://web.telegram.org/#/im?p=@AceStreamMOD 

### usage
```
docker run \
--privileged \
-d \
-e PUID=0 \
-e PGID=0 \
--net=host \
--name=ace86 \
-e TZ=Europe/Berlin \
sybdata/ace86u18 bash -c "./start.sh 600"
```
 #### где:

* 600 - Время очистки кеша acestream в секундах
* TZ='timezone'

![918d1](https://user-images.githubusercontent.com/24189833/41502186-9be8d11c-71b4-11e8-8777-184d3f20589c.png)









docker-acestream
=========================

Debian based docker image for ![logo-text-test](https://user-images.githubusercontent.com/24189833/36645710-3deca456-1a6d-11e8-8bf0-84f078703d8d.png) (v3.1.31)&#174; https://web.telegram.org/#/im?p=@AceStreamMOD .



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
sybdata/debproxy bash -c "/usr/bin/start.sh 600"
```
 #### где:

* 600 - Время очистки кеша acestream в секундах
* TZ='timezone'

![918f1a](https://user-images.githubusercontent.com/24189833/41553984-b0c70dd0-7333-11e8-8091-1303fde6e2c3.png)

![918f](https://user-images.githubusercontent.com/24189833/41535293-0f2c632a-7302-11e8-8e63-fc7f507c6c5f.png)











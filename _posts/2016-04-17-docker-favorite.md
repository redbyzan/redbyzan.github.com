---
layout: post
title: Docker 자주쓰는 명령어
subtitle: 도커를 사용하며 자주사용하게 되는 명령어 
date:       2016-04-17 12:00:00
author:     "redbyzan"
header-img: "img/blog/header/header-docker.jpeg"
thumbnail: /img/blog/thumbs/thumb-docker.png
tags: [docker]
categories: [docker]
---


### Docker 명령어

도커를 사용하며 자주 사용했던 명령어들을 정리 해 보았습니다.

도커관련은 주로 [이재홍님의 블로그](http://pyrasis.com/docker.html)를 참고했습니다.
 
---

**Docker Hub push**

docker 이미지를 생성 후 docker hub 에 push 하기 위해선 아래와 같은 작업을 거쳐야 합니다.

```
docker images
docker tag <이미지명:태그> <hub 계정명>/<hub 레파지토리명> 으로 hub로 올릴 이미지를 복사 합니다.
예시) docker tag dev-web:0.2 rogerjo/dev-web
     docker push rogerjo/dev-web 명령으로 도커허브에 이미지를 push합니다.
```

---

**docker 이미지 목록 조회**

```
docker images
```

<br/>

**docker run**

> docker run <옵션> <이미지 이름> <실행할 파일>

> docker 이미지 run을 통해 컨테이너 생성과 함께 컨테이너 시작. 마지막엔 실행시킬 이미지명:태그를 입력합니다.

> -i(interactive), -t(Pseudo-tty) 옵션을 사용하면 실행된 Bash 셸에 입력 및 출력을 할 수 있습니다.

> --name 옵션으로 컨테이너의 이름을 지정할 수 있습니다. 이름을 지정하지 않으면 Docker가 자동으로 이름을 생성하여 지정합니다.

> -d 옵션은 컨테이너를 백그라운드로 실행시키는 옵션입니다. 컨테이너 접속 후 해제하여도 컨테이너가 종료되지 않게 합니다.

> -p 옵션으로 호스트 포트와 컨테이너 포트를 연결 합니다. -p 옵션을 추가하여 여러개의 포트를 연결할 수 있습니다. -p <host port> : <container port>

```
docker run -i -t -d -p 80:80 -p 443:443 -p 8080:8080 --name dev-web dev-web:0.4
```
<br/>

**docker 컨테이너 목록 조회**

> 현재 실행중인 컨테이너 목록

```
docker ps
```

> 생성한 전체 컨테이너 목록

```
docker ps -a
```

<br/>

**docker 실행**

> docker start 컨테이너 명. 위의 생성한 예시문을 활용하여 해당 컨테이너를 실행 시키겠습니다.

```
docker start dev-web
```

<br/>

**docker 컨테이너 접속**

```
docker attach dev-web
```

***attach로 접속 시 컨테이너 접속을 종료할때는 반드시 아래의 명령을 실행해야 한다***
```
Ctrl + p + q
```
그냥 일반적 쉘 종료로 사용하는 'exit' 명령을 사용하면 실행중이던 컨테이너는 종료됩니다.

<br/>

**docker exec 접속**

> exec 로 접속 했을땐 'exit' 명령어로 접속을 해제 하여도 도커 컨테이너가 중지되지 않습니다.

```
docker exec -it [컨테이너명] su - ubuntu 
```





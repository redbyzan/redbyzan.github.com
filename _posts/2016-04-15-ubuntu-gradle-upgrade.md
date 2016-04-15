---
layout: post
title: ubuntu gradle upgrade
subtitle: 우분투에서 gradle build 오류 발생 대처하기 
date:       2016-04-15 15:00:00
author: "redbyzan"
header-img: "img/blog/header/header-ubuntu.jpeg"
thumbnail: /img/blog/thumbs/thumb-gradle.jpeg
tags: [npm]
categories: [ubuntu]
---

spring-boot프로젝트의 빌드를 위해 gradle build 명령문 실행 시 오류가 발생 하였습니다.

원인은 우분투 apt-get 을 통해 gradle을 설치하면 저장소가 갱신되지 않은 형태에서는 gradle 버전이 1.4였음을 확인하여
 
ubuntu gradle upgrade를 통해 gradle 버전을 업그레이드 하였습니다.

**아래의 명령문을 통해 레파지토리를 업데이트 합니다**

```
sudo add-apt-repository ppa:cwchien/gradle
sudo apt-get update
```

<br/>
**아래 명령으로 버전을 명시하여 설치 하거나**

```
sudo apt-get install gradle-2.2
```

<br/>

**아래 명령으로 최신버전을 설치합니다**

```
sudo apt-get install gradle-ppa
```
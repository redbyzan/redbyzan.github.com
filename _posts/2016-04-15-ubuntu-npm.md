---
layout: post
title: 우분투에서 npm install 오류 해결
subtitle: apt-get을 통한 오류 해결 
date:       2016-04-15 12:00:00
author:     "redbyzan"
header-img: "img/blog/header/header-ubuntu.jpeg"
thumbnail: /img/blog/thumbs/thumb-npm.png
tags: [npm]
categories: [ubuntu]
---


### npm error
로컬 환경에 맞는 node 버전을 설치 후 npm install 오류 가 발생할 수 있습니다. 

오류 문구 중 stack Error: not found: make
 
위와 같은 문구를 만난다면 [여기](http://stackoverflow.com/questions/14772508/npm-failed-to-install-time-with-make-not-found-error)를 통해 해결 할 수 있습니다.

---

```
sudo apt-get install -y build-essential
```

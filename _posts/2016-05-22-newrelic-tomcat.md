---
layout: post
title: NewRelic 서비스 도입하기
subtitle: tomcat에 newrelic 에이전트 설치하기 
date:       2016-05-22 12:00:00
author:     "redbyzan"
header-img: "img/blog/header/header-newrelic.jpg"
thumbnail: /img/blog/thumbs/thumb-newrelic.jpg
tags: [newrelic]
categories: [dev]

---

### NewRelic 서비스 도입하기

> 서비스 운영중 서비스의 병목현상 및 운영모니터링에 관한 필요성이 느껴져 도입을 고민하던중 

> 그전부터 지켜봐 오던 서비스인 newrelic을 도입하였습니다.

> 도입 후 실제 사용에 관한 능력이 더욱 중요함을 알게 되었으며, 사용에 관한 포스팅은 추후에 올리도록 하며
 이글에선 도입과정에 관한 글을 포스팅 합니다.
 
---

***newrelic은 여러가지 서비스를 제공하지만 이 글에선 APM에 관한 글을 포스팅합니다.***

### newrelic 사이트 가입하기

먼저 [사이트에 접속](https://newrelic.com)합니다. 회원가입을 거친 후 상단 메뉴중 APM을 선택합니다.

1. 현재 서비스 중인 서버는 tomcat 이므로 Java 아이콘을 클릭합니다.<br/><br/>
![java에이전트](/img/blog/newrelic/step1.png)<br/><br/>

2. 위의 그림에 나와있는 1번 항목의 버튼을 클릭하면 라이센스키를 발급 해 줍니다.

3. APM의 경우 에이전트를 다운받아서 서버의 루트폴더에서 서비스를 제공하는 형태입니다. 에이전트를 다운로드 받으면 zip파일이 다운로드 됩니다.

4. 설치할 환경을 선택합니다. 여기선 `Linux or Mac` 을 선택하였습니다.
 이부분에서 저는 좀 헤깔렸습니다. +_+ 설명에 따르면 
```
 unzip newrelic-java-3.28.0.zip -d /path/to/appserver/
```
 위와같이 압축을 앱서버폴더 밑에 해제 후 
```
 cd /path/to/appserver/newrelic
 java -jar newrelic.jar install
```
 newrelic을 설치하라고 나와있지만 영어를 읽지못해 어렵더군요 ㅠ
 이제 제가 해결한 방법을 설명 드리자면 톰켓이 설치된 경로에 newrelic 폴더를 만들고 폴더하위에 newrelic파일을 위치 시킨 후 톰켓을 재시작하면 됩니다.
 현재 환경은 ~/tomcat9이 설치된 폴더이므로 ~/tomcat9/newrelic폴더에 압축해제한 파일을 위치한 후 톰캣을 재 시작하면 newrelic 이 모니터링을 시작합니다.
 
5. 4번항목의 설치대로 진행 후 newrelic폴더 하위에 위치한 설정파일을 수정 후 톰캣을 재 시작하면 완료 됩니다.
설정 파일의 이름은 ***newrelic.yml***입니다. 해당 파일에서 라이센스키와 어플리케이션 이름을 수정 한 후 적용하시면 됩니다.
```
license_key: '<%= license_key %>'
app_name: My Application
```
위의 부분을
```
license_key: '발급받은 라이센스 키'
app_name: 나의 어플리케이션 이름
```
으로 변경 하시면 newrelic 대시보드에서 확인 하실 수 있습니다.

6. 톰캣 재 시작 후 [newrelic 대시보드](https://rpm.newrelic.com)에 접속하시면 APM탭이 활성화 된 후 화면에 나의 어플리케이션이 목록에 나올 것 입니다.
나의 어플리케이션을 선택 한 후 대시보드로 들어가시면 모니터링 정보를 확인 할 수 있습니다.모니터링에 관한 상세내용은 추후 포스팅 하도록 하겠습니다.

7. 여러 어플레케이션을 서비스 중이라면 우측상단에 ***Add more*** 버튼을 클릭하여 동일한 방법으로 설정합니다.









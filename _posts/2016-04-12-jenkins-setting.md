---
layout: post
title: 우분투 서버에 젠킨스 구축하기
subtitle: 젠킨스 구축하기
date:       2016-04-12 12:00:00
author:     "redbyzan"
header-img: "img/blog/header/jenkins-header.jpeg"
thumbnail: /img/blog/thumbs/thumb-jenkins.png
tags: [jenkins]
categories: [dev]
require: 'jekyll-utf8'
---

> 현재 근무중인 회사에서 제작하는 제품들이 많아짐에 따라 통합관리툴의 필요성을 느꼈습니다.

> 구축된 젠킨스의 빌드는 수동으로 빌드를 시작하면 소스코드 저장소에서 소스를 다운받아 
 
> 각 환경에 맞는 ( front-end : gulp, back-end : gradle ) 빌드 스크립트를 수행 한 후 배포하는 단계로 구성 되어있습니다.

---


### 1. 설치파일

현재 구축된 시스템은 아마존 EC2 우분투OS위에 도커컨테이너로 서비스 되고 있습니다. 우분투 기준으로 설명 하겠습니다.

먼저 [젠킨스 홈페이지](https://jenkins.io/index.html)에 접속합니다. <br/>
아래 그림과 같이 OS에 맞는 설치파일의 다운로드 링크를 클릭힙니다. 클릭하면 설치가이드 페이지로 이동합니다. <br/>
![젠킨스 다운로드](/img/blog/jenkins-setting/jenkins-download.png)

---


### 2. 설치명령

jenkins계정으로 sudo 명령어를 사용하기 위해 

/etc/sudoers 파일에 jenkins계정을 추가합니다.

```
sudo wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
```

```
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
```

```
sudo apt-get update && sudo apt-get install -y jenkins
sudo echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
```

---


### 3. 젠킨스 포트변경

apt-get으로 설치하게되면 jenkins계정이 생성됩니다. 젠킨스의 홈 디렉토리는 /var/lib/jenkins 일 것입니다.

젠킨스는 내부적으로 톰캣을 서버로 사용하므로 설치 후 시작하면 톰캣 기본포트인 8080을 사용하며 시작됩니다.

젠킨스를 다른 톰캣과 구동하기 위해선 기본포트를 변경 할 필요가 있습니다.

젠킨스의 설정파일은 /etc/default/jenkins 이며 [링크](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu)를 참고하였습니다.

포트를 변경 한 후 sudo service jenkins restart 명령을 통해 재시작하면 적용됩니다.

```
sudo vi /etc/default/jenkins
// port 부분을 변경합니다.
HTTP_PORT=8080 -> HTTP_PORT=9999
```
<br/>
##### 2016-05-10 추가
젠킨스와 다른 톰캣을 한 서버에서 서비스할때 nginx 에서 proxy_pass를 적용하려던 차에 젠킨스의 

기본 주소를 / 가 아닌 /jenkins로 변경하려는 요구가 있었습니다.

위에 설명한 동일 파일에 하단에 내려가보면 ```PRIFIX=$NAME```으로 선언된 변수가 있습니다. 

기본적으로 ```$NAME=jenkins```이며 

```
JENKINS_ARGS="--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX"
```

위와 같이 ```--prefix``` 부분을 추가하면 젠킨스의 기본 주소를 변경할 수 있습니다.

---



### 4. 젠킨스 계정생성


젠킨스사이트를 실행 시킨 후 접속하면 계정정보가 없어 anonymous로 접속이 됩니다. 

사이트 관리자를 생성 하기 위해선 사이트의 왼쪽 메뉴중 jenkins관리를 선택한 후 오른편의 Configure Global Security 메뉴를 선택합니다.
 
![젠킨스 계정생성](/img/blog/jenkins-setting/젠킨스-계정생성.png)

---
**위의 페이지로 접근한 후**

1. Enable security 항목을 활성화 합니다.
2. 오른편의 Security Realm 항목의 Jenkins' own user database 를 활성화 한 후 <br/>하단의 사용자의 가입 허용을 활성화 합니다.
3. 그림에서 저는 admin 계정을 추가 하였습니다. User/group to add 항목에 신규 사용자의 아이디를 입력 후 <br/>Add 버튼을 클릭하여 등록합니다.
4. 그림에는 나와있지 않지만 Add 버튼을 클릭하면 버튼위의 표에 입력한 유저가 등록되며 해당 표의 맨 오른쪽 끝 부분에 <br/>전체항목 선택 버튼을 클릭하면 모든 권한을 가진 유저로 등록 됩니다.
5. 권한 부여까지 마쳤으면 하단에 Save 버튼을 클릭하여 저장합니다.

![젠킨스 계정생성2](/img/blog/jenkins-setting/젠킨스-계정생성2.png)

---

**등록한 사용자 활성화**

계정을 등록 하였지만 바로 사용가능한 것은 아니며 이제 젠킨스 메인페이지에서 오른쪽 상단에 가입 버튼을 클릭하여 해당 계정을 <br/>활성화 하는 과정이 필요합니다.

1. 등록한 사용자 계정명을 입력합니다.
2. 해당 계정의 비밀번호를 입력합니다.
3. 정보를 모두 기입 한 후 Sign up 버튼을 클릭하여 계정을 활성화 시킵니다.

* **트러블슈팅**
    - 페이지 작성 도중 개발서버에 올려둔 Mr.젠킨스 ( 개발서버로 올린 젠킨스 서버입니다. 향후 헷갈리지 않기위해 임의로 부르기로 합니다. :smile: ) 가 
    계정설정 정보관련 충돌로 인해 접근이 되지 않는 현상이 발견되었습니다. <br/>
   [젠킨스 홈 폴더의 config.xml 부분을 수정하여 해결 하였습니다.](https://wiki.jenkins-ci.org/display/JENKINS/Disable+security) 
   
---


### 5. 젠킨스 플러그인 설치

> 젠킨스의 플러그인 설치로 원하는 빌드환경을 구성 할 수 있습니다. 

현재 저희 회사 관리자 사이트의 전체적인 시스템을 간략히 설명 드리자면<br/> 소스코드 컨트롤은 Git, 저장소는 Bitbucket, back-end 빌드 시스템은 gradle, front-end 빌드 시스템은 gulp로 구성 되어있습니다. 

1. 젠킨스 메인화면 왼쪽의 Jenkins 관리 메뉴를 클릭합니다.
2. 오른편의 플러그인 관리 메뉴를 클릭합니다.
3. 설치가능 탭을 클릭한 후 오른쪽 필터 부분에 원하는 플러그인 이름을 검색합니다.
4. 검색한 플러그인들을 선택 한 후 하단의 재시작 없이 설치하기 버튼을 클릭하여 젠킨스에 적용되도록 합니다.
    ![젠킨스 플러그인 설치](/img/blog/jenkins-setting/젠킨스-플러그인-설치.png)<br/>
5. 현재 Mr.젠킨스에 사용중인 플러그인은 Git, Bitbucket, Gradle, Publish Over SSH 입니다.
    ![젠킨스 플러그인 설치](/img/blog/jenkins-setting/젠킨스-플러그인-bitbucket.png)
    ![젠킨스 플러그인 설치](/img/blog/jenkins-setting/젠킨스-플러그인-gradle.png)
    ![젠킨스 플러그인 설치](/img/blog/jenkins-setting/젠킨스-플러그인-SSH.png)



---

### 6. 젠킨스 플러그인 설정

자, 이제 플러그인 설치가 완료 되었으면 사용가능 하게끔 설정을 하도록 하겠습니다.

1. Jenkins 관리 메뉴를 클릭한 후 시스템 설정 메뉴페이지로 들어갑니다.
2. 젠킨스는 Java 기반의 시스템이므로 JDK설정이 필요합니다. OS에 설치된 JDK경로를 설정합니다. <br/>Java가 설치되지 않았다면 Install automatically 항목을 활성화하여 설치합니다.
    ![젠킨스 플러그인 설정](/img/blog/jenkins-setting/젠킨스-JDK설치.png) <br/>
3. Gradle 경로를 설정합니다. Gradle 은 Maven 저장소를 이용하므로 Maven 설정도 같이 합니다.
    ![젠킨스 플러그인 설정](/img/blog/jenkins-setting/젠킨스-Maven설정.png) 
    ![젠킨스 플러그인 설정](/img/blog/jenkins-setting/젠킨스-Gradle설정.png) <br/>
4. 현재 저희 회사 관리자 사이트는 아마존 클라우드를 사용하므로 로컬에서 아마존으로 접속하기위한 <br/>key.pem 키를 이용한 접속을 설정 합니다.
<br/>Hostname 항목엔 자신의 서버 주소를 입력합니다. 도메인 혹은 IP로 설정할 수 있습니다.
    ![젠킨스 플러그인 설정](/img/blog/jenkins-setting/젠킨스-POSSH설정.png) <br/>
5. 마지막으로 소스코드 저장소인 Bitbucket 로그인 설정정보를 입력합니다.
    ![젠킨스 플러그인 설정](/img/blog/jenkins-setting/젠킨스-Bitbucket설정.png) <br/>
6. 설명하지 않은 항목은 기본설정으로 합니다.

---

### 7. 젠킨스 새로운 Item등록

> Mr.젠킨스가 일 할 준비가 되었습니다. 이제 일을 시키겠습니다.

1. 새로운 Item을 클릭하여 Mr.젠킨스가 할 일의 이름을 지정합니다.
<br/>Item의 위치는 젠킨스 홈 폴더의 workspace에 해당 이름의 폴더로 생성되며 소스코드가 위치합니다.<br/>
    예) ~/jobs/\[Item이름\]/workspace
2. Freestyle projet를 클릭합니다.
3. 소스코드 관리 부분에 Git을 클릭하여 활성화 한 후 저장소의 URL을 입력합니다. <br/>
   입력 한 후 Credentials 부분에 Add 버튼을 클릭하여 접속정보를 입력합니다.<br/>
   Repository Url 항목엔 저장소의 ssh 주소를 입력합니다.<br/>
   ![젠킨스 Item 저장소 설정](/img/blog/jenkins-setting/아이템1-소스코드관리설정.png) <br/>
   Kind 는 Username with password 를 선택합니다. <br/>
   Scope은 개별설정 가능합니다. ( 여기선 Global을 선택하였습니다. ) <br/>
   소스코드 저장소의 Username, Password를 입력합니다. <br/>
   ![젠킨스 Item 계정추가](/img/blog/jenkins-setting/아이템2-계정추가.png)
    * **트러블 슈팅** <br>
          최초엔 접속정보만으로 저장소로 접근할 수 있는줄 알았습니다만 적용해보니 접근이 안되었습니다. <br/> 
          그 이유는 [Bitbucket 로그인 연동하기](http://la-stranger.blogspot.kr/2013/10/unity-os-jenkins-1.html) 블로그에 설명되어 있는 이유였습니다! <br/>
          
        > "Git 원격 저장소에서 파일들을 받아오기 위해서는 Key Pair를 생성할 필요가 있다. <br/>
            Jenkins를 설치하면서 시스템에 생성된 jenkins 계정을 통해 Git repository에 접근하는 것이기 때문에 해당 계정의 Key Pair를 생성하여 Bitbucket(혹은 GitHub)에 등록해야 한다.<br/>
            터미널을 열고 다음과 같이 jenkins 계정의 홈디렉토리에서 key pair를 생성하자."
4. 해당 아이템이 빌드를 할 시점을 설정할 수 있습니다. 그 부분이 빌드 유발부분입니다. <br/>
   다만 이 부분은 Bitbucket의 webhook설정을 통해 Mr.젠킨스가 저장소를 hooking해야 하는데 설정부분이 까다롭고 <br/>아직 제대로된 레퍼런스가 없어서 추후 적용할 예정입니다.<br/> 
   저장소 hooking이 가능하다면 저장소의 소스코드가 push 되는 시점에 Mr.젠킨스는 해당 아이템의 일을 시작할 것 입니다.
    ![젠킨스 Item 저장소 설정](/img/blog/jenkins-setting/아이템3-빌드유발.png) <br/>
5. build 항목의 Add build step 버튼을 클릭하여 빌드 항목을 선택합니다. 여기선 Excute Shell 을 기준으로 설명합니다. 
    ![젠킨스 Item 저장소 설정](/img/blog/jenkins-setting/아이템4-빌드추가.png) <br/>  
6. 해당 아이템의 기준은 front-end를 기준으로 작업되어있으니 front-end빌드 시스템에 맞는 빌드스크립트를 작성합니다. 
    ![젠킨스 Item 저장소 설정](/img/blog/jenkins-setting/아이템5-빌드스크립트.png) <br/>  
    * **트러블 슈팅** <br/>
        gulp build 시 오류가 발생하면 젠킨스의 빌드도 종료하고 싶었으나 젠킨스의 빌드는 성공하는 현상을 발견하여 <br/>
        쉘 스크립트가 오류로 종료되면 젠킨스의 빌드도 오류로 종료하는 방법을 찾아보았습니다.<br/>
        
        > -xe 옵션 추가 하여 쉘 스크립트 오류 시 젠킨스 빌드 실패처리 가능토록 처리 <br/>
          -x 옵션은 실행하는 모든 명령을 출력 <br/>
          -e 옵션은 스크립트의 명령 중 하나가 실패하면 실패로 종료하도록 하는 옵션 <br/>
          
        해당 옵션을 bash shell 옵션에 추가하여 젠킨스에서 쉘 오류 시 error catch가 가능토록 적용 하였습니다.
        
---
<br/><br/><br/><br/>

## end. 맺으며 

간단히 설명하려고 했지만 젠킨스 설정과 아이템 설정을 같이 설명하다보니 글이 길어졌습니다.

젠킨스를 조금 사용해보고 나니, 빌드의 신뢰성 확보를 위해 

gradle 기반에서 작동하는 back-end 를 기준으로 유닛테스트 작성하여 빌드시점에 테스트를 하고 
 
front-end 는 시나리오 테스트를 적용하여 빌드 후 테스트를 적용하고 싶어졌습니다.

추후 기회가 되면 다시 포스팅 하겠습니다.
<br/><br/><br/><br/>
 
---
layout: post
title: 안드로이드 fabric 사용하기
subtitle: fabric 가입부터 설치까지
date:       2016-04-17 18:00:00
author:     "redbyzan"
header-img: "img/blog/header/header-android.jpg"
thumbnail: /img/blog/thumbs/thumb-fabric.png
tags: [fabric]
categories: [android]
---

## [Twitter fabric 이란?](https://blog.twitter.com/ko/2014/introducing-fabric-kr)

crashlytics, answer, digits 등등의 서비스를 모아서 fabric이라는 이름으로 서비스 되고 있는 트위터의 모듈입니다.

이번 포스트에서는 crashlytics를 위주로 설명 하겠습니다.

crashlytics는 사용자가 어플리케이션을 이용하는 도중 알수 없는 오류로 인해 어플리케이션이 강제로 종료될때 시스템 로그를 fabric 대시보드로 전송해주는 서비스 입니다.

### 1. fabric 서비스 가입하기

crashlytics 서비스를 이용하기 위해선 fabric 사이트에서 가입을 해야 합니다.<br/><br/>

1. [fabric 웹사이트 첫 가입화면](https://get.fabric.io)에 접속해서 'Get Started with Fabric' 버튼을 클릭합니다.<br/>
![패브릭 가입](/img/blog/fabric/fabric-sign-up1.png)<br/><br/>
2. 가입에 필요한 정보를 입력합니다.<br/>
![패브릭 가입2](/img/blog/fabric/fabric-sign-up2.png)<br/><br/>
3. 가입을 완료 하고나면 가입 시 입력한 메일주소로 확인 메일이 도착할 것입니다.<br/>
![패브릭 가입2](/img/blog/fabric/fabric-sign-up3.png)<br/><br/>
4. 확인메일의 링크를 클릭하면 fabric 팀을 설정하는 화면이 나옵니다.<br/>자신의 어플리케이션을 관리할 팀 이름을 설정 합니다.<br/>
![패브릭 팀 설정](/img/blog/fabric/fabric-make-team.png)<br/><br/>
5. 팀 이름 설정 후 'Next' 버튼을 클릭하면 fabric을 탑재할 플랫폼을 선택하는 화면이 나옵니다.<br/>여기선 안드로이드 스튜디오를 선택 하겠습니다.<br/>
![패브릭 플랫폼 설정](/img/blog/fabric/fabric-choose-android-studio.png)<br/><br/>
6. 안드로이드 스튜디오를 선택하면 스튜디오 플러그인 설치 이미지가 4장 나옵니다.<br/>사이트 설명에따라 스튜디오에서 플러그인을 설치 합니다.<br/><br/>
7. 이미지 설명을 모두 누르면 아래와 같은 화면이 나옵니다. 사이트에서 할 기본적인 작업은 완료 되었습니다.<br/>이제 안드로이드 어플리케이션을 제작 해 보겠습니다.<br/>
![패브릭 런치 어플리케이션1](/img/blog/fabric/fabric-launch1.png)<br/><br/>

---

### 2. [안드로이드 스튜디오 어플리케이션 제작](https://github.com/redbyzan/FabricApplication.git)

crashlytics 서비스가 탑재된 안드로이드 어플리케이션을 안드로이드 스튜디오에서 제작 해 보겠습니다.

스튜디오 버전은 2.0, 안드로이드 SDK는 4.0.3 기준으로 제작 하겠습니다.<br/><br/>

1. 안드로이드 스튜디오에서 새로운 프로젝트를 생성합니다.
![패브릭 팀 설정](/img/blog/fabric/as-new-prj.png)<br/><br/>
2. 위에 설명한대로 안드로이드 SDK를 선택합니다. 아이스크림샌드위치 SDK 4.0.3을 선택하겠습니다.
![패브릭 팀 설정](/img/blog/fabric/as-new-prj-choose-sdk.png)<br/><br/>
3. 선택하고 나면 기본 템플릿을 선택할 수 있는 화면이 나옵니다. 요새는 Navigation Drawer 화면이 탑재된 어플리케이션이 많으므로 Navigation Drawer 템플릿을 선택합니다.
![패브릭 팀 설정](/img/blog/fabric/as-new-prj-choose-activity.png)<br/><br/>
4. 템플릿을 선택하고 나면 어플리케이션의 메인액티비티를 설정하는 화면이 나옵니다. 기본설정으로 놔두고 'Finish' 버튼을 클릭하여 어플리케이션을 생성 하겠습니다.
![패브릭 팀 설정](/img/blog/fabric/as-new-prj-activity-name.png)<br/><br/>
5. 어플리케이션을 생성 후 최초 런칭한 스크린 샷입니다.
![패브릭 팀 설정](/img/blog/fabric/as-new-prj-phone-screen.png)<br/><br/>

---

### 3. 안드로이드 어플리케이션에 crashlytics 서비스 탑재

fabric 서비스 모듈들은 플러그인을 통해서 개발자가 제작중인 어플리케이션에 모듈 탑재를 보다 쉽게 할 수 있도록 제작되어 있습니다. 
***저도 처음 접했을땐 굉장히 쉬워서 놀랬습니다.***

1. 1-6 항목에서의 설명대로 안드로이드 스튜디오에서 fabric플러그인을 설치했다면 스튜디오 우측상단에 fabric 아이콘이 보일 것입니다. 아이콘을 클릭하여 fabric 화면을 확인합니다.
![패브릭 로그인화면](/img/blog/fabric/as-fabric-login.png)<br/><br/>
    * **트러블 슈팅**
        - 스튜디오에서 다른 fabric 아이디로 로그인 했을 경우 fabric 화면을 활성화 하면 로그인 화면이 나오지 않고 이미 로그인된 화면이 나옵니다. 이때 로그아웃을 위해선 `Ctrl + l` 입력하면 로그아웃 됩니다
        <br/><br/>
        
2. 로그인을 하면 All Kits 리스트 화면이 나옵니다. 리스트에서 Crashlytics 를 선택하면 설치화면으로 이동합니다.
![패브릭 Crashlytics 설치화면](/img/blog/fabric/as-crashlytics.png)<br/><br/>

3. Crashlytics 화면에 접근하면 세개의 버튼이 보입니다. 제일 상단에 있는 Crashlytics를 인스톨합니다.
![패브릭 Crashlytics 설치화면](/img/blog/fabric/as-crashlytics-install.png)<br/><br/>

4. Crashlytics 설치하기 위한 가이드 화면입니다. 여기선 Java 탭을 선택하여 설치하겠습니다. 하위에 있는 3가지탭에 있는 부분이 'Apply' 버튼을 클릭하는 순간 자동으로 우리의 어플리케이션에 반영됩니다! :)
![패브릭 Crashlytics 설치화면](/img/blog/fabric/as-crashlytics-install2.png)<br/><br/>

5. 'Apply' 버튼을 클릭하는 순간 Gradle build 가 실행되면서 변경된 어플리케이션을 다시 빌드합니다.<br/>fabric 화면은 아래와 같이 변경될 것입니다.<br/>이제 두근거리는 마음으로 어플리케이션을 휴대폰으로 빌드 시키면 설치가 완료 됩니다.
![패브릭 Crashlytics 설치화면](/img/blog/fabric/as-fabric-launch.png)<br/><br/>

6. 휴대폰으로 어플리케이션이 빌드되면 1-7 항목에서 설명했던 화면이 바뀔것입니다. 이제 'Go to DashBoard' 버튼을 클릭하여 해당 어플리케이션의 Runtime Exception 을 확인할 수 있습니다.
![패브릭 Crashlytics 설치화면](/img/blog/fabric/fabric-launch2.png)<br/><br/>

---

### 4. fabric dashboard

어플리케이션이 처음 실행 될때 앱내부에서 fabric 대시보드로 앱의 상태를 전송하여 fabric 서비스가 탑재되었음을 알려주는 형태인것 같습니다.
 
fabric 에서는 어플리케이션의 탑재된 API 키를 체크하여 대시보드를 활성화 합니다.

1. 활성화된 대시보드 화면 입니다. 앱 실행중 오류가 발생했다면 아래와 같은 보고서가 올라옵니다.
![패브릭 대시보드](/img/blog/fabric/fabric-crash-list.png)<br/><br/>

2. 리스트를 클릭하면 실행한 디바이스, OS등을 확인 할 수 있는 대시보드 화면과 함께 상세로그를 확인할 수 있는 리스트가 보입니다.
그림에서 보는바와 같이 어느 패키지의 어떤 클래스의 몇번째 라인에서 오류가 났는지 보입니다. :)
![패브릭 대시보드](/img/blog/fabric/fabric-crash-list2.png)<br/><br/>

3. 리스트 오른쪽에 있는 '</>raw' 버튼을 클릭하면 마치 logcat 으로 보는것같은 로그화면이 나옵니다. *<small>하앍</small>*
![패브릭 대시보드](/img/blog/fabric/fabric-crash-list3.png)<br/><br/>

이제 우리는 앱을 스토어에 런칭하고 나서 눈감고있는 듯한 느낌은 어느정도 해소할 수 있게 되었습니다. 

사용자들의 제보가 아니더라도 크리티컬한 문제는 fabric이 알려줄테니까요.

포스트에서 제작한 어플리케이션은 [저의 깃헙 저장소](https://github.com/redbyzan/FabricApplication.git)에 올려두었습니다.

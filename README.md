
# 마인미

![https://user-images.githubusercontent.com/63739061/229878836-95af9bdf-0cb4-4c19-aa80-4c61265bb83b.png](https://user-images.githubusercontent.com/63739061/229878836-95af9bdf-0cb4-4c19-aa80-4c61265bb83b.png)

## 🌸 프로젝트 소개

소중한 연인과의 추억을 기록해 보세요 🥰

위치와 날짜를 기반으로 사진을 기록해요 😎

위치와 날짜를 기반으로 추억을 모아볼 수 있어요 ☺

## 👩‍💻 개발자

<div align="center">

| iOS | AOS | BE | BE |
| --- | --- | --- | --- |
| [김민령](https://github.com/sladuf) | [김도우](https://github.com/KDW03) | [이주원](https://github.com/jujuwon) | [정금종](https://github.com/Floodnut) |

</div>

## 🎯 개발환경

<div align="center">
    <img src="https://img.shields.io/badge/swift-5.8-F05138.svg?style=flat&logo=Swift">
    <img src="https://img.shields.io/badge/Xcode-14.3-white.svg?style=flat&logo=XCode">
    <img src="https://img.shields.io/badge/14+-000000.svg?style=flat&logo=iOS">
</div>

## 🛠️ 아키텍처

<div align="center">
  
### MVVM-C 아키텍처

![https://user-images.githubusercontent.com/63739061/229881328-e125e767-5bdc-4754-832e-f64a3cbbefcd.png](https://user-images.githubusercontent.com/63739061/229881328-e125e767-5bdc-4754-832e-f64a3cbbefcd.png)

</div>

> ViewController의 책임을 분리하고자 MVVM-C 를 도입하게 되었습니다.

> View에 사용되는 데이터의 관리를 ViewModel이 하도록 역할을 분리함으로써 코드의 가독성을 향상시켰습니다.

> TabBar, Naviagtion 사용 등으로 화면 전환이 많아지고, ViewController 간 의존성이 높아짐에 따라, 화면전환 로직 분리의 필요성을 느껴 Coordinator 패턴을 도입했습니다.


## 🪧 모듈구조

<div align="center">
  
![https://user-images.githubusercontent.com/63739061/229881585-810dc652-5b26-4a28-9975-6674c26c0119.png](https://user-images.githubusercontent.com/63739061/229881585-810dc652-5b26-4a28-9975-6674c26c0119.png)

</div>

> 모듈 간 레벨을 만들어 하위 레벨의 모듈만 접근 가능하도록 설계 했습니다.

> 기능별로 모듈을 만들어 기능별로 확장과 유지보수가 용이하도록 설계 했습니다.

> 공통으로 사용하는 UI나 비지니스 로직을 Common 모듈에서 관리하고, 상위 레벨 Common모듈의 코드를 사용하여 중복을 줄였습니다.

## 📚 트러블슈팅

- [기본적인 틀이 항상 같은 Response에 대응하여 제네릭한 JsonParser 구현](https://990427.tistory.com/112)
- [재사용 가능한 NetworkManager 구현](https://990427.tistory.com/117)
- [기본 제공하지 않는 Toast Message 직접 구현](https://990427.tistory.com/113)
- [서버와의 이미지 용량 이슈 해결](https://990427.tistory.com/115)
- 디자이너의 요구사항에 따라 CustomDatePicker구현 ([1편](https://990427.tistory.com/107), [2편](https://990427.tistory.com/108), [3편](https://990427.tistory.com/116))

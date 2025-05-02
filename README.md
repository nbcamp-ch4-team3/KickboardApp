# 탈거우꽈

<p align="center">
  <img src="https://github.com/user-attachments/assets/f21b1c6e-8db7-4982-bfdd-705c5b9c12d1" alt="TextLogo" width="300"/>
</p>

## 프로젝트 소개

**탈거우꽈**는 제주도 여행객 및 거주민을 타겟으로 한 킥보드 공유 앱입니다.  
사용자는 주변 킥보드를 대여 및 반남할 수 있고 관리자로서 킥보드를 등록할 수 있으며, 이 내역들을 마이페이지에서 관리할 수 있습니다.  
실제 운영 중인 앱의 UX를 기반으로 직관적인 흐름과 반응성을 고려하여 제작했습니다.

- **로그인**: UserDefaults를 이용한 자동 로그인
- **킥보드 대여 및 반납**: 주변 킥보드 마커를 통한 킥보드 대여 및 반납
- **장소 검색**: 장소 검색을 통해 해당 장소 주변 대여 가능한 킥보드 확인
- **킥보드 등록**: 원하는 위치에 킥보드 등록
- **이용 정보 저장 및 복원**: UserDefaults를 통해 앱 종료 및 재시동 시에도 이용 여부 반영

> 본 프로젝트는 팀원 4인이 Clean Architecture를 기반으로 역할을 나누어 협업하였으며,  
> `Delegate`를 통한 바인딩을 구현했고 `DIContainer`를 통한 의존성 관리를 했습니다.

## 시연 영상
<table>
  <tr>
    <td align=“center”>로그인</td>
    <td align=“center”>회원가입</td>
    <td align=“center”>검색</td>
    <td align=“center”>대여 및 반납</td>
    <td align=“center”>킥보드 등록</td>
    <td align="center">킥보드 등록 내역</td>
    <td align="center">이용 내역</td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/fd20aa83-9fca-4e89-ae4b-252ea3d5a3c0" width="200">
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/84723003-327b-4256-b665-31cd4775c0a5" width="200">
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/59790ab0-8147-48f0-9a84-b093a7a5fc91" width="200">
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/08b92c11-2751-4e9e-b228-cc4423c924e9" width="200">
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/de5e067c-5e68-42eb-91a9-bbc65836842b" width="200">
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/2942cb8f-f4b5-45c2-a4c4-e85c39513863" width="200">
    <td>
      <img src="https://github.com/user-attachments/assets/5735c35a-7f79-4e84-9f27-8d2bfe7b3c9c" width="200">
    </td>
  </tr>
</table>

## 기술스택
### 📌 개발 환경
- **Swift**  
  iOS 앱 개발을 위한 프로그래밍 언어
- **Xcode 16.0**  
  iOS 앱 개발을 위한 공식 IDE

### 🎨 UI 구성
- **UIKit**  
  전통적인 iOS UI 구성 프레임워크
- **SnapKit**  
  AutoLayout을 코드로 간결하게 작성할 수 있는 DSL 라이브러리
- **FittedSheets**  
  내부 컴포넌트 기반 높이 설정에 용이한 바텀 시트 구현 라이브러리
- **Then**
  객체 초기화 시 속성 설정을 간결하게 도와주는 유틸리티 라이브러리

### ☁️ 데이터 관리
- **UserDefault**  
간단한 사용자 설정값을 저장하는 데 사용하는 키-값 기반 저장소
- **Core Data**
구조화된 데이터를 저장하고 관리할 수 있는 Apple의 객체형 영속성 프레임워크

## 역할 분담
<div align=center>
    
  <img width="160px" src="https://avatars.githubusercontent.com/u/112386037?v=4"/> | <img width="160px" src="https://avatars.githubusercontent.com/u/96423430?v=4"/> | <img width="160px" src="https://avatars.githubusercontent.com/u/200376960?v=4"/> | <img width="160px" src="https://avatars.githubusercontent.com/u/105594739?v=4"/> | 
  |:-----:|:-----:|:-----:|:-----:|
  |[최안용](https://github.com/ChoiAnYong)|[송규섭](https://github.com/SongKyuSeob)|[권순욱](https://github.com/witt1e)| [이수현](https://github.com/LeeeeSuHyeon) |
  |팀장 👑|팀원 👨🏻‍💻|팀원 👨🏻‍💻|팀원 👨🏻‍💻|
  |`마이 페이지`<br/>`이용 내역`<br/>`내가 등록한 킥보드 보기`<br/>|`킥보드 대여, 반납`<br/>`UI/UX 디자인`<br/>`유저 이용 여부 상태관리`<br/>|`로그인`<br/>`회원가입`<br/>|`킥보드 등록`<br/>`검색 기능`<br/>`CoreData 구조 설계`<br/>
</div>

## 파일 구조
```
KickboardApp
 ┣ Application
 ┃ ┣ AppDelegate
 ┃ ┣ DIContainer
 ┃ ┣ LogInManager
 ┃ ┗ SceneDelegate
 ┃
 ┣ DataLayer
 ┃ ┣ CoreData
 ┃ ┣ Mapper
 ┃ ┣ Network
 ┃ ┗ Repository
 ┃
 ┣ DomainLayer
 ┃ ┣ Model
 ┃ ┣ RepositoryProtocol
 ┃ ┗ UseCase
 ┃
 ┣ PresentationLayer
 ┃ ┣ Home
 ┃ ┣ MyPage
 ┃ ┣ Onboarding
 ┃ ┣ Register
 ┃ ┗ TabBarController
 ┃
 ┣ Common
 ┃ ┣ Extensions
 ┃ ┗ Utility
 ┃
 ┣ Resources
 ┃ ┣ Assets.xcassets
 ┃ ┣ Base.lproj
 ┃ ┣ Fonts
 ┃ ┗ Info.plist
 ┗ 
```

## 코어 데이터 구조
<img width="919" alt="image" src="https://github.com/user-attachments/assets/fcff2404-070d-42e6-af6a-be4a39781d0e" />

## Convention 
### Commit Convention (PR 시 동일하게 적용)
- `feat`: 새로운 기능 추가
- `refactor`: 새로운 기능 추가 없이 개선이 이뤄진 경우(주석 수정, 네이밍 수정 포함)
- `fix`: 버그 수정
- `chore`: 프로젝트 설정, ignore 설정, 패키지 추가 등 코드 외적인 변경 사항
- `docs`: 문서 작업
- `test`: 테스트 관련 작업

###  Coding Convention
코딩 컨벤션

- 레이아웃: Constraints(상하, 좌우, center, size)
- UI 컴포넌트 네이밍
    
    UI 컴포넌트 생성 시, suffix로 컴포넌트 타입 명시
    
    ```swift
    let titleLabel: UILabel { ... }
    let cancelButton: UIButton { ... }
    let menuImageView: UIImageView { ... }
    ```
    

- 네이밍: Swift Standard (camelCase)
- 뷰컨트롤러 파일명: ex) `HomeViewController`, `CartViewController`, etc…
- delegate로 바인딩
- CoreData Container는 싱글톤으로 관리
- CoreData의 Entity는 Suffix로 Entity 붙이기

### Branch Convention
- main
- dev
- {tag}/{#issue-number}-{keyword}
ex) feat/#3-category-ui
ex) refactor/#5-storage
- feature 브랜치는 dev 기준으로 create
- {tag}/* 브랜치들은 전부 dev로 PR 발행 후, 팀원 모두의 승인을 받고 merge할 것
- rebase를 주로 사용
- 브랜치는 가급적 소문자로 구성하기!


## Usage
```
git clone https://github.com/nbcamp-ch4-team3/KickboardApp
cd KickboardApp/KickboardApp
open KickboardApp.xcodeproj
# 실행: ⌘ + R 
``` 

## 개발 블로그
- [Multicast Delegate Pattern을 활용한 위치 정보 공유 (with NSHashTable)](https://soo-hyn.tistory.com/149)

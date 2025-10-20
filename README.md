<div align="center">

<img width="1200" height="579" alt="페이지 1 5" src="https://github.com/user-attachments/assets/3698ced6-b60e-4a0a-87e0-f74bad88c309" />


<!--
<h1>식사일기</h1>
 <h3>하루 식단을 기록하고 회고하는 앱 🍱</h3>
  <p>-2조 J1Y2-</p>
  -->

<br><br>

<h3 style="font-size: 1.5em; font-weight: bold; margin-bottom: 0;">
  무엇을 위한 어플인가요?
</h3>
<p>
  식사일기는 하루의 식사를 기록하고 되돌아보는 나만의 식단 회고 앱이에요. <br>
  캘린더로 쉽게 기록하고, 통계로 나의 식습관을 한눈에 확인할 수 있어요.
</p>

<br><br>

<!-- Home View -->
<table align="center">
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/c621615a-c458-41c9-a250-d4da1866eace" width="200" alt="Home View" />
    </td>
    <td style="vertical-align: top; padding-left: 25px;">
      <h3>🏠 Home View</h3>
      <p>오늘의 식단을 <b>달력</b>을 통해 한눈에 확인할 수 있는 화면입니다.<br>
      날짜별로 아침, 점심, 저녁, 간식을 기록하고 빠르게 수정할 수 있어요.</p>
    </td>
  </tr>
</table>

---

<!-- Compose View -->
<table align="center">
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/497f3325-382b-4839-8cc2-80b61eac584f" width="200" alt="Compose View" />
    </td>
    <td style="vertical-align: top; padding-left: 25px;">
      <h3>✍️ Compose View</h3>
      <p>하루 식사를 <b>기록하고 등록</b>하는 화면입니다.<br>
      식사 종류(아침/점심/저녁/간식), 날짜, 시간, 내용을 입력할 수 있습니다.</p>
    </td>
  </tr>
</table>

---

<!-- Statistics View -->
<table align="center">
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/74d335c6-9edc-4525-ae20-dccd8fa45278" width="200" alt="Statistics View" />
    </td>
    <td style="vertical-align: top; padding-left: 25px;">
      <h3>📊 Statistics View</h3>
      <p>한 달 또는 주간 단위로 <b>식사 비율과 횟수</b>를 시각적으로 보여줍니다.<br>
      나의 식습관 패턴을 한눈에 확인할 수 있어요.</p>
    </td>
  </tr>
</table>

---

<!-- Search View -->
<table align="center">
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/d3159b48-98c3-463d-89f1-00e88bb8e25b" width="200" alt="Search View" />
    </td>
    <td style="vertical-align: top; padding-left: 25px;">
      <h3>🔍 Search View</h3>
      <p><b>날짜별 / 키워드별</b>로 기록된 식단을 검색할 수 있는 화면입니다.<br>
      빠르게 이전 식사 내용을 찾아볼 수 있습니다.</p>
    </td>
  </tr>
</table>

<br><br>

## 💡 아이패드 가로·세로 구현, 다크모드 지원

<p align="center">
  <img src="https://github.com/user-attachments/assets/your-uploaded-gif-link.gif" width="800" />
</p>


![newIpad](https://github.com/user-attachments/assets/54ca3a86-4d91-47bb-a0d2-6b495d263337)




<br><br>

## ⚙️ 기술 스택 (Tech Stack)

| 구분 | 사용 기술 |
|------|-----------|
| **Frontend** | SwiftUI, SwiftData |
| **Design** | SF Symbols, Dynamic Color Scheme |
| **Data Handling** | @Query, Predicate, SwiftData Model |
| **Version Control** | Git & GitHub |
| **Development Tool** | Xcode 26.x, macOS Tahoe |

<br><br>

## 🗂 프로젝트 구조

<pre align="left">
AnyLog/
├── 📁 AnyLog/
│ ├── 📁 Models/
│ │ └── Meal.swift # SwiftData @Model 구조 정의 (식사 데이터)
│ │
│ ├── 📁 Views/
│ │ ├── ContentView.swift # 앱 전체 View 관리 (TabView 기반 루트 뷰)
│ │ │
│ │ ├── 📁 Compose/
│ │ │ └── ComposeView.swift # 새로운 식단 작성 화면
│ │ │
│ │ ├── 📁 Home/
│ │ │ ├── HomeView.swift # 홈 탭 (최근 식단 목록)
│ │ │ └── TextView.swift # 텍스트 기반 식단 항목 표시 뷰
│ │ │
│ │ ├── 📁 Search/
│ │ │ ├── SearchView.swift # 검색 탭 메인 화면
│ │ │ └── SearchViewQuery.swift # SwiftData 기반 검색 로직
│ │ │
│ │ ├── 📁 Statistics/
│ │ │ ├── DateHolder.swift # 날짜 상태 관리 ObservableObject
│ │ │ ├── GraphBarMark.swift # 식사 분포 바 차트
│ │ │ ├── GraphSectorMark.swift # 원형 그래프 (세로 레이아웃)
│ │ │ ├── GraphSectorMarkH.swift # 원형 그래프 (가로 레이아웃)
│ │ │ ├── StatisticsView.swift # 통계 탭 메인 화면
│ │ │ └── TabState.swift # 탭 전환 상태 관리
│ │
│ ├── AnyLogApp.swift # 앱 진입점 (@main)
│ └── Assets.xcassets # 색상, 아이콘, 이미지 리소스
│
└── 📄 README.md</pre>

<br><br>

## 👥 팀원 소개 (Team Members)


<table align="center">
  <tr>
    <td align="center" style="padding: 20px;"><img src="https://avatars.githubusercontent.com/u/60869181?s=400&v=4" width="150" height="200" style="border-radius: 12px;" alt="조영준 프로필"/>
    <td align="center" style="padding: 20px;"><img src="https://github.com/user-attachments/assets/64a2e247-3c8e-40ce-812e-f9b7b2b7c50e" width="150" height="200" style="border-radius: 12px;" alt="김태윤 프로필"/><br>
    <td align="center" style="padding: 20px;"><img src="https://github.com/user-attachments/assets/934b6555-5c48-4010-a6df-df94ec8181f6" width="150" height="200" style="border-radius: 12px;" alt="박채윤 프로필"/><br>
  </tr>

  <tr>
    <td align="center" style="padding: 20px;">
      <b>조영준</b>  팀장<br>
      프로젝트 기획<br>
      ComposeView 제작<br>
      PPT제작
    </td>
    <td align="center" style="padding: 20px;">
      <b>김태윤</b>  팀원<br>
      SearchView 제작<br>
      StatisticsView 제작<br>
      PPT 제작
    </td>
    <td align="center" style="padding: 20px;">
      <b>박채윤</b>  팀원<br>
      깃코드 마크다운 작성<br>
      Home View 제작<br>
      영상, PPT 제작
    </td>
  </tr>
</table>

</div>

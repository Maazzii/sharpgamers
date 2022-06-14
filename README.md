# #GAMERS

## 프로젝트 개요

### 기획 의도
1. #GAMERS
   > SHARP + GAMERS

2. 배경
    
    > PC 온라인 게임과 달리 콘솔 및 패키지 게임은 정보를 공유할 곳이나 함께 게임을 즐길 사람을 찾기가 힘들다.
    > 

3. 목적
    
    > 게임 별 게시판을 제공해 정보를 공유<br>
    소모임을 누구나 개설해서 친목 활동 가능<br>
    회원간 1:1 메시지를 통해 소통 가능
    > 

<br>

### 개발 기간
2022.03.07 ~ 2022.03.28
<br><br>

### 개발 인원
1명
<br><br>

### 개발 환경
<img height="24px" src="https://img.shields.io/badge/JDK 1.8-007396?style=flat-square&logo=Java&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Oracle Database 18c XE-F80000?style=flat-square&logo=Oracle&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Apache Tomcat v9.0-F8DC75?style=flat-square&logo=Apache Tomcat&logoColor=black"/>
<br>
<br>

### 개발 언어
<img height="24px" src="https://img.shields.io/badge/Java-007396?style=flat-square&logo=Java&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=HTML5&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=JavaScript&logoColor=black"/> <img height="24px" src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=CSS3&logoColor=white"/>
<br><br>

### 개발 도구
<img height="24px" src="https://img.shields.io/badge/Eclipse IDE-2C2255?style=flat-square&logo=Eclipse IDE&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Visual Studio Code-007ACC?style=flat-square&logo=Visual Studio Code&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Adobe Photoshop-31A8FF?style=flat-square&logo=Adobe Photoshop&logoColor=white"/>
<br><br>

### 활용 기술
`AJAX`&nbsp;&nbsp;`Summernote`&nbsp;&nbsp;`Javamail`
<br><br>

## 프로젝트 구현

### 구현 기능
<img src="https://user-images.githubusercontent.com/46345154/170910044-d06ba818-a114-49f9-80f8-bd328b0489d2.png" width="50%">&nbsp;&nbsp;◀ 로그인 화면
<img src="https://user-images.githubusercontent.com/46345154/170911034-76ae76f5-8081-4d0d-89b3-fe87f6638dee.png" width="50%">&nbsp;&nbsp;◀ 회원가입 화면


#### 회원 가입 및 로그인
- 커뮤니티 기능을 고려하여 사이트 메인 화면 접속 시 로그인이 되어 있지 않으면 로그인 화면으로 이동한다.
- 로그인과 회원 가입, 비밀번호 찾기를 애니메이션을 이용해 한 화면에서 구현하였다.
- 이메일과 닉네임은 중복 체크가 가능하다.
- 휴대폰 번호는 숫자를 입력하면 자동으로 하이픈(-)을 추가해 저장한다.
<br><br>

#### 비밀번호 찾기
- 비밀번호 찾기는 이메일 인증을 통해 진행된다.
- 회원가입 시 작성한 이메일과 휴대폰 번호를 입력받아 인증 키를 보낸 뒤 키를 입력받아 체크하는 방식으로 이루어진다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/170911335-596f2f75-fccb-4148-ae75-a17ddc352e57.png" width="50%">&nbsp;&nbsp;◀ 메인 화면
#### 게임별 게시판
- **플랫폼**(Steam, Nintendo Switch, PlayStation, Xbox)별로 분류된 게임들은 각각 게시판을 하나씩 가지고 있다.
- 게시판은 검색을 통해 진입이 가능하며, **즐겨찾기**에 등록해 메인 화면이나 프로필에서 쉽게 접근이 가능하다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/170911588-dd8de7c9-e3c0-4581-8173-e2a2cbdcc2b1.png" width="50%">&nbsp;&nbsp;◀ 모든 게임 보기
<img src="https://user-images.githubusercontent.com/46345154/170911735-70b7ac75-bff5-4041-b2ed-8f5d3898244a.png" width="50%">&nbsp;&nbsp;◀ 게임 검색
#### 게시판 검색
- **모든 게임 보기** 버튼을 누르면 등록된 모든 게임 게시판의 목록을 볼 수 있다.
- 목록에서 플랫폼 이름을 눌러 목록을 접었다 펼 수 있게 구현하였다.
- 또는, 검색창에 플랫폼과 게임 이름을 검색해서 접근할 수 있다.
- 검색창에 입력할 때는 등록된 게임 목록이 자동 완성으로 표시되며, 이것을 이용해 게임 이름을 정확하게 입력할 경우 해당 게임 게시판으로 바로 이동된다.
<br><br>

#### 게시글 목록
- 관리자가 게시판을 추가할 때 입력한 게임 제목, 헤더 이미지, 플랫폼, 상점 페이지 등 정보가 상단에 표시된다.
- 토글 방식의 즐겨찾기 버튼을 눌러 등록하면 메인 페이지와 자신의 프로필에서 쉽게 접근할 수 있다.
- 추천 수가 많은 글을 목록 상단에 노출시켰다.
- 작성일이 오늘인 경우 작성 시간만 표시하고, 그 외에는 날짜만 표시하도록 했다.
<br><br>


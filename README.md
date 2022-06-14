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

<img src="https://user-images.githubusercontent.com/46345154/173497412-68b482b2-b83b-44cd-8842-bf3dbc5e792a.png" width="50%">&nbsp;&nbsp;◀ 게시글 목록 (상단)

<img src="https://user-images.githubusercontent.com/46345154/173497242-3571fde5-041a-41a9-9f42-876527c72cfd.png" width="50%">&nbsp;&nbsp;◀ 게시글 목록 (하단)

#### 게시글 목록
- 관리자가 게시판을 추가할 때 입력한 게임 제목, 헤더 이미지, 플랫폼, 상점 페이지 등 정보가 상단에 표시된다.
- 토글 방식의 **즐겨찾기** 버튼을 눌러 등록하면 메인 페이지와 자신의 프로필에서 쉽게 접근할 수 있다.
- 추천 수가 많은 글을 목록 상단에 노출시켰다.
- 작성일이 오늘인 경우 작성 시간만 표시하고, 그 외에는 날짜만 표시하도록 했다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173497697-87186aeb-4edd-41fc-92d0-6e51be9937ed.png" width="50%">&nbsp;&nbsp;◀ 게시글 본문

#### 게시글 본문
- 제목, 작성자, 조회수, 작성일 등 글 정보가 표시된다.
- 추천 및 추천인 목록 버튼은 AJAX를 이용한 토글 방식으로 구현하였다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173497755-6cea36c9-81bc-4e30-8fc1-4d5eee0a1fa1.png" width="50%">&nbsp;&nbsp;◀ 게시글 댓글

#### 게시글 댓글
- **추천인 목록** 버튼을 누르면 추천인 목록이 표시된다.
- 추천 버튼을 누를 때마다 목록을 다시 로드하도록 구현하였다.
- 댓글의 수정 버튼을 누르면 바로 아래에 입력창이 나타나고 새로고침 없이 수정 및 삭제가 가능하다.
- 다른 사람의 댓글에는 버튼이 노출되지 않는다.
- 페이지의 JS뿐 아니라 서버에서도 세션 체크를 해서 작성자만 수정할 수 있도록 했다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173498108-c961110c-9ff5-4dbe-b68d-b4fa002f5ec6.png" width="50%">&nbsp;&nbsp;◀ 길드 목록

#### 길드 목록
- **길드**는 누구나 가볍게 만들고 폐쇄할 수 잇는 소모임 개념의 공간으로, 게임 게시판에서 길드 목록 버튼을 누르면 표시된다.
- 해당 게임의 전체 길드 수가 상단에 표시된다.
- 목록의 각 요소에는 길드의 정보를 한 눈에 표시하도록 했다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173498402-ee94474f-d7e6-4ee8-a81e-86e52d9e0a47.png" width="50%">&nbsp;&nbsp;◀ 길드 메인 - 멤버가 아닌 경우

<img src="https://user-images.githubusercontent.com/46345154/173498501-ab8c2c68-7e47-4862-ad78-5df3c57d08f4.png" width="50%">&nbsp;&nbsp;◀ 길드 메인 - 멤버인 경우

#### 길드 메인
- 길드명, 설명 등 정보가 상단에 표시된다.
- 우측 상단에 현재 멤버 수와 가입 대기중인 멤버가 표시된다.
- 길드에 가입 신청하면 **길드 마스터의 승인을 통해** 가입이 진행되도록 구현하였다.
- 화면 중앙의 **가입 신청** 버튼을 눌러 신청하고, 다시 취소할 수도 있다.
- 길드에 가입한 멤버가 접속할 경우
  - 길드 폐쇄 / 길드 게시판 버튼이 추가로 표시된다.
  - 길드 폐쇄 버튼은 마스터에게만 노출된다.
  - 메인 페이지에서 간단한 메모를 작성할 수 있다.
    - 일반 게시판의 댓글과 같이 Ajax 통신을 통해 새로고침 없이 변경 내용이 적용된다.
  - 길드 마스터는 다른 멤버가 쓴 글도 수정 / 삭제가 가능하며 일반 멤버에게는 버튼이 노출되지 않는다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173499181-d3d30ffd-8683-409b-8a28-34b8cfbb0a53.png" width="50%">&nbsp;&nbsp;◀ 길드 멤버 목록

#### 길드 멤버 목록
- 길드 메인 화면에서 **멤버수** 정보를 클릭해서 진입할 수 있다.
- 가입되어 있는 멤버 목록과 가입 신청 후 대기중인 멤버 목록이 표시된다.
- 가입되어 있는 멤버 목록에 길드 마스터가 표시된다.
- 접속한 사람이 **길드 마스터**일 경우, 가입 대기중인 멤버의 가입 승인과 거절이 가능하고, 가입한 다른 멤버에게 마스터를 위임하거나 길드에서 추방이 가능하다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173499660-85e1491e-d0d0-4aec-8fbb-3a9ab047eb52.png" width="50%">&nbsp;&nbsp;◀ 닉네임을 눌러 프로필 진입

<img src="https://user-images.githubusercontent.com/46345154/173499806-9199d8c8-4ec5-4a35-ab50-a9db306fde96.png" width="50%">&nbsp;&nbsp;◀ 본인의 프로필

<img src="https://user-images.githubusercontent.com/46345154/173499906-7ff03dbb-98bb-4bb9-b3ba-081b14c10c47.png" width="50%">&nbsp;&nbsp;◀ 다른 멤버의 프로필

#### 프로필
- 사이트 내 어디서든 **닉네임** 표시를 누르면 해당 멤버의 **프로필** 페이지를 볼 수 있다.
- 프로필 페이지에는 해당 멤버가 즐겨 찾는 게임 목록, 가입한 길드 목록, 작성한 글 목록이 표시된다.
- 본인의 프로필에 접속할 경우, 상단에 **메시지함**과 **정보 수정** 버튼이 표시된다.
- 다른 멤버의 프로필에 접속할 경우, 상단에 **메시지 보내기** 버튼이 표시된다.
<br><br>

<img src="https://user-images.githubusercontent.com/46345154/173500218-6dd4233e-60ea-426e-a425-5f00c3833c98.png" width="50%">&nbsp;&nbsp;◀ 메시지

#### 메시지
- 헤더의 메시지 링크를 클릭하거나, 내 메시지함 또는 다른 멤버에게 메시지를 보낼 경우 진입하게 되는 페이지이다.
- 왼쪽에는 메시지를 주고받은 적이 있는 **멤버 목록**이 표시된다.
- 오른쪽에는 해당 멤버와 주고받은 **메시지 내용**이 표시된다.
- **읽지 않은 메시지**가 있는 경우 헤더와 목록에 **개수 알림**이 표시된다.
- 한 번도 메시지를 주고받은 적이 없는 멤버의 경우, 해당 멤버에게서 메시지가 오거나 해당 멤버에게 메시지 보내기 버튼을 눌렀을 때 왼쪽 목록에 **자동으로 추가**된다.
- 멤버 목록을 클릭해 메시지를 로드하면 자동으로 스크롤이 맨 아래로 내려가도록 구현하였다.
- 1초마다 자동 로드 박스에 체크하면 1초마다 받은 메시지를 **자동으로 로드**할 수 있다.

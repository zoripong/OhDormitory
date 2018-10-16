# 기숙사 관리 시스템, 오늘 몇 시 점호야?

오늘 몇 시 점호야? (이하 '오몇점')은 미림여자정보과학고등학교의 기숙사에서 사용할 수 잇는 기숙사 관리 시스템입니다.

기숙사 생활을 하며 여러가지 일지 작성과 공지에 대한 여러 불편함들이 존재하였습니다.
150명이 넘는 학생들이 하루 중 상당시간을 보내는 기숙사에서 좀 더 스트레스 받지 않고, 편리하게 기숙사를 사용할 수 있었으면 하는 바람으로 만들어진 솔루션입니다.

오몇점은 사감 선생님과 학교 선생님께서 사용하실 수 있는 [관리자 페이지](https://dorm.emirim.kr/OhDormitoryAdmin/auth.html)(Web)와 학생들이 사용할 수 있는 앱(Android/iOS)과 학부모께서 학생들의 외박일정을 확인할 수 있는 학부모용 앱(Android/iOS)으로 이루어져있습니다.

해당 레포지토리에는 [서버](https://github.com/zoripong/OhDormitory-Server)를 제외한 관리자페이지와 iOS, Android 프로젝트가 포함되어있습니다.



## Functions

### 학생 정보 관리
- 기존의 두터운 서류들을 대신하여 학생들의 정보를 모두 관리자 페이지에서 관리 할 수 있도록 하였습니다.
- 학생들에 대한 정보를 CSV파일을 통해 관리할 수 있어 보다 효율적입니다.
  * 빠른 문서화 가능
  * 일괄 수정 작업의 속도 향상
  * 친근한 사용법

### 게시판 알림
 
- 사감선생님은 학생들에게 관리자 페이지를 통해 공지사항을 안내 할 수 있습니다.
- 학생들은 앱을 통하여 푸시 알림과 함께 사감선생님의 공지사항을 확인 할 수 있습니다.
- 게시판은 다음과 같은 게시글 등을 올릴 수 있습니다. 
  * 일반 공지사항
  * 청소구역
  * 외박 일지 작성


### 세탁 일지 관리
 
- 세탁기의 사용여부 / 사용호실을 관리자 페이지와 앱을 통하여 확인할 수 있습니다.
- 학생들은 앱을 통하여 세탁 예약을 신청 할 수 있습니다.


### 외박 관리

- 기존 종이로 배부하던 외박증을 QR코드를 통하여 관리할 수 있도록 하였습니다.
- 모든 외박 일지 현황을 관리자 페이지를 통하여 확인할 수 있습니다.




### 개별 상벌점 관리 


- 기존 게시판에 공지되어있던 상벌점 리스트를 개인적으로 확인가능하도록 하였습니다.
- 학생들의 개인정보를 보호할 수 있으며, 좀 더 체계적으로 확인할 수 있습니다.


## Excel 관리하기
```
room_num, name, emirim_id, password,  student_phone, parent_phone
```

아직은 CVS 형식의 파일만을 저장하고 다운받을 수 있으며 컬럼의 순서는 위와 같습니다. 

현재에는 이용중이지 않은 서비스라 url이 공개되어 누구나 사용할 수 있습니다. 따라서 다른 사용자에 의해 학생 데이터가 손실 되어있을 수 있습니다.
학생데이터가 손실되었을 경우, Repository의 DummyData.csv 파일을 통하여 업로드 후 이용해주시기 바랍니다.

## Screenshots

> 관리자 페이지

- 로그인 / 게시판

<img src="https://bit.ly/2CipiEe" alt="스플래시" width="50%"/><img src="https://bit.ly/2yIknt3" alt="게시판" width="50%"/>


- 회원정보

<img src="https://bit.ly/2NKPMjM" alt="회원정보-1" width="50%"/><img src="https://bit.ly/2PD0lrd" alt="회원정보-2" width="50%"/>



- 세탁일지 / 외박관리

<img src="https://bit.ly/2PBgCNd" alt="세탁일지" width="50%"/><img src="https://bit.ly/2CMDHd2" alt="외박관리" width="50%"/>


> 학생 Android 

- Splash / 로그인

<img src="https://bit.ly/2pXnLMK" alt="스플래시" width="25%"/><img src="https://bit.ly/2En6NB9" alt="로그인" width="25%"/>

- 게시판

<img src="https://bit.ly/2CMY5e1" alt="게시판" width="25%"/><img src="https://bit.ly/2ysQWvR" alt="일반게시" width="25%"/><img src="https://bit.ly/2IZG24F" alt="청소구역" width="25%"/><img src="https://bit.ly/2Eq0ywu" alt="외박일지" width="25%"/>

- 세탁일지

<img src="https://bit.ly/2PDa8gL" alt="세탁그래프" width="25%"/><img src="https://bit.ly/2OqfJKV" alt="세탁디테일" width="25%"/>

- 외박인증 / 설정

<img src="https://bit.ly/2AdcOwd" alt="외박인증" width="25%"/><img src="https://bit.ly/2J05Bm5" alt="설정" width="25%"/>


> 학부모 Android 

- Splash / 외박 신청 전 / 외박 신청 후

<img src="https://bit.ly/2Pyqtn2" alt="스플래시" width="25%"/><img src="https://bit.ly/2IYtaeW" alt="외박신청-전" width="25%"/><img src="https://bit.ly/2P1t1gb" alt="외박신청-후" width="25%"/>

핸드폰 번호를 통하여 학부모를 인증하기 때문에 로그인이 필요없습니다.
또한, 학생들이 임의로 인증하는 일을 방지하였습니다.




## Extras
- 서버에 대한 정보는 [OhDormitory-Server](https://github.com/zoripong/OhDormitory-Server) 를 참고해주세요.
- author [zoripong](https://github.com/zoripong/)
- CONTACT ME : <mailto:devuri404@gmail.com>

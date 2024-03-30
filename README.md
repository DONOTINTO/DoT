## 📘 최신 업데이트 1.1.0 - 24.03.27
```
v1.1.0 업데이트 내용
[주요]
- '상세 지출 내역'에 사진을 추가하여 저장할 수 있습니다.
- Realm SchemaVersion 0 -> 1

[버그 수정]
- '상세 지출 내역'을 삭제 시 해당 일의 누적 지출 금액이 업데이트되지 않는 버그가 수정되었습니다.

[UI]
- 일부 UI의 폰트 사이즈가 조정되었습니다.
- '상세 지출 내역'에 사진을 추가할 수 있는 UI가 추가되었습니다.
```
<p align="center">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/91d3630d-38c6-411a-bfce-616bffb79a9d" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/10f72608-ff9b-4465-8024-b345a1a9ae9a" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/badbdc0c-7792-4979-8078-06c6bd05ec07" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/ef754abf-6a6c-4c00-bd13-091633914899" align="center" width="24%">
</p>
<p align="center">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/218938d6-872f-41eb-ab01-84a35736e9af" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/163925b2-4cf0-428d-a537-4df1ac7b206b" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/e5305345-ffa9-4cb3-b5cd-3b098d09e395" align="center" width="24%">
	<img src="https://github.com/DONOTINTO/DoT/assets/123792519/08f040ee-d058-4e04-8d5b-262d677d7ced" align="center" width="24%">
</p>


## 📘 앱 소개 및 기능
출시 기간 : 2024.03.08 ~ 2024.03.24

- 여행에 필요한 예산 및 지출을 관리함과 동시에 여행 기록(메모, 사진, 위치)을 저장
- **Configuration** : 최소버전 16.0 / 세로모드 / 아이폰용 / 라이트 모드
- **v1.0 기능** : 환율 정보 / 예산 설정 / 지출 기록 / 여행 기록 저장 / 다크 모드
- 업데이트 : 공유, 검색, 로그인, 위치 검색 및 저장, 사진 저장


## 📘 핵심 기능
- **환율 정보 |** API 통신 일 별 환율 정보 및 최근 환율 비교
- **여행 추가 |** 여행 별로 예산을 설정하고 지출을 관리
- **지출 기록 |** 예산에서 지출 합계 계산, Realm을 통해 지출 금액, 사진, 품목, 메모 저장
- **여행 기록 |** List로 지출 기록을 모두 저장


## 📘 기술 스택
**프레임워크**   
- **UIKit(Code Base)**

**라이브러리**
- **Snapkit(codebase UI) |** AutoLayout을 관리하기 용이하고 코드의 가독성을 높임
- **Realm |** 여행에 필요한 핵심 정보들을 Realm에 저장하여 로컬 기기에서 데이터를 다시 활용
- **Alamofire |** 환율 정보를 API를 통해 데이터를 받아올 때 HTTP 네트워킹 작업을 단순화
- **PhotosUI(PHPickerConfiguration) |** PHPicker를 통해 사진 활용 및 저장
- **UICollectionCompositional Layout |** CollectionView의 layout을 유연하고 빠르게 구성 
- **Diffable DataSource |** Index기반에서 Hashable한 데이터 기반으로 cell 구성의 안정성 향상

**디자인 패턴**
- **MVVM |** View, Model, ViewModel로 나누어 데이터와 비즈니스 로직은 model과 viewModel에서 처리하여 view가 비대해지는 것을 방지 및 의존성 관리

**버전 관리**
- **Git / Github / Github Desktop**


## 📘 API
[한국수출입은행 Open API](https://www.koreaexim.go.kr/ir/HPHKIR020M01?apino=2&viewtype=C&searchselect=&searchword=)
- 한국 수출입 은행 Open API를 통해 평일에 한정하여 환율 정보를 제공

## 📘 데이터베이스 구조(Realm)

환율 정보(Exchange)

| objectID(PK - String) | date(String) | currencyUnit(String) | exchangeRate(String) | exchangeName(String) |
| --- | --- | --- | --- | --- |

여행 정보(TripInfo)

| objectID (PK - String) | title(String) | place(String) | headCount(Int) | currency(String) | budget(String) | startDate(Date) | endDate(Date) | tripDetail(List<TripDetailInfo>) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

여행 세부 기록(TripDetailInfo)

| objectID(PK - String) | expense(Double) | category(Enum) | photos(List<PhotoInfoDTO>) | memo(String?) | place(String?) | expenseDate(Date) | tripInfo(LinkingObject<TripInfo>) |
| --- | --- | --- | --- | --- | --- | --- | --- |

맵 정보(PhotoInfo)
| objectId(PK - Object ID) | filname(String) | data(Data) |
| --- | --- | --- |

## 📘 트러블슈팅
### 🔵 Realm을 이용하여 API 콜 횟수를 최대한 줄이기 🔵

#### ❗문제 상황

**1. API 콜 횟수 제한**

앱을 실행하면 환율 정보 API를 통해 환율 정보를 호출한다.
다만, 사용하는 API는 API 통신 횟수가 일 1,000회로 제한되어 앱을 실행할 때 마다 API를 호출한다면 금방 콜 횟수의 제한의 걸린다.

**2. 평일만 사용 가능**
평일에만 환율 정보를 제공하기 때문에, 주말에는 환율 정보를 확인할 수 없다.

<img width="500" alt="스크린샷 2024-03-28 오후 6 01 47" src="https://github.com/DONOTINTO/DoT/assets/123792519/57fdf437-ff97-44ee-bcac-5478264c26f0">

#### ❗해결 방법

**1. API 콜 횟수 제한**

API 콜을 하기 앞서 경우의 수를 나누어 필요한 시점에만 API를 콜하도록 했다.


```
1) 기존 데이터가 없을 경우
1-1) 기존 데이터가 없고, 주말의 경우 			-> 마지막 평일 데이터 호출
1-2) 기존 데이터가 없고, 평일 11시 이전의 경우 		-> 오늘을 제외한 마지막 평일 데이터 호출
1-3) 기존 데이터가 없고, 평일 11시 이후의 경우 		-> 금일 데이터 호출

2) 기존 데이터가 있을 경우
2-1) 기존 데이터가 있고, 금일 데이터를 호출한 경우 	-> 기존 데이터 사용
2-2) 기존 데이터가 있고, 주말의 경우 			-> 기존 데이터 사용
2-3) 기존 데이터가 있고, 평일 11시 이전의 경우 		-> 기존 데이터 사용
2-4) 기존 데이터가 있고, 평일 11시 이후의 경우 		-> 금일 데이터 호출   
```

<img width="500" alt="스크린샷 2024-03-29 오후 9 13 24" src="https://github.com/DONOTINTO/DoT/assets/123792519/54f0d34b-c286-4c15-8616-d1717e4a0dcd">

위 7가지 경우를 통해 일일 최대 1회의 API콜만 하도록 하였다.   

**2. 평일에만 사용 가능**

평일에만 데이터를 넘겨주기 때문에, 주말 날짜로 API를 콜하는 것을 방지해주어야 했다.   
이는 Calendar의 기능들을 적극 활용했다.

오늘 날짜를 기준으로 평일이 나올때 까지 날짜를 하루씩 변경하면서 평일임을 체크하였다.

<img width="500" alt="스크린샷 2024-03-29 오후 9 44 03" src="https://github.com/DONOTINTO/DoT/assets/123792519/914321d9-4030-4fbf-8559-0827f051232b">
---

### 🔵 PHPicker - Dispatch Group으로 순서보장하기 🔵

#### ❗문제 상황

PHPicke로 사진을 불러오면 해당 메소드(didFinishPicking)가 실행되면서 선택한 사진들의 배열 형태([PHPickerResult])로 정보가 넘어오게 된다.
배열의 원소인 PHPickerResult에서 itemProvider 프로퍼티를 통해 다시 loadObject 메소드를 호출하면 이미지 데이터를 가져올 수 있다.

[PHPickerResult] -> PHPickerResult -> itemProvider -> loadObject()

문제는 loadObject 메소드가 비동기로 처리가 된다는 점이었다.
그말인 즉슨 loadObject의 completionHandler 또한 순서를 보장하진 못한다는 의미였다.
사진이 한장이 아니고, 순서에 맞게 사진 데이터를 저장하고 있기에 해당 문제를 해결해야 했다.

1. 비동기로 처리가 되기 때문에 loadObject의 completionHandler 안에서 데이터를 저장하게 되면 순서가 보장되지 않는다.
2. loadObject completionHandler안에서 데이터를 저장해서 밖에서 데이터에 접근하면 completion이 되기 이전이라 값이 저장되어 있지 않다.

<img width="899" alt="스크린샷 2024-03-30 오전 1 05 12" src="https://github.com/DONOTINTO/DoT/assets/123792519/bf4007df-52a9-424f-9e82-4ca9fc7e81d8">

#### ❗해결 방법

위 방법을 해결하기 위해 Dispatch Group과 임시로 String 배열과 [String: Data]형태의 딕셔너리를 이용했다.

1. 반복문돌며 Dispatch Group으로 관리 + 데이터 임시 저장

우선 [PHPickerResult]를 반복문을 통해 PHPickerResult / itemProvider에 접근했다.
이 후 첫번째로 한것은 Dispatch Group를 enter 시켜주었다. 반복문이 돌때마다 enter후 loadObject(비동기 처리)가 complete되면 leave를 해줄 예정이다.

itemProvider엔 이미지 데이터 외에도 각 이미지별로 지니는 로컬 식별자인 assetIdentifier가 존재하는데,
이를 우선 [String]에 순서대로 저장해주었다. (아직 loadObject 이전이기 때문에 순서가 보장된다)

이 후 loadObject를 호출하여 complete가 되면 앞서 생성한 [String: Data]딕셔너리 키 값에 assetIdentifier를 값에는 이미지 데이터를 저장해주었고, dispatch는 leave를 해주었다.

2. dispatchGroup.notify로 일괄 처리

모든 비동기 처리가 Dispatch Group을 통해 끝났음을 전달받을 것이다.
dispatchGroup.notify에서 해줄 일은 순서에 맞게 데이터를 저장하는 것이다.

[String]은 assetIdentifier를 순서에 맞게 저장하고 있고, [String: Data]는 순서가 보장되지 않지만, 선택한 모든 이미지의 assetIdentifier와 Data를 가지고 있다.
이를 통해 [String]의 배열을 순회하면서 [String: Data]에서 동일한 키값을 통해 Data를 순서에 맞게 가져와 저장했다.

<img width="702" alt="스크린샷 2024-03-30 오전 1 22 08" src="https://github.com/DONOTINTO/DoT/assets/123792519/2f227d0c-d002-41cc-ab48-9991efa65f41">




<!-- 1. AnyHashable
2. 연관값을 통한 Section 추가
3. DTO
4. PHPicker를 통한 사진 저장 방식
5. realm 마이그레이션 -->

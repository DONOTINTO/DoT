# DoT - 여행 가계부

<p align="center">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/91d3630d-38c6-411a-bfce-616bffb79a9d" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/ef754abf-6a6c-4c00-bd13-091633914899" align="center" width="24%">
	<img src = "https://github.com/DONOTINTO/DoT/assets/123792519/e5305345-ffa9-4cb3-b5cd-3b098d09e395" align="center" width="24%">
	<img src="https://github.com/DONOTINTO/DoT/assets/123792519/08f040ee-d058-4e04-8d5b-262d677d7ced" align="center" width="24%">
</p> <br>

## 앱 다운로드
> 애플 앱스토어: https://apps.apple.com/kr/app/dot-%EC%97%AC%ED%96%89-%EA%B0%80%EA%B3%84%EB%B6%80/id6479473950 

<br>

## 앱 소개 및 기능

> 출시 기간 : 2024.03.08 ~ 2024.03.24   
최소버전 16.0 / 세로모드 / 아이폰 전용 / 다크 모드 지원

DoT - 여행 가계부는 여행에 있어 필수적이면서 기본적인 요소들만 모아두었습니다. 우선 떠나는 여행별로 예산과 여행지, 통화, 예산, 기간을 설정하여 여행 카드를 생성할 수 있습니다.   
생성된 여행 카드는 **홈 탭**과 1.1.1버전에서 추가된 **여행 카드 모음 탭**에서 확인할 수 있습니다. 여행 카드는 세부적인 지출과 예산을 관리하며 필요에 따라 사진, 메모 등을 추가하여 여행의 추억을 더욱 자세하게 기록할 수도 있습니다.

<br>

## 주요 기능
### 환율 정보
> 한국수출입은행에서 제공하는 환율 정보를 받아와 매일 아침 10시 기준으로 제공

### 여행 추가 
> 여행지 / 예산 / 통화 / 인원 / 기간을 설정하여 여행 카드 생성 가능

### 지출 기록
> 여행 카드 내에서 예산 및 지출 기록 가능   
지출 합계 자동 계산 / 남은 예산 / 지출 카테고리 / 지출 금액 자동 기록 및 수정 가능

### 여행 기록 
> 지출 내역 별 모두 기록 및 상세 내용(지출 금액 / 사진 / 품목 / 메모) 추가 가능   

<br>

## 기술 스택

`UIKit(CodeBase)` <br>
`Realm` / `Alamofire` / `FSCalendar` / `SnapKit` <br>
`RxSwift` / `RxDataSource` <sub> v 1.1.1 이 후 적용 </sub> <br>
`UICollectionCompositional Layout` / `Diffable DataSource` / `PHPicker` <br> 
`MVVM` / `Input Output` / `Router` <br>
`Git` / `Github` / `Figma` <br>
<details>
<summary> 라이브러리 버전 </summary>

| **라이브러리** | **버전** |
| :---: | :---: |
| Alamofire | 5.9.0 |
| FSCalendar | 2.8.4 |
| Realm | 10.48.0 |
| RxSwift | 6.7.1 |
| RxDataSource | 5.0.2 |
| SnapKit | 5.7.1 |
| TextFieldEffects | 1.7.0 |
</details>

- `Realm`의 데이터를 교환하는 모델(`RealmObject`)과 실제 화면에 사용되는 데이터(`Diffable Datasource`)를 분리하여 RealmObject의 `마이그레이션`에서 오는 오류를 최소화

- `Alamofire`에서 `Router패턴`과 `Generic`을 사용하여 API와 여러 데이터 모델에도 적용할 수 있도록 `확장성` 고려

- `SnapShot`을 통해 직관적인 UI 변화 애니메이션을 보여주는 Diffable DataSource를 통해 사용자의 `UX`를 고려

- `RxSwift` 사용 전 `커스텀 Observable`과 `Input Ouput 패턴` 통해 Action과 비즈니스 로직을 분리하여 `MVVM`을 적용 및 이해 

<br>

## 데이터베이스(Realm) 구조

> 환율 정보(Exchange)

| objectID(PK - String) | date(String) | currencyUnit(String) | exchangeRate(String) | exchangeName(String) |
| :---: | :---: | :---: | :---: | :---: |

<br>

> 여행 정보(TripInfo)

| objectID (PK - String) | title(String) | place(String) | headCount(Int) | currency(String) | budget(String) | startDate(Date) | endDate(Date) | tripDetail(List<TripDetailInfo>) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |

여행 카드 생성 시 `여행 정보` RealmObject를 사용한다. 이는 List로 `여행 세부 기록`을 담을 수 있어서 각 여행 카드 별로 각각의 `여행 세부 기록`을 담을 수 있도록 했다.

<br>

> 여행 세부 기록(TripDetailInfo)

| objectID(PK - String) | expense(Double) | category(Enum) | photos(List<PhotoInfoDTO>) | memo(String?) | place(String?) | expenseDate(Date) | tripInfo(LinkingObject<TripInfo>) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |

<br>

## 회고

#### ✏️ 서비스 지향적 네트워크 에러 핸들링

Alamofire를 사용하여 request를 하게되는 경우, response의 result는 Result<T, AFError>를 넘겨준다.
completionHandler에 자연스럽게 Result<T, AFError> 형태로 파라미터를 받았는데, AFError자체가 서비스에서 사용하는 API 에러와 알맞게 대응하기 어려웠다.

다만, Result 자체가 Alamofire에서 제공하는 것으로 생각해 커스텀 에러로 변경하지 않았다.

<img width="521" alt="image" src="https://github.com/DONOTINTO/DoT/assets/123792519/97e48a32-e0b3-4718-ae60-c2148eb9b9e9">

의외로 Result를 타고 들어가면 바로 Error타입이기만 하면 된다는 걸 확인했다.<br>
서비스에서 사용하는 에러 코드는 한정적이기 때문에 Status Code와 원시값을 이용한 Enum에 Error를 채택하면 서비스에 맞춘 커스텀 에러를 생성하여 적용 가능할 것 같다.

#### ✏️ 커스텀 Observable로 RxSwift 맛보기
RxSwift를 바로 적용하기 보다는 커스텀 Observable을 만들어서 구독과 이벤트 전달에 대한 이해할 수 있었다.

커스텀 Observable을 사용해보니 MVVM의 구분이 명확해졌는데, 이번 프로젝트에서는 인터페이스에 대한 유저의 이벤트나 특정 View Life Cycle 이벤트를 ViewModel로 넘기고, ViewModel에서는 이에 대한 비즈니스 로직을 작성했다.

> 예시 코드

버튼 클릭 이벤트를 ViewModel로 전달

<img width="454" alt="image" src="https://github.com/DONOTINTO/DoT/assets/123792519/b0b1c0ec-d406-42bd-afe4-81168a9c0c9d">

이벤트를 전달받으면 ViewModel에서 비즈니스 로직 처리 및 결과 전달

<img width="1188" alt="image" src="https://github.com/DONOTINTO/DoT/assets/123792519/3f7f70d2-6b33-44f0-a61c-c193a415e256">

VC에서 결과에 대한 이벤트 전달이 발생하면 그에 대한 View와 관련된 로직을 처리

<img width="582" alt="image" src="https://github.com/DONOTINTO/DoT/assets/123792519/5aaf3e51-d3e2-4fac-ae55-cc497aabcb79">

이 과정에서 ViewModel로 이벤트를 전달받을 Input과 비즈니스 로직을 처리한 결과를 이벤트로 방출할 Output을 구분지을 수 있었다.

이는 다시 RxSwift에서 Input Output 패턴으로 변경할 계획이다.

<br>

## 트러블슈팅
### ✏️ Realm을 이용하여 API 콜 횟수를 최대한 줄이기

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

### ✏️ PHPicker - Dispatch Group으로 순서보장하기

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

## 📘 최신 업데이트 1.1.1 - 24.05.07
```
v1.1.1 업데이트 내용
[주요]
- 모든 여행 정보 카드를 확인할 수 있는 탭이 추가됩니다.

[UI]
- 종료된 여행, 예정인 여행, 진행중인 여행에 따라 카드의 색상이 구분됩니다.
```

## 📘 지난 업데이트 1.1.0 - 24.03.27
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
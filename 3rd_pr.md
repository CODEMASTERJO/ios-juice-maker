안녕하세요 소대! @zdodev

PR마감시간을 지키려고 했는데 늦어버렸네요 ㅠㅠ\
STEP1에서 상세한 PR감사드립니다.\
공부해볼 부분도 알 수 있었고 놓친 부분에 대해서도 다시 한 번 공부하는 계기가 되었습니다.\
STEP2부터는 스토리보드 기능이 추가되었어요! is랑 jojo 둘다 스토리보드가 익숙하지 않아서 어려웠지만 열심히 구현해봤습니다!

## ‼️ Step3: 요구 사항 및 구현 사항

### 스텝3 요구 사항 정리
```
Step 3 : 재고 수정 기능구현
1. 화면 제목 '재고 추가' 및 '닫기' 버튼 구현
2. 닫기를 터치하면 이전화면으로 복귀
3. 화면 진입시 과일의 현재 재고 수량 표시
4. -, + 를 통한 재고 수정
5. iPhone 12 외에 다른 시뮬레이터에서도 UI가 정상적으로 보일 수 있도록 오토레이아웃 적용 
```
- [x]  닫기 버튼 구현
- [x]  오토 레이아웃
- [x]  과일 잔고 수량 데이터 전달 및 표시
- [ ]  재고 수정

### 스텝3 수행 중 핵심 경험
- 내비게이션 바 및 바 버튼 아이템의 활용
- 얼럿 컨트롤러 활용
- Stepper 활용
- Modality의 활용
- 화면 사이의 데이터 공유
- 오토레이아웃 시작하기

### 🙋‍♂️ 각 객체 별 책임
| Name | Type | 책임 |
| -- | -- | -- |
| JuiceMakerViewController | ViewController | Juice주문 및 Fruit 재고 현황을 보여주는 화면 |
| StoreViewController| ViewController | Fruit 재고를 수정할 수 있는 화면

### 1. 닫기 버튼
- 처음부터 있었던 2번째 navigation contoller를 이용하였습니다
- 이를 이용하기 위해선 present modally를 재고 수정 담당인 `StoreViewContoller`(이하 `S_vc`)로 하는게 아니라 해당 뷰가 embed하고 있는 `NavigationContoller`(이하 `Navi_c`)에 해야함을 깨달았어요
  - 그렇게 하지 않으면 `Navigation Item`을 설정해도 `S_vc`에 보이지 않더라고요
- `S_vc`에 embed된 `Navigation Bar`에 title을 작성하고 RightBarButtonItem을 추가했어요.

### 2. AutoLayout
다양한 시뮬레이터에서도 UI가 정상적으로 보일 수 있도록 아래와 같이 오토레이아웃을 정의 및 적용했어요
- 과일별로 `Vertical Stack`, 과일 전체를 `Horizontal Stack`에 넣었어요
- 아래와 같이 `Constraints`를 추가했어요<br>
![Stack in Stack](https://user-images.githubusercontent.com/107124308/212240786-01d65bea-982e-4db7-8f82-9412f0787daf.png)  
![constraints](https://user-images.githubusercontent.com/107124308/212239979-4c9fbb09-015b-4cc3-af7f-d58b2047e240.png)
![Image 2023-01-13 at 1 51 PM](https://user-images.githubusercontent.com/107124308/212240939-5e6ae56a-64ed-4f12-a57e-129ba78b21dd.jpg)

### 3. 과일 수량 데이터 전달 및 표시
**전달하기**
```swift

```
- `JuiceMakerViewController`(이하 `JM_vc`)는 `Navi_c`를 present해요.
- `Navi_c`를 `instantiateViewController(withIdentifier:)` method로 생성한 후 viewControllers 중 하나인 `S_vc`를 찾아서 fruitStore를 할당했어요.
- `fruitStore`는 class이므로 `S_vc`에 할당 시 `JM_vc`가 가진 fruitStore의 주소값이 복사돼요
- 그래서 `S_vc`와 `JM_vc`는 동일한 FruitStore instance를 참조할 수 있어요.

**표시하기**

## 구현예시


## 🔫 Trouble Shooting

### 🧭 2개의 Navigation Controller

`JuiceMakerView`에서 `StoreView`로 modal 방식으로 화면 전환을 구현하면서\
StoreView에 적용한 navigation이 보이지 않는 문제가 있었어요.

push 방식으로 화면을 전환하면 JuiceMakerView에서 쓰던 navigation bar를 사용할 수 있는데,

- modal 형식으로 화면을 전환하고 싶었고
- 새 StoreView에서 버튼 UIComponent를 만들기 보다는 네비게이션으로 뒤로가기를 구현해보고 싶었어요.

공부해보니 새로운 네비게이션을 보이게 하려면 목표 View가 아니라 해당 View의 **navigation으로 화면을 전환**해야 하더라고요. 이걸 깨달은 이후에야 `main.storyboard`에서 처음 화살표가 navigation에 있는게 보였어요!

## 고민한 부분 + Optional(해결)

### 1️⃣ JuiceMakerVC 내 많은 IOBOutlet UILabel들

**고민** 과일 재고(5개)의 IBOutlet label을 관리하는 방법 중

1. 하나의 label을 하나의 IBOutlet 변수에 binding하는 방식
   - Label과 Fruit을 연결하기 위해 Dictionary를 추가적으로 생성해야 했어요.
2. IBOutlet Collection을 이용해 array에서 한 꺼번에 관리하는 방식

중 고민했어요.

**해결** 현재 구현한 방식은 1번 방식이예요.

한꺼번에 관리하는게 좋을 것 같아서 일반적으로 2번 방식을 선호하는 편임에도 불구하고 **1번 방식으로 구현한 이유**는 다음과 같아요.

- 찾아봤을 때, IBOutlet collection을 사용한 예시는 array내 모든 outlet을 돌면서 한 꺼번에 속성을 적용하는 경우가 많았어요.
  - 그런데 우리는 특정 label만 선택해서 text를 업데이트 하고 싶었어요.
- outlet의 index를 명시적으로 설정하는 방법을 찾지 못했어요
  - collection에 들어가는 outlet의 index는 collection에 넣은 순서대로 되는 것 같았어요.
  - 이를 명시적으로 설정할 수 없으면 이를 명시하기 위한 추가적인 문서가 필요해요(그럴 일은 없겠지만, 추후 협업을 고려했을 때)
- array의 out of index 에러를 고려해야해요.

이와 같은 이유로 1번 방식으로 구현했어요.
❓ 지금의 방식보다 더 가독성이 좋고 편한 방식이 있는지 궁금해요!\
❓ 시간이 부족해 IBOutlet Collections에 대한 공부가 부족한 상태로 판단했는데, 위 처럼 판단한 게 맞는지 궁금합니다!

### 2️⃣ 화면 전환 방식, push vs modal

**고민**
두 가지 화면 전환 방식 중 무엇을 선택할지 고민했어요.

- modal
  - 재고 수정이 무관한 흐름이라고 판단했어요

- push: 
  - 쥬스를 만드는 화면에 재고가 표시되고 해당 재고를 수정하는 것이기 때문에 유관한 흐름이라고 판단하였습니다.

**해결** 현재 구현한 방식은 modal이예요.

각자 의견이 다른 와중에, 프로젝트 핵심 경험에 modality 활용이 있어서 modal로 선택했습니다 :)

### 3️⃣ 알림창, actionsheet vs alert

**고민** 알림창의 Style을 고민했어요.

**해결** 둘 다 alert 스타일로 구현했어요.

- **재고 수정** 알림창은 결정이 필요한 중요 정보라고 생각해서 alert 형태로 구현했어요
- 쥬스를 성공적으로 만든 후 알림 창은 이후 특별한 액션을 실행하기 보다는 단순한 알림이므로 alert 형태로 구현했어요

### 4️⃣ 화면 전환 구현 방식

**고민** 다양한 화면 전환 구현 방식 중 어떤 방식으로 전환할 지 고민했어요.

1. 직접 segueway
2. 간접 segueway
3. 코드로 스토리보드 네비게이션 객체를 생성하여 화면 이동
4. 코드로 스토리보드 생성 및 객체 연결

**해결** 우리가 적용한 화면 전환 방식은 3번이예요.

재고 수정 화면으로 전환되는 trigger가 2개이기에

1. 재고 수정 버튼,
2. 재고 부족시 발생하는 alert의 `예` 버튼)

storyboard에서 세그웨이를 통해 전환하기 보다는 화면을 전환하는 함수를 만들어 활용했어요

### 5️⃣ 코드 상 일어나지 않을 에러를 처리해야 하는가?
```swift
@IBAction func orderButtonTapped(_ sender: UIButton) {
    // ...
    guard let juice = Juice(rawValue: juiceName ?? "") else {
        // 1
        showAlert(message: "팔 수 없습니다.")
        return
    }

    do {
        // ...
    } catch is JuiceMakerError {
        // ...
    } catch {
        // 2
        showAlert(message: "\(error)")
    }
}
```

1. juice가 nil이 되는 경우
2. JuiceMaker Error가 아니라 다른 error가 발생하는 경우

1은 
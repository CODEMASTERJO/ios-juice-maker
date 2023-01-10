안녕하세요 소대! @zdodev

PR마감시간을 지키려고 했는데 늦어버렸네요 ㅠㅠ\
STEP1에서 상세한 PR감사드립니다.\
공부해볼 부분도 알 수 있었고 놓친 부분에 대해서도 다시 한 번 공부하는 계기가 되었습니다.\
STEP2부터는 스토리보드 기능이 추가되었어요! is랑 jojo 둘다 스토리보드가 익숙하지 않아서 어려웠지만 열심히 구현해봤습니다!

## ‼️ 요구 사항 및 구현 사항

### 🙋‍♂️ 각 객체 별 책임
| Name | Type | 책임 |
| -- | -- | -- |
| JuiceMakerViewController | ViewController | Juice주문 및 Fruit 재고 현황을 보여주는 화면 |
| StoreViewController| ViewController | Fruit 재고를 수정할 수 있는 화면

🍎 JuiceMakerViewController
- **과일 재고현황**\
  각 과일별 재고 Label을 IBOutlet으로 연결
  ```swift
      @IBOutlet private weak var strawberryStock: UILabel!
      // ...
  ```
  Label과 FruitStore를 연결하기 위해 fruitLabelFruitMap 딕셔너리를 만들어 2개를 매칭   
  ```swift
    fruitLabelFruitMap = [
              strawberryStock: .strawberry,
              // ...
          ]
  ```
  `updateStockValue` 함수를 통해 과일별 재고현황을 업데이트
- **재고관리 `Button`**\
  재고 관리 화면으로 넘어가기 위해 @IBAction을 통해 코드에 `button` 연결
  ```swift
  @IBAction func ModifyStockButtonTapped(_ sender: UIBarButtonItem)
  ```
  코드로 스토리보드 네비게이션 객체를 생성하여 화면 이동
  ```swift
  guard let storeNaviVC = storyboard?.instantiateViewController(withIdentifier: "storeNavi") as? UINavigationController else { return }
  ```
  Modal 방식을 통한 화면전달
   ```swift
  present(storeNaviVC, animated: true)
  ```
- **쥬스 주문 버튼**\
`orderButtonTapped` 함수 한 곳으로 모든 juice 버튼의 입력을 받아온다.
juice 버튼 title에 각 juice 명칭이 들어가 있음으로 정제하여 각 juice에 매칭
  ```swift
  @IBAction func orderButtonTapped(_ sender: UIButton) {
    let orderName = sender.currentTitle
    let juiceName = orderName?.replacingOccurrences(of: " 주문", with: "")
    guard let juice = Juice(rawValue: juiceName ?? "") else {
    showAlert(message: "팔 수 없습니다.")
    return
  }
  ```
  juice가 생성된다면 성공 alert을 띄우고 생성되지 않는다면 실패 alert 띄운다.
  ```swift
  do {
    try juiceMaker.make(juice: juice)
    showAlert(message: "\(juice.rawValue) 나왔습니다! 맛있게 드세요!")
  } catch is JuiceMakerError {
    showFailAlert()
  }
  ```
- **Alert 구현**\
`UIAlertController`를 통해 alert 틀 생성
  ```swift
  let failAlert = UIAlertController(title: nil, message: "재고가 모자라요. 재고를 수정할까요?", preferredStyle: .alert)
  ```
  `UIAlertAction`을 통해 액션 생성
  ```swift
  let confirmAction = UIAlertAction(title: "예", style: .default, handler: { _ in self.showStoreView() })
  ```
  Alert에 액션 추가하기
  ```swift
  failAlert.addAction(confirmAction)
  ```
  `shwoAlert` 함수를 통해 성공 및 오류의 메세지만 수정하도록 활용성 확장
  ```swift
  private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
  ```
📦 StoreViewController
  - 전 화면으로 돌아가기
    `UIBarButtonItem`을 코드에 연결하여 `dismiss` 실행
    ```swift
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
         dismiss(animated: true)
     }
    ```

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

**고민** 7개나 되는 과일 재고의 IBOutlet label을 관리하는 방법 중

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

![설명](https://user-images.githubusercontent.com/107124308/211450698-e69f3a7d-a05b-4dc9-9766-4ceb93840c30.png)

### 2️⃣ 화면 전환 방식, push vs modal

**고민**
두 가지 화면 전환 방식 중 무엇을 선택할지 고민했어요.

- modal
  - 재고 수정이 무관한 흐름이라고 판단했어요
  <!--
  #TODO: jojo가 정리해주세요 :)
  -->
- push:
  - 재고 수정이 유관한 흐름이라고 판단했어요

**해결** 현재 구현한 방식은 modal이예요.

각자 의견이 다른 와중에, 프로젝트 핵심 경험에 modality 활용이 있어서 modal로 선택했습니다 :)

### 3️⃣ 알림창, actionsheet vs alert

**고민** 알림창의 Style을 고민했어요.

**해결** 둘 다 alert 스타일로 구현했어요.

- **재고 수정** 알림창은 결정이 필요한 중요 정보라고 생각해서 alert 형태로 구현했어요
- 쥬스를 성공적으로 만든 후 알림 창은 이후 특별한 액션을 실행하기 보다는 단순한 알림이므로 alert 형태로 구현했어요

<!--
#TODO: jojo가 정리해주세요 :)
-->

### 4️⃣ 화면 전환 방식 (#jojo#)

**고민** 다양한 화면 전환 방식 중 어떤 방식으로 전환할 지 고민했어요.

1. 직접 segueway
2. 간접 segueway
3. 코드로 스토리보드 네비게이션 객체를 생성하여 화면 이동
4. IBAction 만들기 ??

**해결** 우리가 적용한 화면 전환 방식은 3번이예요.

재고 수정 화면으로 전환되는 trigger가 2개이기에

1. 재고 수정 버튼,
2. 재고 부족시 발생하는 alert의 `예` 버튼)

storyboard에서 직접 끌어서 전환하기 보다는 화면을 전환하는 함수를 만들어 재사용했어요.

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
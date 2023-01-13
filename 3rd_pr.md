안녕하세요 소대! @zdodev

{인사말}

## Step3: 요구 사항 및 구현 사항

### 요구 사항 정리

```markdown
**Step 3 : 재고 수정 기능구현**
1. 화면 제목 '재고 추가' 및 '닫기' 버튼 구현
2. 닫기를 터치하면 이전화면으로 복귀
3. 화면 진입시 과일의 현재 재고 수량 표시
4. -, + 를 통한 재고 수정
5. iPhone 12 외에 다른 시뮬레이터에서도 UI가 정상적으로 보일 수 있도록 오토레이아웃 적용 
```

- [x]  닫기 버튼 구현
- [ ]  닫기 터치 시 이전 화면 복귀
- [x]  오토 레이아웃
- [x]  과일 잔고 수량 데이터 전달 및 표시
- [ ]  재고 수정

### 수행 중 핵심 경험

- [x] 내비게이션 바 및 바 버튼 아이템의 활용
- [x] 얼럿 컨트롤러 활용
- [x] Stepper 활용
- [x] Modality의 활용
- [x] 화면 사이의 데이터 공유
- [x] 오토레이아웃 시작하기

### 🙋‍♂️ 각 객체 별 책임
<!-- | Name | Type | 책임 |
| -- | -- | -- |
| JuiceMakerViewController | ViewController | Juice주문 및 Fruit 재고 현황을 보여주는 화면 |
| StoreViewController| ViewController | Fruit 재고를 수정할 수 있는 화면 -->

### 1. 닫기 버튼

- 처음부터 있었던 2번째 navigation contoller를 이용하였습니다
- 이를 이용하기 위해선 present modally를 재고 수정 담당인 `StoreViewContoller`(이하 `Store_vc`)로 하는게 아니라 해당 뷰가 embed하고 있는 `NavigationContoller`(이하 `Navi_c`)에 해야함을 깨달았어요
  - 그렇게 하지 않으면 `Navigation Item`을 설정해도 `Store_vc`에 보이지 않더라고요
- `Store_vc`에 embed된 `Navigation Bar`에 title을 작성하고 RightBarButtonItem을 추가했어요.

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
class JuiceMakerViewController: UIViewController {
    private func showStoreView() {
        guard let storeNaviVC = storyboard?.instantiateViewController(withIdentifier: "storeNavi") as? UINavigationController else { return }
        // ...
        guard let storeVC = storeNaviVC.viewControllers.first(where: { $0 is StoreViewController }) as? StoreViewController else { return }
        
        storeVC.fruitStore = fruitStore
        // ...
        present(storeNaviVC, animated: true)
    }
}
```

- `JuiceMakerViewController`(이하 `JM_vc`)는 `Navi_c`를 present해요.
- `Navi_c`를 `instantiateViewController(withIdentifier:)` method로 생성한 후 Navi_c의 `viewControllers` 중 하나인 `Store_vc`를 찾아서 fruitStore를 할당했어요.
- `fruitStore`는 class이므로 Store_vc에 할당 시 JM_vc가 가진 **fruitStore의 주소값이 복사**돼요
- 그래서 `Store_vc`와 `JM_vc`는 동일한 FruitStore instance를 참조할 수 있어요.

**표시하기**

```swift
// some code
```

- `Store_vc`의 `viewDidLoad()`에서 fruitStore의 재고를 이용해 UILabel의 `text`, UIStepper의 `value`를 업데이트해요

### 4. -, +를 이용한 재고 수정

```swift
// Stepper를 눌렀을 때 코드
```

- stepper의

### 5. 닫기를 눌러 이전 화면으로 이동

```swift
// dismiss 시
```

- 닫기를 눌러 이전 화면으로 이동하면 기존 JM_vc를 업데이트해야
- delegate 패턴으로 구현했어요.

## 구현예시

## 고민한 부분 + Optional(해결)

### 1️⃣ 오토레이아웃

**문제** 재고수정 화면에서 autolayout을 다양한 기기를 지원할 수 있도록 적용해야 했어요

**해결**

1. 큰 Horizontal Stack을 중앙 정렬했어요
   - 작은 폰에서는 일부 ui가 보이지 않는 문제가 발생했어요
2. 작은 폰을 기준으로 Safe Area로 부터 constant를 수정해가며 설정했어요.

그런데 큰 화면에서는 UI가 너무 큰 느낌인 것 같기도 해서 잘 한 건지 고민이예요..

❓ 오토레이아웃을 하는 공식이 있을까요? 보통 어떤 방식으로 하나요?

### 2️⃣ Navigation Controller의 다음 view인 Store_vc에 fruitStore 전달하기 - Passing data forward

**문제** 싱글톤이 아닌 fruitStore를 2 depth만큼 더 깊이 있는 Store_vc에 전달해야 했어요

**원했던 방향**

- fruitStore는 싱글톤으로 바꾸지 않고 의존성 주입 구현 방식을 유지하기
  - Store_vc는 fruitStore의 주소값을 전달받아 두 view는 identical한 fruitStore를 본다.
- 기존에 만들어져있던 2번째 Navigation Controller를 사용하며 화면 전환은 모달 방식으로 하기

**문제 원인**

- modal일 때 기존의 뷰 간 값을 전달하는 방식은 일반적으로 아래 방식으로 해요
  - 다음에 볼 view를 현재 view에서 초기화한 뒤 그것을 present 한다.
  - 초기화 후 present 전에 다음 뷰의 속성에 전달할 데이터를 할당한다.
- JM_vc의 다음 뷰는 Store_vc가 아니라 Navi_c이고, Store_vc는 그 Navi_c 안에서 접근할 수 있어요.

**해결**

```swift
guard let storeNaviVC = storyboard?.instantiateViewController(withIdentifier: "storeNavi") as? UINavigationController else { return }
<------
// 기존
guard let storeVC = storyboard?.instantiateViewController(withIdentifier: "storeView스토리보드ID") else { return }
// 변경 후
guard let storeVC = storeNaviVC.viewControllers.first(where: { $0 is StoreViewController }) as? StoreViewController else { return }
------>
storeVC.fruitStore = fruitStore
```

- 기존
  - 처음에는 JM_vc의 화면 전환 method에서 Navi_vc와 Store_vc를 모두 초기화한 후 Store_vc에 fruitStore를 할당하고 Navi_c를 present했어요.
  - 놀랍게도 아무런 일도 일어나지 않았어요.
  - 그 이유는, `Navi_c에서 보여주는 Store_vc`는 `JM_vc에서 초기화한 Store_vc`와 **다른** vc이기 때문인 것 같아요.
- 변경 후
  - Navi_c에 [viewControllers](https://developer.apple.com/documentation/uikit/uinavigationcontroller/1621873-viewcontrollers) 속성을 활용했어요
  - 이 속성으로 navigation stack에 있는 view controller를 확인할 수 있어요
  - 필터링해서 Store_vc를 찾고 그의 fruitStore를 JM_vc의 fruitStore로 할당했어요
- 개선할 수 있을 것 같은 사항?
  - PR을 쓰면서 정리하기 위해 찾아보니 [setViewControllers](https://developer.apple.com/documentation/uikit/uinavigationcontroller/1621861-setviewcontrollers)라는 method를 찾았어요.
  - 이는 해당 navigation controller의 viewContollers를 통째로 바꿔치기해주는 method예요.
  - 현재는 기존의 viewContollers에서  filter로 StoreViewController인 첫 번째 vc를 찾았는데,
  - 현재 프로젝트에서는 지금 방법 보다는 setViewContollers method를 사용해도 좋을 것 같아요.

❓ 우리가 구현한 방식이 괜찮은/안전한 방식인지, 보통 위와 같은 경우 어떻게 구현하는지 궁금합니다!

### 3️⃣ 재고수정 modal이 꺼졌을 때 메인 화면을 업데이트 - Passing data backward

**문제**

**해결**

- kvo
- delegate

❓ weak 써야함?

### 4️⃣ UILabel, UIStepper, UIButton

### 5️⃣ 스태퍼를 누를 때 일어날 동작

두 가지 의견이 나왔다.

1. stepper를 누를 때마다 fruitStore의 재고를 변경하자.
2. 재고 수정 화면을 벗어날 때 fruitStore의 재고를 변경하자.

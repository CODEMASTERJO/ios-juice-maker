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

# wanted_pre_onboarding

# 주의!
  - API에서 요구하는 개인 key는 Commit되어 있지 않으므로, clone하여도 빌드되지 않음.
 ~~이는 프리온보딩 iOS 담당자와 상의한 부분으로, 기술을 판단하시는 분께서 필요하다고 판단했을 때, 제공하기로 함.~~ 커밋 되어있음.
# 작동 화면
![Jun-15-2022 23-34-53](https://user-images.githubusercontent.com/68788135/173854384-d5cc0c7c-bae1-4f6a-a264-7067ca3f6791.gif)


# 개요
 - 제약 사항에 따라 외부 라이브러리를 사용치 아니함.
 - Storyboard 기반 UI를 구현했으며, AutoLayout이 지정되어 있음.
 - MVVM 구조를 채택하여 Testable한 코드를 작성하려 함.
 - protocol 기반 의존성 주입을 통해 Testable한 코드를 작성하려 함.

# API 사용
  - [Weather API - OpenWeatherMap](https://openweathermap.org/api)
  - 다수의 도시의 정보를 받는 API가 따로 없기 때문에, 첫 화면에 보여야 하는 도시의 정보를 한 번에 모두 받아왔음. 
이는, Activity  Indicator를 학습하여 사용하려는 의도가 있었으나, 일정 관계로 구현되지 못함. 때문에, 초기 로딩에 약간의 시간이 필요함.
  - DiffableDataSource를 사용하였으므로, 하나씩 받아오면 되지 아니한가? 라고 생각하였으나, Cell이 하나씩 나타나는 animation이 생기기 때문에, 이를 지양하였음.
  - API를 사용하여 Data를 받아올 때, 모든 정보는 Cache하여, 추후 요청받았을 때, Cache되었는지 확인하고, 없다면 API를 사용하여 요청함.

# 기술 스택
- `MVVM`, `Coordinator Pattern`, `Dependency Injection: DIContainer`, `Reactive`

# 첫번째 뷰 MainWeatherView
- 요구된 필수 포함 정보를 표기함.
- 전체 View는 CollectionView로 구성되어 있으며, DiffableCollectionViewDataSource에 의해 Cell이 표현됨.
- CollectionView는 하나의 Section과 도시 갯수만큼의 Group과 Item으로 Layout되어있음.
- 각 Cell은 도시 명, 도시 날씨 Icon, 현재 온도, 현재 습도가 표기되나, 이번 구현에서 단위는 제거하였음.
- 각 Cell을 터치하여, 해당하는 도시의 상세 정보를 확인 할 수 있음.
 
# 두번째 뷰 DetailWeatherView
- 요구된 필수 포함 정보를 표기함.
- 전체 View는 ScrollView로 구성되어 있으며, Scroll이 정상 작동하는지 Test하여 확인 함.
- 정보가 Int혹은 Float임을 고려하여, AutoLayout을 간결하게 지정, 정보의 양이 변동하여 많아 진다면, 수정이 필요하도록 작성됨.
- 날씨 설명 Label은 정보의 크기가 커져도 문제 없도록 AutoLayout 지정됨.
- 날씨 정보와 Image 모두 Cache를 통해 정보를 얻어 옴.

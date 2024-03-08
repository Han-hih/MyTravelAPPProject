# 여행은 Trip

# 📱앱 주요 화면

<img width="1401" alt="image" src="https://github.com/Han-hih/TravelApp/assets/109748526/c44f116d-0ee0-48f4-9df4-d0aa06e77b60">

## 주요 기능
- Observable을 이용해 달력에서 선택한 날짜 데이터 바인딩
- MapKit의 MKLocalSearchCompletion를 이용해 장소 검색
- Diffable datasource를 이용해 검색 부분 애니메이션 효과 추가
- MKMapView를 이용해 추가한 장소 pin으로 고정
- 날짜별 추가한 장소 필터링 및 PolyLine으로 연결
- Pin선택 시 애플맵 길찾기로 연동 
- realm을 활용해 사진 일기 저장 및 불러오기
- repository pattern을 이용한 realm사용, 데이터베이스 모듈화 
  
## 개발 기간
2023.09.25 ~ 2023.10.23(29일)

# 🔨기술스택
- 개발 인원: 1인
- 최소 버전: iOS 15.0
- 디자인 패턴: MVC, MVVM
- UIKit(Codebase UI)
- RealmSwift
- MapKit, PhotosUI
- DiffableDataSource
- FSCalendar
- Firebase Push Notifications, Crashlytics
- RxSwift


# 트러블 슈팅
 ### 1. 여행 계획 추가 후 돌아온 화면 reload 문제
   -  배열이 추가가 안되거나 두번씩 중첩되는 현상이 있었습니다.
   -  viewWillAppear에서는 reload가 안돼서 배열을 새로 만들었는데 그럴 때마다 viewDidLoad에서 만들어 놓은 배열과 합쳐져서 두배로 증가해서 겹쳐보이는 현상이 생겼습니다.
   -  viewWillAppear에서 배열을 초기화 해주고 다시 렘에서 데이터를 받아와서 tableViewReload를 해줬습니다.
   -  
 ### 2. tableView에서 행을 제거할 때 에러발생
  - 문제상황
    - 테이블뷰에서 여행계획을 삭제하고 reload를 해주면 기존 배열과 렘에서 가져온 배열이 맞지 않는 현상이 생겼습니다.
    - 렘에서 가져온 배열로 cell을 구성했는데 기본 값으로 Plan구조체를 가지고 있도록 해서 에러가 발생했습니다
  - 해결방법
    - 배열을 빈값으로 초기화를 해주고 렘에서 데이터를 다시 가지고 오는 방식으로 해결했습니다.


 ### 3. Gradation Animation 동작 문제
 - 문제상황
   - 메인 화면 컬렉션뷰의 그라데이션 애니메이션이 event가 발생해야 보이는 문제가 있었습니다.
   - 레이아웃 관련된 layoutSubViews나 viewDidAppear에서 위와 같은 문제가 발생했습니다.
   - 레이아웃이 바뀌는 것이 아니라 색상이 변경되고 있어서 event가 발생해야 동작한다고 생각했습니다.
 - 해결방법
   - draw메서드에 animation함수를 실행시켜줘서 뷰의 컨텐츠가 그려질 때 적용되고 바로 화면에 반영되도록 구현했습니다.
     ```swift
      override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradationAnimate()
      }
     ```

11월 12일 업데이트(1.0.1)
  - 사진일기 작성 뷰에서 키보드 올라온 상태에서 사진이 없을 때 작성버튼 누르면 뷰가 두번 내려가서 검은화면 보이는 현상 해결
  - 나라 검색 목록 처음 들어갔을 때 바로 목록으로 보여주기
  - 맵뷰에서 날짜 컬렉션뷰 선택 시 강조색상 추가
  - 여행지 검색 영역 부분 확대

24년 1월 2일 업데이트(1.0.2)
  - Push Notification 추가
  - Firebase Crashlytics 추가

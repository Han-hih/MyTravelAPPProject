# 여행은 Trip

# 📱앱 주요 화면

## 주요 기능
- 여행 날짜와 지역 설정, 장소 검색, 장소 추가, 메모 작성
- Observable을 이용해 달력에서 선택한 날짜 데이터 바인딩
- MapKit의 MKLocalSearchCompletion를 이용해 장소 검색 및 Diffable datasource를 이용해 애니메이션 효과 추가
- 애플맵 연동, 날짜 별 경로 확인, 애플맵 경로 찾기
- 사진 일기 작성, 조회
- repository pattern을 이용한 realm사용, 데이터베이스 모듈화 
  
## 개발 기간
2023.09.25 ~ 2023.10.23

# 🔨기술스택
- 최소 버전: iOS 15.0
- 디자인 패턴: MVC, MVVM
- UIKit(Codebase UI)
- RealmSwift
- MapKit
- DiffableDataSource
- PhotosUI
- FSCalendar
- Firebase Push Notifications, Crashlytics
- RxSwift


# 트러블 슈팅
 ### 1. 여행 계획 추가 후 돌아온 화면 reload 문제
   -  배열이 추가가 안되거나 두번씩 중첩되는 현상이 있었습니다.
   -  viewWillAppear에서는 reload가 안돼서 배열을 새로 만들었는데 그럴 때마다 viewDidLoad에서 만들어 놓은 배열과 합쳐져서 두배로 증가해서 겹쳐보이는 현상이 생겼습니다.
   -  viewWillAppear에서 배열을 초기화 해주고 다시 렘에서 데이터를 받아와서 tableViewReload를 해줬습니다.

 ### 2. 날짜 선택 관련 문제
   - 하루만 선택했을 때, 기간으로 설정했을 때와 다시 선택했을 때 어떻게 처리해줘야 할 지 고민을 많이 했었습니다.
     애플에서 기본으로 제공하는 달력에는 여러 날짜를 선택하거나 하루만 선택 가능했는데 제가 생각했던 기능은 연속된 날짜 선택이었습니다. 그래서 FSCalendar를 이용했고 라이브러리 내에 있는 didSelect메서드를 이용해서
     구현을 해줬습니다.
```swift
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            startButton.isEnabled = true
            viewModel.dateRange.bind { date in
                guard let date = self.datesRange?[0] else { return }

                self.startButton.setTitle(self.viewModel.dateToString(completion: {
                    date
                }), for: .normal)
            }
            print("datesRange contains: \(datesRange!)", "하루만 선택")
            
            return
        }
        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)", "하루만 선택되어있을때") //*
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            
            for day in range {
                calendar.select(day)
            }
            
            datesRange = range
            print("datesRange contains: \(datesRange!)", "기간으로 선택됨") //*
            startButton.isEnabled = true
            viewModel.dateRange.bind { date in
                guard let date = self.datesRange else { return }
                
                let firstDay = self.viewModel.dateToString {
                    date.first!
                }
                let lastDay = self.viewModel.dateToString {
                    date.last!
                }
                self.startButton.setTitle("\(firstDay) ~ \(lastDay)", for: .normal)
            }
            return
        }
        
        
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            startButton.setTitle("Please select the travel date".localized, for: .normal)
            startButton.isEnabled = false
            print("datesRange contains: \(datesRange!)", "날짜 선택 취소") //*
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)", "날짜 선택 취소")
        }
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

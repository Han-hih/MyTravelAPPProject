//
//  Observable.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import Foundation

class Observable<T> {
   
  private var listener: ((T) -> Void)?
   
   var value: T {
       didSet {
           listener?(value)
           print("날짜가 \(value)로 변경되었습니다.")
       }
   }
   
   init(_ value: T) {
       self.value = value
   }

   func bind(_ sample: @escaping (T) -> Void) {
       print("기간은 \(value)입니다.")
       sample(value)
       listener = sample
   }
   
}

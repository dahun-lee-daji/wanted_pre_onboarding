//
//  Observable.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/15.
//

import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
        
        var value: T {
            didSet {
                listener?(value)
            }
        }
    
        init(_ value: T) {
            self.value = value
        }
        
        func bind(_ closure: @escaping (T) -> Void) {
            closure(value)
            listener = closure
        }
}

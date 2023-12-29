//
//  Date+Ex.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

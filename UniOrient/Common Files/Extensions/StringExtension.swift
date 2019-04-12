//
//  StringExtension.swift
//  TripArcher
//
//  Created by APPLE on 02/01/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"    
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidMobileNumber() -> Bool {
        let PHONE_REGEX = "[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    func convertNextDate(dateString : String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"//"dd MM yyyy"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        print("your next Date is \(somedateString)")
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMM yy"//"yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
}

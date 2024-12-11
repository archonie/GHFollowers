//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.12.2024.
//

import Foundation


/// We don't need this anymore but ill keep it in the GitHub repository in case Ill use it in the future.
extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else {
            return "N/A"
        }
        return date.convertToMonthYearFormat()
    }
}

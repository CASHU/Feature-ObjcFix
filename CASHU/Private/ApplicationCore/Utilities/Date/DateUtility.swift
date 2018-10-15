//
//  DateUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/22/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 Date formatting styles that is supported by the application.
 
 - withDashes: Seperate date by -.
 - withSeperators: Seperate date by /.
 - withDots: Seperate date by :.
 - withSpacesAndDotsForTime: Seperate date by spaces " ".
 */
enum DateFormattingStyle : Int {
    case withDashes
    case withSeperators
    case withDots
    case withSpacesAndDotsForTime
}

/**
 Date formatting sequences that is supported by the application.
 
 - dayMonthYear: day-month-year.
 - monthDayYear: month-day-year.
 - yearMonthDay: year-month-day.
 - todayWithHoursAndSecondsAndPeriod: Today hours:seconds.
 - yesterdayWithHoursAndSecondsAndPeriod: Yesterday hours:seconds.
 - dayWrittenMonthYearWithHoursAndSecondsAndPeriod: day name-month-year hours:seconds.
 */
enum DateFormattingSequence : Int {
    case dayMonthYear
    case monthDayYear
    case yearMonthDay
    case todayWithHoursAndSecondsAndPeriod
    case yesterdayWithHoursAndSecondsAndPeriod
    case dayWrittenMonthYearWithHoursAndSecondsAndPeriod
}


/**
 This class provides an easy way to deal with dates in different ways and formats.
 It's a utility class with static methods.
 */
@objcMembers class DateUtility: NSObject {
    /**
     Add number of years to a date.
     
     - parameter years: The number of years you want to add
     - parameter date: The date which will the years will be added to it
     
     - returns: Date after adding years to it.
     */
    class func addYears(_ years: Int, to date: Date) -> Date {
        let unitFlags = Set<Calendar.Component>([.year, .day, .month, .hour, .minute, .second])
        let gregorian = Calendar.current
        let comps: DateComponents? = gregorian.dateComponents(unitFlags, from: date)
//        comps?.year = (comps?.year)! + years
        let newDate: Date? = gregorian.date(from: comps!)
        return newDate!
    }

    /**
     Add number of months to a date.
     
     - parameter months: The number of months you want to add
     - parameter date: The date which will the months will be added to it
     
     - returns: Date after adding months to it.
     */
    class func addMonths(_ months: Int, to date: Date) -> Date {
        let unitFlags = Set<Calendar.Component>([.year, .day, .month, .hour, .minute, .second])
        let gregorian = Calendar.current
        let comps: DateComponents? = gregorian.dateComponents(unitFlags, from: date)
//        comps?.month = (comps?.month)! + months
        let newDate: Date? = gregorian.date(from: comps!)
        return newDate!
    }

    /**
     Add number of days to a date.
     
     - parameter days: The number of days you want to add
     - parameter date: The date which will the days will be added to it
     
     - returns: Date after adding days to it.
     */
    class func addDays(_ days: Int, to date: Date) -> Date {
        let unitFlags = Set<Calendar.Component>([.year, .day, .month, .hour, .minute, .second])
        
        let gregorian = Calendar.current
        let comps: DateComponents? = gregorian.dateComponents(unitFlags, from: date)
//        comps?.day = (comps?.day)! + days
        let newDate: Date? = gregorian.date(from: comps!)
        return newDate!
    }

    /**
     Convert date string to contains AM & PM.
     
     - parameter dateString: The date you want to convert in a string format
     
     - returns: Date with AM & PM.
     */
    class func convertDateStringTimeToBeAMandPM(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let date: Date? = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        return dateFormatter.string(from: date!)
    }

    /**
     Convert date string from english to arabic.
     
     - parameter dateString: The date you want to convert in a string format
     
     - returns: Date in arabic.
     */
    class func convertEnglishDateStringToArabic(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let date: Date? = dateFormatter.date(from: dateString)
        dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm a"
        return dateFormatter.string(from: date!)
    }

    /**
     Convert date to string.
     
     - parameter date: The date you want to convert
     - parameter style: The style you want string to be formatted with
     - parameter sequence: The sequence that you want the string to be formatted with
     
     - returns: Date as string with the passed formats.
     */
    class func convertDateToString(_ date: Date, style: DateFormattingStyle, sequence: DateFormattingSequence) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = self.convertFormateToStringWith(dateStyle: style, sequence: sequence)
        return formatter.string(from: date)
    }
    
    /**
     Convert date string to date object.
     
     - parameter dateString: The date you want to convert in a string format
     - parameter dateFormat: The format of the date you want to convert
     
     - returns: Date as an object.
     */
    class func convertStringToDate(_ dateString: String, dateFormat : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateString)
    }

    /**
     Convert GMT date as string to local date.
     
     - parameter date: The date you want to convert
     
     - returns: Date in local time.
     */
    class func converGMTStringToLocalDate(_ date: String) -> Date {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter1.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let GMTDate: Date? = dateFormatter1.date(from: date)
        print("date : \((GMTDate)!)")
        let currentTimeZone = NSTimeZone.local
        let utcTimeZone = NSTimeZone(abbreviation: "UTC")
        let currentGMTOffset: Int = currentTimeZone.secondsFromGMT(for: GMTDate!)
        let gmtOffset: Int = utcTimeZone!.secondsFromGMT(for: GMTDate!)
        let gmtInterval: TimeInterval = TimeInterval(CFloat(currentGMTOffset - gmtOffset))
        let destinationDate = Date(timeInterval: gmtInterval, since: GMTDate!)
        
        return destinationDate
    }

    /**
     Get the differences between now and a date.
     
     - parameter date: The date you want to convert
     
     - returns: The difference between the two dates with strings.
     */
    class func getDifferenceBetweenNowAndDate(_ date: Date) -> String {
        let now = Date()
        let calendar = Calendar.current
        
        let unitFlags = Set<Calendar.Component>([.year, .day, .month, .hour, .minute, .second])
        let difference: DateComponents? = calendar.dateComponents(unitFlags, from: now, to: date)
        if (difference?.day)! > 0 {
            return "\(Int((difference?.day)!)) Days"
        }
        else if (difference?.hour)! > 0 {
            return "\(Int((difference?.hour)!)) Hours"
        }
        else if (difference?.minute)! > 0 {
            return "\(Int((difference?.minute)!)) Minute"
        }

        return ""
    }

    /**
     Check if date is between two dates.
     
     - parameter date: The date you want to check
     - parameter beginingDate: The date you want it to be the lower boundary for the check
     - parameter endingDate: The date you want it to be the upper boundary for the check
     
     - returns: True of false based on if the date is between the ranges or not.
     */
    class func isDate(_ date: Date, inRangeBetweenBegining beginingDate: Date, andEnding endingDate: Date) -> Bool {
        return date.compare(beginingDate) == .orderedDescending && date.compare(endingDate) == .orderedAscending
    }

    /**
     Manipulate date to a specific formats.
     
     - parameter date: The date you want to manipulate
     - parameter todayStyle: The style if the date is today
     - parameter todaySequence: The sequence if the date is today
     - parameter yesterdayStyle: The style if the date is yesterday
     - parameter yesterdaySequence: The sequence if the date is yesterday
     - parameter otherDateStyle: The style if the date is other than today or yesterday
     - parameter otherDateSequence: The sequence if the date is other than today or yesterday
     
     - returns: The manipulated date as string.
     */
    class func manipulateDate(_ date: Date, withTodayStyle todayStyle: DateFormattingStyle, andWithTodaySequence todaySequence: DateFormattingSequence, andWithYesterdayStyle yesterdayStyle: DateFormattingStyle, andWithYesterdaySequence yesterdaySequence: DateFormattingSequence, andWithOtherDateStyle otherDateStyle: DateFormattingStyle, andWithOtherDatedaySequence otherDateSequence: DateFormattingSequence) -> String {
        let today = Date()
        let yesterday: Date = self.addDays(-1, to: today)
        
        var index = today.description.index(today.description.startIndex, offsetBy: 10)
        let todayString: String? = String(today.description[today.description.startIndex..<index])
        
        index = yesterday.description.index(yesterday.description.startIndex, offsetBy: 10)
        let yesterdayString: String? = String(yesterday.description[yesterday.description.startIndex..<index])
        
        index = date.description.index(date.description.startIndex, offsetBy: 10)
        let dateString: String? = String(date.description[date.description.startIndex..<index])
        
        if (dateString == todayString) {
            return self.convertDateToString(date, style: todayStyle, sequence: todaySequence)
        }
        else if (dateString == yesterdayString) {
            return self.convertDateToString(date, style: yesterdayStyle, sequence: yesterdaySequence)
        }
        else {
            return self.convertDateToString(date, style: otherDateStyle, sequence: otherDateSequence)
        }

    }
    
    /**
     Converts styles and sequence to a string so that you can use in the formatter.
     
     - parameter dateStyle: The style you want string to be formatted with
     - parameter sequence: The sequence that you want the string to be formatted with
     
     - returns: String with the styles and sequences provided to be used in the formatter.
     */
    private class func convertFormateToStringWith(dateStyle: DateFormattingStyle, sequence: DateFormattingSequence) -> String {
        var dateSeperator: String? = nil
        var timeSeperator: String? = nil
        var dateFormat: String? = nil
        switch dateStyle {
            case .withDashes:
                dateSeperator = "-"
                timeSeperator = ":"
            case .withSeperators:
                dateSeperator = "/"
                timeSeperator = ":"
            case .withDots:
                dateSeperator = ":"
                timeSeperator = ":"
            case .withSpacesAndDotsForTime:
                dateSeperator = " "
                timeSeperator = ":"
        }

        switch sequence {
            case .dayMonthYear:
                dateFormat = "dd\((dateSeperator)!)MM\((dateSeperator)!)yyyy"
            case .monthDayYear:
                dateFormat = "MM\((dateSeperator)!)dd\((dateSeperator)!)yyyy"
            case .yearMonthDay:
                dateFormat = "yyyy\((dateSeperator)!)MM\((dateSeperator)!)dd"
            case .todayWithHoursAndSecondsAndPeriod:
                dateFormat = "'Today'\((dateSeperator)!)\((timeSeperator)!)\((dateSeperator)!)"
            case .yesterdayWithHoursAndSecondsAndPeriod:
                dateFormat = "'Yesterday'\((dateSeperator)!)\((timeSeperator)!)\((dateSeperator)!)"
            case .dayWrittenMonthYearWithHoursAndSecondsAndPeriod:
                dateFormat = "dd\((dateSeperator)!)MMM\((dateSeperator)!)\(( dateSeperator)!)\((timeSeperator)!)\((dateSeperator)!)"
        }

        return dateFormat!
    }
}

//
//  Constants.swift
//  TripArcher
//
//  Created by APPLE on 19/11/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import UIKit


struct WebServicesUrl{
    
    
    //Test URL
    //Flight
    static let FlightServiceUrl = "http://192.168.1.3:2217/FlightService.asmx"
    static let FlightResult = "FlightResult"
    static let FlightImgURL = "https://www.shioktrip.com/Airline_Images/"
    
    //Hotel
    static let HotelServiceUrl = "http://192.168.1.3:2217/hotelService.asmx"
    static let HotelServiceUrlLive = "http://mobileapi.shioktrip.com/hotelService.asmx"
    
    static let HotelResult = "GetHotelResult"
    static let HotelDetails = "GetHotelDetails"
    static let GetDestinationList = "GetDestinationList"
  
    //Profile
    static let MainURL = "http://192.168.1.3:2217/Profile.asmx"
    static let Login = "Login"
    
    //MyBookings
    static let MyBookingURL = "http://192.168.1.3:2217/myaccountlistservice.asmx"
    static let MyTrips = "GetBookingList"
}

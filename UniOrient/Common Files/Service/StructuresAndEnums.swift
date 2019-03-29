//
//  StructuresAndEnums.swift
//  TripArcher
//
//  Created by APPLE on 22/11/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import UIKit


struct TravellerDetailStruct {
    var structIndex : String!
    var travellerTitle : String!
    var firstName : String!
    var lastName : String!
    var dateOfBirth : String!
    var passportNo : String!
    var expiryDate : String!
    var filterStr : String!
    
}

//{"CityCode":"KBL","CityName":"Kabul","CountryCode":"AF","CountryName":"Afghanistan"}
//not using
struct HotelCityStruct{
    var cityCode : String!
    var cityName : String!
    var countryCode : String!
    var countryName : String!
}

/*
{
    "ID": null,
    "Country": "Portugal",
    "AirportName": null,
    "CityName": "Coimbra",
    "CitySk": "554",
    "CountryCode": null,
    "City": "Coimbra",
    "CityCode": null,
    "ctype": "City",
    "Address": "the centre of Portugal, Portugal"
} */
struct HotelCityStructNew{
    var ID : String!
    var Country : String!
    var AirportName : String!
    var CityName : String!
    var CitySk : String!
    var CountryCode : String!
    var City : String!
    var CityCode : String!
    var ctype : String!
    var Address : String!  
}


//{"AirportCode":"CJB","CityName":"Coimbatore(CJB)","Country_sK":1.0,"CountryName":"India"}
struct AirportStruct : Equatable {
    var airportCode : String!
    var cityName : String!
    var countrySK : String!
    var countryName : String!
    
//    static func == (lhs : AirportStruct,rhs : AirportStruct) -> Bool {
//        return lhs.airportCode == rhs.airportCode
//    }
}

/*
struct Car: Equatable {
    
    var modelName = String()
    var manufacturer = String()
    
    init(modelName: String, manufacturer: String) {
        self.modelName = modelName
        self.manufacturer = manufacturer
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.modelName == rhs.modelName
    }
} */

struct FlightResultAndDetailStruct {

    var wayType : String!
    
    //for going
    
    var flightID : String!
    
    var faretype : String!
    var departureDate : String!
    var arrivalDate :String!
    
    var flightImgName : String!
    var flightImgData : Data?
    var flightName : String!
    var departureTime : String!
    var departureAirportCode : String!
    var duration : String!
    var stopDetails : String!
    var noOfStops : String!
    var arrivalTime : String!
    var arrivalAirportCode : String!
    var amount : String!
    
    var CabinBaggage:String!
    var CheckInBaggage:String!
    
    var isMultiAirlineAvailable : Bool!
    var detailArrWithFlightDetailStruct = [FlightDetailStruct]()
    
    
    //for returning
//    var returnFlightID : String!
    var returnDepartureDate : String!
    var returnArrivalDate : String!
    
    var returnFlightImgName : String!
    var returnFlightImgData : Data!
    var returnFlightName : String!
    var returnDepartureTime : String!
    var returnDepartureAirportCode : String!
    var returnDuration : String!
    var returnNoofStops : String!
    var returnArrivalTime :String!
    var returnArrivalAirportCode : String!
    
    var isReturnMultiAirlineAvailable : Bool!
    var returnDetailArrWithFlightDetailStruct = [FlightDetailStruct]()
    
    var isSelected : Bool = false // This flag is for Filter Operation
    
}
struct FlightDetailStruct {
    var flightImgName : String!
    var flightImgData : Data!
    var flightNumber : String!
    var departureDate : String!
    var departureTime : String!
    var arrivalDate : String!
    var arrivalTime : String!
    
    var marketing : String!
    var operating : String!
    var duration : String!
    var fromAirportName : String!
    var toAirportName : String!
    
    var departureDateTime : String!
    var arrivalDateTime : String!
    
//    var flightName : String!
    var stop : String!
    var fromCity : String!
    var toCity : String!
}

struct FinalStruct {  //: Equatable {
    
    var CabinBaggage : String!
    var CheckInBaggage : String!
    
    var departureDate : String!
    var arrivalDate : String!
    
    var flightImgName : String!
    var flightImgData : Data?
    var flightName : String!
    var departureTime : String!
    var departureAirportCode : String!
    var duration : String!
    var stop : String!
    var arrivalTime : String!
    var arrivalAirportCode : String!
    
    var TripDetailsArr = [FlightDetailStruct]()
    
//    static func == (lhs : FinalStruct,rhs : FinalStruct) -> Bool {
//        return lhs.flightName == rhs.flightName
//    }
}
extension FinalStruct {
//    var structExtension : String!
    
}

//Not Required
struct RoomStruct1 {
    var roomNo : String!
    var noOfAdult : String!
    var noOfChildren : String!
    var ageArr = [ChildrenAgeStruct2]()
}
//Not Required
struct ChildrenAgeStruct2 {
    var age : String!
}

struct RoomStruct {
    var roomNo : Int!
    var noOfAdult : Int!
    var noOfChildren : Int!
    var ageArr = [ChildrenAgeStruct]()
}
struct ChildrenAgeStruct {
    var age : Int!
}


// Hotel

struct HotelStruct {
    
    var HotelUniqueKey : String!
    var processId : String!
    var RoomcategoryCode : String!
    var APIType : String!
    
    var NoOfRooms : String!
    var NoOfNights : String!
    var CheckInDate : String!
    var CheckOutDate : String!
    var HotelName : String!
    var ThumbNailImage : String!
    var Address : String!
    var StarRating : String!
    var RatingImage : String!
    var DispTotalAmount : String!
    var RoomDetailArr = [RoomDetailStruct]()
    
    var city : String?
    var country : String?
    var hotelImgData : Data?
}

struct RoomDetailStruct {
    var RoomDescription : String!
    var inclusions : String!
    var TotalAmount : String!
    var Cancellationpolicy : String!
    var BaseFareAmount : String!
    var TotalTaxCharges : String!
    var TotalAmountMarkupWithTax : String!
    var NoOfNights : String!
    var Discount : String!
}



struct HoteltlStruct{
    var hotel_name : String!
    var Address : String!
    var city : String!
    var state : String!
    var country : String!
    var zip : String!
    var locality : String!
    var ContactNumber : String!
    
    var checkin : String!
    var checkout : String!
    var numberofrooms : String!
    var numberoffloors : String!
    var Rating : String!
    var amenity_text : String!
    var roomtype : String!
    var bedtype : String!
    var noofbeds : String!
    var noofpax : String!
    var latitude : String!
    var longitude : String!
    var description : String!
    
    var overview : String!
}

struct FacilitytlStruct {
    var amenity_text : String!
    
    var Facility : String!
    var FacilityType : String!
}
struct GallerytlStruct{
    var thumb_nail_image_Url : String!
    var wide_angle_Image_Url : String!
    
    var imagepath : String!
}
struct ReviewtlStruct {
    
}
    

//HotelFaciltyGalleryContainerStruct
struct HFGContainerStruct {
    var HoteltlArr = [HoteltlStruct]()
    var FaciltytlArr = [FacilitytlStruct]()
    var GallerytlArr = [GallerytlStruct]()
}

struct FlightUserSelectedFiltersStruct {
    var preferredAirlinesArr : [String]
    var isNonStop : Bool! // = false
    var isOneStop : Bool! //= false
    var isTwoPlusStops : Bool! //= false
    
    var beforeElevenAM : Bool = false
    var elevenAMToFivePM : Bool = false
    var fivePMToNinePM : Bool = false
    var afterNinePM : Bool = false
    
    
//    var isReturnMultiAirlineAvailable : Bool!
}

struct HotelFilterStruct {
    var hotelName : String!
    var isSelectedAh : Bool!
//    mutating func setIsSelected(x:Bool){
//        self.isSelected = x
//    }
}
struct HotelUserSelectedFiltersStruct {
    var preferredHotelArr : [String]
    var isOneStar : Bool! // = false
    var isTwoStar : Bool! //= false
    var isThreeStar : Bool! //= false
    var isFourStar : Bool!
    var isFiveStar : Bool!
    
}

/*
struct FlightFilterStruct {
    var flightName : String!
    var flightImgData : Data!
    var isSelected : Bool!
}*/

struct LoginResponse {
    var UserSK : String!
    var Name : String!
    var PhoneNo:String!
}
struct LoginDetails {
    var Email:String!
    var Password:String!
}
struct NotificationStruct {
    static let LogOutNotif = NSNotification.Name(rawValue: "LogoutNotif")
}

struct MyTripsStruct {
    var Rownumber : String!
    var Booking_sk : String!
    var BookingNo : String!
    var Booking_Date : String!
    var Departure : String!
    var Arrival : String!
    var PNRNo : String!
    var Module_sk : String!
    var TotalAmt : String!
    var ProviderName : String!
    var BookingStatus : String!
    var Module : String!
    var DomainType : String!
}

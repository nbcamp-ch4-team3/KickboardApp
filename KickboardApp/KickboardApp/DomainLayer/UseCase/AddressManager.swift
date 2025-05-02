//
//  AddressManager.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation
import CoreLocation

final class AddressManager {
    func fetchAddress(lat: Double, lng: Double) async throws -> String {
        var resultString: String
        let location = CLLocation(latitude: lat, longitude: lng)
        let placemarker = try await CLGeocoder().reverseGeocodeLocation(location).first
        
        resultString = "\(placemarker?.administrativeArea ?? "") \(placemarker?.locality ?? "") \(placemarker?.subLocality ?? "")"
        return resultString
    }
}

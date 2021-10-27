//
//  LocationManager.swift
//  LocationApp
//
//  Created by Rayana Prata Neves on 27/10/21.
//

import CoreLocation

class LocationManager {
    
    static var shared: CLLocationManager = {
        let instance = CLLocationManager()
        return instance
    }()
    
    private init() { }
    
    // verifica se existe hardware de GPS
    static func hasGPS() -> Bool {
        return CLLocationManager.significantLocationChangeMonitoringAvailable()
    }
    
    // Foreground -> como usuário eu permito que o app use minha localizacao quando eu tiver usando o app
    static func isAuthorizedWhenInUse() -> Bool {
        let status = shared.authorizationStatus
        return status == .authorizedWhenInUse
    }
    
    // Background -> como usuário eu permito que o app use minha localizacao mesmo com o app fechado (quando ele está rodando em segundo plano)
    static func isAuthorizedAlways() -> Bool {
        let status = shared.authorizationStatus
        return status == .authorizedAlways
    }
    
}

/// Singletone should not be cloneable
extension LocationManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

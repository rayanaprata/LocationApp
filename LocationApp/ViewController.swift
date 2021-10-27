//
//  ViewController.swift
//  LocationApp
//
//  Created by Rayana Prata Neves on 27/10/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    // MARK: Properties
    let mLocation = LocationManager.shared
    
    // MARK: Outlets
    @IBOutlet weak var labelNorthSouth: UILabel!
    @IBOutlet weak var labelEastWest: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        setupMap()
    }

    // MARK: Methods
    
    private func setupMap() {
        map.userTrackingMode = .followWithHeading
    }
    
    private func setupLocation() {
        guard LocationManager.hasGPS() else { return }
        mLocation.delegate = self
        if LocationManager.isAuthorizedWhenInUse() {
//            mLocation.requestLocation()
            mLocation.startUpdatingLocation()
        } else {
            mLocation.requestWhenInUseAuthorization()
        }
    }

    private func showHemisphere(position: CLLocation) {
        showEastWest(longitude: position.coordinate.longitude)
        showNorthSouth(latitude: position.coordinate.latitude)
    }
    
    private func showEastWest(longitude: Double) {
        if longitude >= 0 {
            labelEastWest.text = Hemispheres.EASTERN.rawValue
        } else {
            labelEastWest.text = Hemispheres.WESTERN.rawValue
        }
    }
    
    private func showNorthSouth(latitude: Double) {
        if latitude >= 0 {
            labelNorthSouth.text = Hemispheres.NORTH.rawValue
        } else {
            labelNorthSouth.text = Hemispheres.SOUTH.rawValue
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    // Executa toda vez que chegar novas coordenadas
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location size \(locations.count)")
        if let location = locations.first {
            let mPosition = CLLocation(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude)
            self.showHemisphere(position: mPosition)
        }
    }
    
    // Executa quando ocorre um erro
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
    
    // Executa quando o usuário muda a autorização
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if LocationManager.isAuthorizedWhenInUse() || LocationManager.isAuthorizedAlways() {
//            mLocation.requestLocation()
            mLocation.startUpdatingLocation()
        }
    }
    
}

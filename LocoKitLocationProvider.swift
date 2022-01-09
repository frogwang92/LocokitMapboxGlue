//
//  LocoKitLocationProvider.swift
//  nCycling
//
//  Created by yi on 2022/1/5.
//

import Foundation
import MapboxMaps
import LocoKit

extension LocomotionManager: LocationProvider {
    
    public var locationProviderOptions: LocationOptions {
        get {
            LocoKitLocationProviderStoreHelper.instance.locationOption
        }
        set(newValue) {
            LocoKitLocationProviderStoreHelper.instance.locationOption = newValue
        }
    }
    
    public var authorizationStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    public var accuracyAuthorization: CLAccuracyAuthorization {
        if #available(iOS 14.0, *) {
            return locationManager.accuracyAuthorization
        } else {
            return .fullAccuracy
        }
    }
    
    public var heading: CLHeading? {
        return locationManager.heading
    }
    
    public func setDelegate(_ delegate: LocationProviderDelegate) {
        LocoKitLocationProviderStoreHelper.instance.delegate = delegate
    }
    
    public func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    public func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func requestTemporaryFullAccuracyAuthorization(withPurposeKey purposeKey: String) {
        locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: purposeKey)
    }
    
    public func startUpdatingLocation() {
        // locationManager.startUpdatingLocation()
        self.locationManagerDelegate = LocoKitLocationProviderStoreHelper.instance
        startRecording()
    }
    
    public func stopUpdatingLocation() {
        // locationManager.stopUpdatingLocation()
        stopRecording()
    }
    
    public var headingOrientation: CLDeviceOrientation {
        get {
            locationManager.headingOrientation
        }
        set(newValue) {
            locationManager.headingOrientation = newValue
        }
    }
    
    public func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    public func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    public func dismissHeadingCalibrationDisplay() {
        locationManager.dismissHeadingCalibrationDisplay()
    }
    
}

class LocoKitLocationProviderStoreHelper: NSObject, CLLocationManagerDelegate {
    public weak var delegate: LocationProviderDelegate?
    public var locationOption: LocationOptions

    static let instance = LocoKitLocationProviderStoreHelper()

    private override init() {
        locationOption = LocationOptions()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationProvider(LocomotionManager.highlander, didUpdateLocations: locations)
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        delegate?.locationProvider(LocomotionManager.highlander, didUpdateHeading: heading)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationProvider(LocomotionManager.highlander, didFailWithError: error)
    }

    @available(iOS 14.0, *)
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.locationProviderDidChangeAuthorization(LocomotionManager.highlander)
    }
    
}

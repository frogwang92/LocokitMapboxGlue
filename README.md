# LocokitMapboxGlue
A code snippet for glue Locokit and Mapbox

## usage:
override the locationProvider for MapboxView:
```swift
mapView.location.overrideLocationProvider(with: LocomotionManager.highlander)
```

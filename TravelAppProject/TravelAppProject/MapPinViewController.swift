//
//  MapPinViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/14.
//

import UIKit
import MapKit
import RealmSwift

struct Location {
    var location: String
    var latitude: Double
    var longitude: Double
    
    init(location: String, latitude: Double, longitude: Double) {
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
}

class MapPinViewController: UIViewController, MKMapViewDelegate {
    var sectionCount = 0
    var dateArray = [Date]()
    var id: ObjectId?
    let realm = try! Realm()
    lazy var locations = [[Location]](repeating: [], count: sectionCount)
    var directionArray = [CLLocationCoordinate2D]()
//    var placeArray = [MKPlacemark]()
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(MapPinCollectionviewCell.self, forCellWithReuseIdentifier: MapPinCollectionviewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.mapView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        locationArrayMake()
        setAutoLayout()
        setMapPin()
        print(dateArray)
    }
    func locationArrayMake() {
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        for i in 0..<dateArray.count {
            for j in 0..<main.detail.count {
                if dateArray[i] == main.detail[j].date {
                    locations[i].append(Location(location: main.detail[j].location, latitude: main.detail[j].latitude, longitude: main.detail[j].longitude))
                }
            }
        }
    }
    
    func setMapPin() {
        for i in 0..<dateArray.count {
            for j in 0..<locations[i].count {
                let place = PlaceAnnotation(id: "\(i + 1)", title: locations[i][j].location, locationName: "\(i + 1)일차 \(j + 1)번째", discipline: "", coordinate: CLLocationCoordinate2D(latitude: locations[i][j].latitude, longitude: locations[i][j].longitude), pinTintColor: .black)
                mapView.addAnnotation(place)
                mapView.showAnnotations([place], animated: true)
            }
        }
    }
    
    func setAutoLayout() {
        [mapView, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            mapView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        
    }
    
    
}
extension MapPinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapPinCollectionviewCell.identifier, for: indexPath) as? MapPinCollectionviewCell else { return UICollectionViewCell() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd \nE"
        if indexPath.item == 0 {
            cell.dateLabel.text = "All".localized
        } else {
            cell.dateLabel.text =  dateFormatter.string(from: dateArray[indexPath.item - 1])
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            mapView.removeOverlays(mapView.overlays)
            directionArray.removeAll()
            setMapPin()
        } else {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        let directionRequest = MKDirections.Request()
        directionRequest.transportType = .walking
        directionArray.removeAll()
            for i in 0..<locations[indexPath.item - 1].count {
                let place = PlaceAnnotation(id: "\(i + 1)", title: locations[indexPath.item - 1][i].location, locationName: "", discipline: "", coordinate: CLLocationCoordinate2D(latitude: locations[indexPath.item - 1][i].latitude, longitude: locations[indexPath.item - 1][i].longitude), pinTintColor: .black)
                let annotationView = MKAnnotationView(annotation: place, reuseIdentifier: "custom")
                annotationView.image = UIImage(systemName: "\(i + 1).circle")
                mapView.addAnnotation(place)
                mapView.showAnnotations([place], animated: true)
                directionArray.append(place.coordinate)
                let polyline = MKPolyline(coordinates: directionArray, count: directionArray.count)
                mapView.addOverlay(polyline)
            }
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKGradientPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 1
//        renderer.strokeColor = .systemCyan
        renderer.setColors([
            UIColor(red: 0.02, green: 0.91, blue: 0.05, alpha: 1.0),
            UIColor(red: 1.0, green: 0.48, blue: 0.0, alpha: 1.0),
            UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        ], locations: [])
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Custom") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
            let naviButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
            naviButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
            naviButton.tintColor = .black
            annotationView?.rightCalloutAccessoryView = naviButton
            
        } else {
            annotationView?.annotation = annotation
        }
//        annotationView?.image = UIImage(systemName: "\(?)".circle")
        annotationView?.markerTintColor = .black
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
          print("calloutAccessoryControlTapped")
       }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let firstAnnotation = MKPointAnnotation()
        let secondAnnotation = MKPointAnnotation()
        print(view.annotation!.coordinate)
        
        
//        firstAnnotation.coordinate = CLLocationCoordinate2D(latitude: locations[collectionView.tag - 1][view.tag - 1].latitude, longitude: locations[self.tabBarItem.tag - 1][view.tag - 1].longitude)
//        secondAnnotation.coordinate = CLLocationCoordinate2D(latitude: locations[collectionView.tag][view.tag].latitude, longitude: locations[self.tabBarItem.tag][view.tag].longitude)
//        
//        let firstPlaceMark = MKPlacemark(coordinate: firstAnnotation.coordinate)
//        let secondPlaceMark = MKPlacemark(coordinate: secondAnnotation.coordinate)
//        
//        let firstMapItem = MKMapItem(placemark: firstPlaceMark)
//        let secondMapItem = MKMapItem(placemark: secondPlaceMark)
//        
//        self.mapView.showAnnotations([firstAnnotation, secondAnnotation], animated: true)
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = firstMapItem
//        directionRequest.destination = secondMapItem
//        directionRequest.transportType = .walking
//        
//        let direction = MKDirections(request: directionRequest)
//        
//        direction.calculate { (response, error) in
//            guard let response = response else {
//                if let error = error {
//                    print("error")
//                }
//                return
//            }
//            let route = response.routes[0]
//            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
//            
//            let rect = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//        }
    }
}

class PlaceAnnotation: NSObject, MKAnnotation  {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    var pinTintColor: UIColor
    
init(id: String, title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, pinTintColor: UIColor) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.pinTintColor = pinTintColor
    
    super.init()
    }
}

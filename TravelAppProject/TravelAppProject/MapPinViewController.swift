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
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class MapPinViewController: UIViewController, MKMapViewDelegate {
    var sectionCount = 0
    var dateArray = [Date]()
    var id: ObjectId?
    let realm = try! Realm()
    lazy var locations = [[Location]](repeating: [Location(latitude: 0.0, longitude: 0.0)], count: sectionCount)
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .yellow
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
    }
    func locationArrayMake() {
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        for i in 0..<sectionCount { // ex) 0과 1을돌고
            for j in 0..<main.detail.count { //ex) detail의 값들을 돌고
                if i == main.detail[j].section { // ex) i와 detail의 section값이 같으면 배열에 추가
                    locations[i].append(Location(latitude: main.detail[j].latitude, longitude: main.detail[j].longitude))
                }
            }
        }
        
        print(locations)
    }
    
    func setMapPin() {

            for i in 0..<sectionCount {
                for j in 0..<locations[i].count {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: locations[i][j].latitude, longitude: locations[i][j].longitude)
                    annotation.title = "\(i + 1)일차 \(j)번째"
                    mapView.addAnnotation(annotation)
                    print(annotation)
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
        return sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapPinCollectionviewCell.identifier, for: indexPath) as? MapPinCollectionviewCell else { return UICollectionViewCell() }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mapView.removeAnnotations(mapView.annotations)
        for i in 0..<locations[indexPath.item].count {
                let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locations[indexPath.item][i].latitude, longitude: locations[indexPath.section][i].longitude)
            annotation.title = "\(indexPath.item)일차 \(i)번째"
                mapView.addAnnotation(annotation)
                print(annotation)
            }
        
        
        mapView.reloadInputViews()
    }
    
}

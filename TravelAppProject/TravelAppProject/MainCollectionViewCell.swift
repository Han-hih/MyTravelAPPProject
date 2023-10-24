//
//  MainCollectionViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/06.
//

import UIKit
import RealmSwift

class MainCollectionViewCell: UICollectionViewCell {
    static let shared = MainCollectionViewCell()
    
    private enum Color {
        static var gradientColors = [
            UIColor(hexCode: "#FF2A2B", alpha: 1),
            UIColor(hexCode: "#FF2A2B", alpha: 0.7),
            UIColor(hexCode: "#FF2A2B", alpha: 0.4),
            UIColor(hexCode: "#2A46FF", alpha: 0.3),
            UIColor(hexCode: "#2A46FF", alpha: 0.7),
            UIColor(hexCode: "#2A46FF", alpha: 0.3),
            UIColor(hexCode: "#8325FF", alpha: 0.4),
            UIColor(hexCode: "#8325FF", alpha: 0.7),
            
            
//          UIColor.systemRed.withAlphaComponent(0.7),
//          UIColor.systemRed.withAlphaComponent(0.4),
//          UIColor.systemYellow.withAlphaComponent(0.3),
//          UIColor.systemYellow.withAlphaComponent(0.7),
//          UIColor.systemYellow.withAlphaComponent(0.3),
//          UIColor.systemPink.withAlphaComponent(0.4),
//          UIColor.systemPink.withAlphaComponent(0.7),
        ]
      }
      private enum Constants {
        static let gradientLocation = [Int](0..<Color.gradientColors.count)
          .map(Double.init)
          .map { $0 / Double(Color.gradientColors.count) }
          .map(NSNumber.init)
        static let cornerRadius = 20.0
        static let cornerWidth = 2.0
//        static let viewSize = CGSize(width: 100, height: 350)
      }
    private var timer: Timer?
    deinit {
        print("deinit")
        self.timer?.invalidate()
        self.timer = nil
    }
   private let barcodeView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "topviewimage")
        return view
    }()
 
    
   private let mainView = {
        let view = UIView()
        //        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        //        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
  private let bottomView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let travelLabel = {
        let label = CustomLabel()
        label.text = "Destination".localized
        return label
    }()
    
    private let startLabel = {
        let label = CustomLabel()
        label.text = "Start Date".localized
        return label
    }()
    
    private let endLabel = {
        let label = CustomLabel()
        label.text = "End Date".localized
        return label
    }()
    private let gradationView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    private let viewLabel = {
        let label = PaddingLabel()
        label.text = " VIEW YOUR PLAN "
        label.font = .boldSystemFont(ofSize: 30)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
//        label.layer.borderColor = UIColor.black.cgColor
//        label.layer.borderWidth = 1
        return label
    }()
    
    let travelPlaceLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "ROK"
        return label
    }()
    
    let startDateLabel = {
        let label = CustomDateLabel()
        return label
    }()
    
    let endDateLabel = {
        let label = CustomDateLabel()
        return label
    }()
    
    let countryFullLabel = {
        let label = UILabel()
        label.text = "UNITED STATES MINOR OUTLYING ISLANDS,United States minor outlying islands"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradationAnimate()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.gradationAnimate()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradationAnimate()
    }
    
    func gradationAnimate() {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(roundedRect: self.gradationView.bounds.insetBy(dx: Constants.cornerWidth, dy: Constants.cornerWidth), cornerRadius: self.gradationView.layer.cornerRadius).cgPath
        shape.lineWidth = Constants.cornerWidth
        shape.cornerRadius = Constants.cornerRadius
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        self.gradationView.layer.mask = shape
        
        let gradient = CAGradientLayer()
           gradient.frame = self.gradationView.bounds
           gradient.type = .conic
           gradient.colors = Color.gradientColors.map(\.cgColor) as [Any]
           gradient.locations = Constants.gradientLocation
           gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
           gradient.endPoint = CGPoint(x: 1, y: 1)
           gradient.mask = shape
           gradient.cornerRadius = Constants.cornerRadius
           self.gradationView.layer.addSublayer(gradient)
        
        self.timer?.invalidate()
           self.timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
             gradient.removeAnimation(forKey: "myAnimation")
             let previous = Color.gradientColors.map(\.cgColor)
             let last = Color.gradientColors.removeLast()
             Color.gradientColors.insert(last, at: 0)
             let lastColors = Color.gradientColors.map(\.cgColor)
             
             let colorsAnimation = CABasicAnimation(keyPath: "colors")
             colorsAnimation.fromValue = previous
             colorsAnimation.toValue = lastColors
             colorsAnimation.repeatCount = 1
             colorsAnimation.duration = 0.4
             colorsAnimation.isRemovedOnCompletion = false
             colorsAnimation.fillMode = .both
             gradient.add(colorsAnimation, forKey: "myAnimation")
           }
    }
    
    func setAutoLayout() {
        [barcodeView, imageView, mainView, bottomView, travelLabel, startLabel, endLabel, gradationView, viewLabel, travelPlaceLabel, startDateLabel, endDateLabel, countryFullLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            // MARK: - 바코드뷰
            barcodeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            barcodeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            barcodeView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            barcodeView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
            imageView.topAnchor.constraint(equalTo: barcodeView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: barcodeView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: barcodeView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: barcodeView.bottomAnchor, constant: -10),
            // MARK: - 메인뷰
            mainView.topAnchor.constraint(equalTo: barcodeView.bottomAnchor),
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: barcodeView.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            // MARK: - 하단뷰
            bottomView.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            bottomView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomView.widthAnchor.constraint(equalTo: barcodeView.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            // MARK: - 여행레이블뷰
            travelLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            travelLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            // MARK: - 시작날짜
            startLabel.topAnchor.constraint(equalTo: travelLabel.topAnchor),
            startLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            // MARK: - 끝날짜
            endLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            endLabel.topAnchor.constraint(equalTo: mainView.centerYAnchor),
            // MARK: - 하단뷰에 들어가는 뷰
            gradationView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            gradationView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            gradationView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.6),
            gradationView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.9),
            // MARK: - 하단뷰에 들어가는 레이블
            viewLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            // MARK: - 여행지 레이블
            travelPlaceLabel.topAnchor.constraint(equalTo: travelLabel.bottomAnchor, constant: 5),
            travelPlaceLabel.leadingAnchor.constraint(equalTo: travelLabel.leadingAnchor),
            // MARK: - 시작날짜 레이블
            startDateLabel.topAnchor.constraint(equalTo: travelPlaceLabel.topAnchor),
            startDateLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            // MARK: - 끝 날짜 레이블
            endDateLabel.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: 5),
            endDateLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            // MARK: - 나라 전체 이름
            countryFullLabel.topAnchor.constraint(equalTo: travelPlaceLabel.bottomAnchor, constant: 2),
            countryFullLabel.leadingAnchor.constraint(equalTo: travelPlaceLabel.leadingAnchor),
            countryFullLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -5)
            
        ])
    }
}

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

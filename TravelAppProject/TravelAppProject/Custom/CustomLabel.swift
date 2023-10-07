//
//  CustomLabel.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/07.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUILabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUILabel() {
        textColor = .systemGray
        font = .boldSystemFont(ofSize: 18)
        
    }
    
}

class CustomDateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDateLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDateLabel() {
        font = .systemFont(ofSize: 20, weight: .semibold)
        textColor = .black
    }
    
    
}
@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topPadding: CGFloat = 10.0
    @IBInspectable var leftPadding: CGFloat = 10.0
    @IBInspectable var bottomPadding: CGFloat = 10.0
    @IBInspectable var rightPadding: CGFloat = 10.0
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.topPadding = padding.top
        self.leftPadding = padding.left
        self.bottomPadding = padding.bottom
        self.rightPadding = padding.right
    }
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets.init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += self.leftPadding + self.rightPadding
        contentSize.height += self.topPadding + self.bottomPadding
        return contentSize
    }
}

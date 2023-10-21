//
//  TextFieldExtensions.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/21.
//

import UIKit

class inputTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) { //paste값을 다른 것으로 바꿔서 설정가능(ex: 복사...)
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
    

}

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
           let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

            return newString.length <= maxLength
        
    }

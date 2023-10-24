//
//  SettingMessage.swift
//  TravelAppProject
//
//  Created by 황인호 on 10/24/23.
//

import Foundation
import MessageUI

class SettingMessage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        sendMail()
    }
    
    
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            print("실행됨")
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            let bodyString = """
                                    이곳에 내용을 작성해주세요.
                                    
                                    -------------------
                                    
                                    Device Model : \(self.getDeviceIdentifier())
                                    Device OS : \(UIDevice.current.systemVersion)
                                    App Version : \(self.getCurrentVersion())
                                    
                                    -------------------
                                    """
            // Configure the fields of the interface.
            composeVC.setToRecipients(["hih458@naver.com"])
            composeVC.setSubject("[여행은 Trip] 문의")
            composeVC.setMessageBody(bodyString, isHTML: false)
            
            // Present the view controller modally.
            present(composeVC, animated: true)
            
        } else {
            print("dddd")
            // Mail앱을 사용할 수 없을 경우
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                
            }
        }
    }
}
        extension SettingMessage: MFMailComposeViewControllerDelegate {
            func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                switch result {
                case .sent:
                    dismiss(animated: true)
                    print("메일 발송 성공 ( 인터넷이 안되는 경우도 sent처리되고, 인터넷이 연결되면 메일이 발송됨. )")
                case .saved:
                    dismiss(animated: true)
                    print("메일 발송 저장 ( 인터넷이 안되는 경우도 sent처리되고, 인터넷이 연결되면 메일이 발송됨. )")
                case .cancelled:
                    // 메일 작성 취소
                    print("메일 발송 취소 ( 인터넷이 안되는 경우도 sent처리되고, 인터넷이 연결되면 메일이 발송됨. )")
                    dismiss(animated: true)
                case .failed:
                    dismiss(animated: true)
                    print("메일 발송 실패 ( 인터넷이 안되는 경우도 sent처리되고, 인터넷이 연결되면 메일이 발송됨. )")
                }
                dismiss(animated: true)
            }
            func getDeviceIdentifier() -> String {
                var systemInfo = utsname()
                uname(&systemInfo)
                let machineMirror = Mirror(reflecting: systemInfo.machine)
                let identifier = machineMirror.children.reduce("") { identifier, element in
                    guard let value = element.value as? Int8, value != 0 else { return identifier }
                    return identifier + String(UnicodeScalar(UInt8(value)))
                }
                
                return identifier
            }
            func getCurrentVersion() -> String {
                guard let dictionary = Bundle.main.infoDictionary,
                      let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
                return version
            }
        }

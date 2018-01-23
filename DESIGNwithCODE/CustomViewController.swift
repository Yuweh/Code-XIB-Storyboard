//
//  PinCodeVerificationController.swift
//  GBA


import UIKit

protocol PinCodeVerificationDelegate{
    func PinCodeVerification()
    //func GBAVerification()
    //func ResendButton_tapped()
}

class PinCodeVerificationController: UIViewController, UITextFieldDelegate{
    
    var delegate: PinCodeVerificationDelegate? = nil
    var action: (()->Void)? = nil
    var APICall: ((String,PinCodeVerificationController)->Void)? = nil
    
    private let header_label: UILabel = UILabel()
        .set(fontStyle: GBAText.Font.main(GBAText.Size.header.rawValue).rawValue)
        .set(value: "Enter PIN code")
        .set(color: GBAColor.black.rawValue)
        .set(alignment: .center)
        .set(lines: 1)
    
    private let subscript_label: UILabel = UILabel()
        .set(fontStyle: GBAText.Font.main(GBAText.Size.subContent.rawValue).rawValue)
        .set(value: "We need your PIN code for you to access settings")
        .set(color: GBAColor.gray.rawValue)
        .set(alignment: .center)
        .set(lines: 0)
    
    private let toggleSetView: UIView = UIView()
    private let toggleViews: [GBAToggleView] = [GBAToggleView(), GBAToggleView(), GBAToggleView(), GBAToggleView(), GBAToggleView(), GBAToggleView()]
    //private let resend_button: UIButton = UIButton()
    
    private let input_textField: UITextField = UITextField()
    
    private var pinCodeInput: NSString = ""{
        didSet{
            self.toggleViews.forEach{ $0.toggle = .off }
            for i in 0..<pinCodeInput.length{
                self.toggleViews[i].toggle = .on
            }
            
            self.toggleSetView.layoutIfNeeded()
            
            if self.pinCodeInput.length == 6{
                guard let call = APICall else { fatalError("No ApiCalls was implemented for PINCodeVerificationViewController") }
                call(pinCodeInput as String, self)
            }
        }
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = .black
        self.view.backgroundColor = .white
        self.title = "PIN Code"
        
        self.layoutContents()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //self.resend_button.addTarget(self, action: #selector(resendBtn_tapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.input_textField.becomeFirstResponder()
    }
    
    private func layoutContents(){
        
        toggleSetView.backgroundColor = .clear
        
//        self.resend_button.backgroundColor = .clear
//        self.resend_button.setTitle("RESEND CODE", for: .normal)
//        self.resend_button.setTitleColor(GBAColor.primaryBlueGreen.rawValue, for: .normal)
//        self.resend_button.titleLabel?.set(fontStyle: GBAText.Font.main(UIScreen.main.bounds.width * 0.05).rawValue)
        
        self.input_textField.keyboardType = .namePhonePad
        self.input_textField.delegate = self
        
        self.view.addSubview(header_label)
        self.view.addSubview(subscript_label)
        self.view.addSubview(toggleSetView)
        //self.view.addSubview(resend_button)
        self.view.addSubview(input_textField)
        
        self.header_label.translatesAutoresizingMaskIntoConstraints = false
        self.header_label.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 30).Enable()
        self.header_label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).Enable()
        self.header_label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).Enable()
        
        self.subscript_label.translatesAutoresizingMaskIntoConstraints = false
        self.subscript_label.topAnchor.constraint(equalTo: self.header_label.bottomAnchor, constant: 5).Enable()
        self.subscript_label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).Enable()
        self.subscript_label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).Enable()
        
        self.toggleSetView.translatesAutoresizingMaskIntoConstraints = false
        self.toggleSetView.topAnchor.constraint(equalTo: self.subscript_label.bottomAnchor, constant: 50).Enable()
        self.toggleSetView.leadingAnchor.constraint(equalTo: self.subscript_label.leadingAnchor, constant: 35).Enable()
        self.toggleSetView.trailingAnchor.constraint(equalTo: self.subscript_label.trailingAnchor, constant: -35).Enable()
        self.toggleSetView.heightAnchor.constraint(equalTo: self.toggleSetView.widthAnchor, multiplier: 0.1).Enable()
        
        self.view.layoutIfNeeded()
        self.layoutToggleViews()
        
//        self.resend_button.translatesAutoresizingMaskIntoConstraints = false
//        self.resend_button.topAnchor.constraint(equalTo: self.toggleSetView.bottomAnchor, constant: 50).Enable()
//        self.resend_button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).Enable()
//        self.resend_button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).Enable()
//        self.resend_button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.06).Enable()
    }
    
    private func layoutToggleViews(){
        
        let spacing = (self.toggleSetView.width - (self.toggleSetView.height * 6)) / 5
        
        for i in 0..<toggleViews.count{
            toggleViews[i].toggle = .off
            self.toggleSetView.addSubview(self.toggleViews[i])
            
            self.toggleViews[i].translatesAutoresizingMaskIntoConstraints = false
            self.toggleViews[i].topAnchor.constraint(equalTo: self.toggleSetView.topAnchor).Enable()
            self.toggleViews[i].bottomAnchor.constraint(equalTo: self.toggleSetView.bottomAnchor).Enable()
            self.toggleViews[i].widthAnchor.constraint(equalTo: self.toggleViews[i].heightAnchor).Enable()
            
            if i == 0{ self.toggleViews[i].leadingAnchor.constraint(equalTo: self.toggleSetView.leadingAnchor).Enable() }
            else { self.toggleViews[i].leadingAnchor.constraint(equalTo: self.toggleViews[i - 1].trailingAnchor, constant: spacing).Enable() }
            
            if i == toggleViews.count - 1{ self.toggleViews[i].trailingAnchor.constraint(equalTo: self.toggleSetView.trailingAnchor).Enable() }
            toggleViews[i].layoutIfNeeded()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if pinCodeInput.length >= 6{ return false }
        var text = "\(String(describing: textField.text!))\(string)"
        if string == "" { text.removeLast() }
        pinCodeInput = text as NSString
        return true
    }
    
//    func serverDidReply(reply: JSON, statusCode: ServerReplyCode){
//        switch statusCode {
//        case .fetchSuccess:
//            (self.action)!()
//        default:
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
//                self.clearPIN()
//            })
//        }
//    }
    
//    @IBAction func resendBtn_tapped(_ sender: UIButton){
//        guard let del = delegate else { fatalError("Delegate for GBACodeVerification was not set.") }
//        del.ResendButton_tapped()
//    }
    
//    func clearPIN(){
//        self.pinCodeInput = ""
//        self.input_textField.text = ""
//        self.toggleViews.forEach{ $0.toggle = .off }
//    }
}

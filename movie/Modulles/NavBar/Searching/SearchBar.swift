//
//  SearchBar.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class SearchBar: UIView {
    static let nibName              = "SearchBar"
    static let commonRatio          = CGFloat(50/673)
    static let allowedChars         = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
    
    @IBOutlet var mainView          : UIView!
    @IBOutlet weak var vBackground  : UIView!
    @IBOutlet weak var imgSearch    : UIImageView!
    @IBOutlet weak var imgDelete    : UIImageView!
    @IBOutlet weak var tfContent    : UITextField!
    
    let rxTextDidChange             = BehaviorRelay<String>.init(value: "")
    let rxDisposeBag                = DisposeBag()
    var placeHolder                 = "Search Movie, TV Show, Actor"
    var performSearch               : ((String) -> Void)?
    
    // MARK: Setting UI View
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializedView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializedView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vBackground.frame                  = self.bounds
        self.vBackground.layer.cornerRadius     = self.vBackground.frame.height / 2
        self.vBackground.clipsToBounds          = true
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(SearchBar.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        /** `Background` */
        self.backgroundColor                = .clear
        
        /** `Icon` */
        self.imgDelete.image                = UIImage(named: BaseIcon.Search.cancel)
        self.imgSearch.image                = UIImage(named: BaseIcon.Search.search)
        self.imgDelete.tintColor            = Constant.Color.hex_7A7A7A
        self.imgSearch.tintColor            = Constant.Color.hex_7A7A7A
        
        /** `Text field` */
        self.tfContent.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.tfContent.borderStyle          = .none
        self.tfContent.font                 = UIFont.font(size: HelperUtils.isPad ? 20 : 18, weight: .medium)
        self.tfContent.backgroundColor      = .clear
        self.tfContent.textColor            = .white
        self.tfContent.tintColor            = Constant.Color.hex_7A7A7A
        self.tfContent.delegate             = self
        self.tfContent.returnKeyType        = .search
        self.tfContent.attributedPlaceholder = NSAttributedString(
            string: self.placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: Constant.Color.hex_7A7A7A,
                         .font: UIFont.font(size: HelperUtils.isPad ? 16 : 14, weight: .regular)]
        )
        
        self.tfContent.addTarget(self,
                                 action: #selector(self.textFieldDidChange(_:)),
                                 for: .editingChanged)
        
        self.rxTextDidChange
            .asDriver()
            .drive(onNext: { [weak self] (text) in
                guard let `self` = self else { return }
                self.imgDelete.isHidden = text.isEmpty
            })
            .disposed(by: self.rxDisposeBag)
        
        self.imgDelete
            .rx.tap()
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.tfContent.text         = ""
                self.imgDelete.isHidden     = true
            })
            .disposed(by: self.rxDisposeBag)
    }
}

extension SearchBar {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if var rawText = textField.text {
            /** `Xoá các dấu cách ở hai đầu` */
            rawText = rawText.trimmingCharacters(in: .whitespacesAndNewlines)
            /** `Xoá các ký tự đặc biệt` */
            rawText = rawText.trimmingCharacters(in: SearchBar.allowedChars.inverted)
            
            /** `Output` */
            self.rxTextDidChange.accept(rawText)
        }
    }
}

extension SearchBar : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tfContent.resignFirstResponder()
        let input = self.rxTextDidChange.value
        self.performSearch?(input)
        return true
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        let input = self.rxTextDidChange.value
        self.performSearch?(input)
    }
}

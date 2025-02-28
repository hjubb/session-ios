
final class RestoreVC : BaseVC {
    private var spacer1HeightConstraint: NSLayoutConstraint!
    private var spacer2HeightConstraint: NSLayoutConstraint!
    private var spacer3HeightConstraint: NSLayoutConstraint!
    private var restoreButtonBottomOffsetConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: Components
    private lazy var mnemonicTextView: TextView = {
        let result = TextView(placeholder: NSLocalizedString("vc_restore_seed_text_field_hint", comment: ""))
        result.layer.borderColor = Colors.text.cgColor
        result.accessibilityLabel = "Recovery phrase text view"
        return result
    }()
    
    private lazy var legalLabel: UILabel = {
        let result = UILabel()
        result.textColor = Colors.text
        result.font = .systemFont(ofSize: Values.verySmallFontSize)
        let text = "By using this service, you agree to our Terms of Service, End User License Agreement (EULA) and Privacy Policy"
        let attributedText = NSMutableAttributedString(string: text, attributes: [ .font : UIFont.systemFont(ofSize: Values.verySmallFontSize) ])
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: Values.verySmallFontSize), range: (text as NSString).range(of: "Terms of Service"))
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: Values.verySmallFontSize), range: (text as NSString).range(of: "End User License Agreement (EULA)"))
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: Values.verySmallFontSize), range: (text as NSString).range(of: "Privacy Policy"))
        result.attributedText = attributedText
        result.numberOfLines = 0
        result.textAlignment = .center
        result.lineBreakMode = .byWordWrapping
        return result
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradientBackground()
        setUpNavBarStyle()
        setUpNavBarSessionIcon()
        // Set up title label
        let titleLabel = UILabel()
        titleLabel.textColor = Colors.text
        titleLabel.font = .boldSystemFont(ofSize: isIPhone5OrSmaller ? Values.largeFontSize : Values.veryLargeFontSize)
        titleLabel.text = NSLocalizedString("vc_restore_title", comment: "")
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        // Set up explanation label
        let explanationLabel = UILabel()
        explanationLabel.textColor = Colors.text
        explanationLabel.font = .systemFont(ofSize: Values.smallFontSize)
        explanationLabel.text = NSLocalizedString("vc_restore_explanation", comment: "")
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        // Set up legal label
        legalLabel.isUserInteractionEnabled = true
        let legalLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLegalLabelTapped))
        legalLabel.addGestureRecognizer(legalLabelTapGestureRecognizer)
        // Set up spacers
        let topSpacer = UIView.vStretchingSpacer()
        let spacer1 = UIView()
        spacer1HeightConstraint = spacer1.set(.height, to: isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing)
        let spacer2 = UIView()
        spacer2HeightConstraint = spacer2.set(.height, to: isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing)
        let spacer3 = UIView()
        spacer3HeightConstraint = spacer3.set(.height, to: isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing)
        let bottomSpacer = UIView.vStretchingSpacer()
        let restoreButtonBottomOffsetSpacer = UIView()
        restoreButtonBottomOffsetConstraint = restoreButtonBottomOffsetSpacer.set(.height, to: Values.onboardingButtonBottomOffset)
        // Set up restore button
        let restoreButton = Button(style: .prominentFilled, size: .large)
        restoreButton.setTitle(NSLocalizedString("continue_2", comment: ""), for: UIControl.State.normal)
        restoreButton.titleLabel!.font = .boldSystemFont(ofSize: Values.mediumFontSize)
        restoreButton.addTarget(self, action: #selector(restore), for: UIControl.Event.touchUpInside)
        // Set up restore button container
        let restoreButtonContainer = UIView()
        restoreButtonContainer.addSubview(restoreButton)
        restoreButton.pin(.leading, to: .leading, of: restoreButtonContainer, withInset: Values.massiveSpacing)
        restoreButton.pin(.top, to: .top, of: restoreButtonContainer)
        restoreButtonContainer.pin(.trailing, to: .trailing, of: restoreButton, withInset: Values.massiveSpacing)
        restoreButtonContainer.pin(.bottom, to: .bottom, of: restoreButton)
        // Set up top stack view
        let topStackView = UIStackView(arrangedSubviews: [ titleLabel, spacer1, explanationLabel, spacer2, mnemonicTextView, spacer3, legalLabel ])
        topStackView.axis = .vertical
        topStackView.alignment = .fill
        // Set up top stack view container
        let topStackViewContainer = UIView()
        topStackViewContainer.addSubview(topStackView)
        topStackView.pin(.leading, to: .leading, of: topStackViewContainer, withInset: Values.veryLargeSpacing)
        topStackView.pin(.top, to: .top, of: topStackViewContainer)
        topStackViewContainer.pin(.trailing, to: .trailing, of: topStackView, withInset: Values.veryLargeSpacing)
        topStackViewContainer.pin(.bottom, to: .bottom, of: topStackView)
        // Set up main stack view
        let mainStackView = UIStackView(arrangedSubviews: [ topSpacer, topStackViewContainer, bottomSpacer, restoreButtonContainer, restoreButtonBottomOffsetSpacer ])
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        view.addSubview(mainStackView)
        mainStackView.pin(.leading, to: .leading, of: view)
        mainStackView.pin(.top, to: .top, of: view)
        mainStackView.pin(.trailing, to: .trailing, of: view)
        bottomConstraint = mainStackView.pin(.bottom, to: .bottom, of: view)
        topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor, multiplier: 1).isActive = true
        // Dismiss keyboard on tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        // Listen to keyboard notifications
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillChangeFrameNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // On small screens we hide the legal label when the keyboard is up, but it's important that the user sees it so
        // in those instances we don't make the keyboard come up automatically
        if !isIPhone5OrSmaller {
            mnemonicTextView.becomeFirstResponder()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: General
    @objc private func dismissKeyboard() {
        mnemonicTextView.resignFirstResponder()
    }
    
    // MARK: Updating
    @objc private func handleKeyboardWillChangeFrameNotification(_ notification: Notification) {
        guard let newHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else { return }
        bottomConstraint.constant = -newHeight // Negative due to how the constraint is set up
        restoreButtonBottomOffsetConstraint.constant = isIPhone6OrSmaller ? Values.smallSpacing : Values.largeSpacing
        spacer1HeightConstraint.constant = isIPhone6OrSmaller ? Values.smallSpacing : Values.mediumSpacing
        spacer2HeightConstraint.constant = isIPhone6OrSmaller ? Values.smallSpacing : Values.mediumSpacing
        spacer3HeightConstraint.constant = isIPhone6OrSmaller ? Values.smallSpacing : Values.mediumSpacing
        if isIPhone5OrSmaller { legalLabel.isUserInteractionEnabled = false }
        UIView.animate(withDuration: 0.25) {
            if isIPhone5OrSmaller { self.legalLabel.alpha = 0 }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        bottomConstraint.constant = 0
        restoreButtonBottomOffsetConstraint.constant = Values.onboardingButtonBottomOffset
        spacer1HeightConstraint.constant = isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing
        spacer2HeightConstraint.constant = isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing
        spacer3HeightConstraint.constant = isIPhone5OrSmaller ? Values.smallSpacing : Values.veryLargeSpacing
        if isIPhone5OrSmaller { legalLabel.isUserInteractionEnabled = true }
        UIView.animate(withDuration: 0.25) {
            if isIPhone5OrSmaller { self.legalLabel.alpha = 1 }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Interaction
    @objc private func restore() {
        func showError(title: String, message: String = "") {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("BUTTON_OK", comment: ""), style: .default, handler: nil))
            presentAlert(alert)
        }
        let mnemonic = mnemonicTextView.text!.lowercased()
        do {
            let hexEncodedSeed = try Mnemonic.decode(mnemonic: mnemonic)
            let seed = Data(hex: hexEncodedSeed)
            let (ed25519KeyPair, x25519KeyPair) = KeyPairUtilities.generate(from: seed)
            Onboarding.Flow.recover.preregister(with: seed, ed25519KeyPair: ed25519KeyPair, x25519KeyPair: x25519KeyPair)
            mnemonicTextView.resignFirstResponder()
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                let displayNameVC = DisplayNameVC()
                self.navigationController!.pushViewController(displayNameVC, animated: true)
            }
        } catch let error {
            let error = error as? Mnemonic.DecodingError ?? Mnemonic.DecodingError.generic
            showError(title: error.errorDescription!)
        }
    }
    
    @objc private func handleLegalLabelTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let urlAsString: String?
        let tosRange = (legalLabel.text! as NSString).range(of: "Terms of Service")
        let eulaRange = (legalLabel.text! as NSString).range(of: "End User License Agreement (EULA)")
        let ppRange = (legalLabel.text! as NSString).range(of: "Privacy Policy")
        let touchInLegalLabelCoordinates = tapGestureRecognizer.location(in: legalLabel)
        let characterIndex = legalLabel.characterIndex(for: touchInLegalLabelCoordinates)
        if tosRange.contains(characterIndex) {
            urlAsString = "https://getsession.org/terms-of-service/"
        } else if eulaRange.contains(characterIndex) {
            urlAsString = "https://getsession.org/terms-of-service/#eula"
        } else if ppRange.contains(characterIndex) {
            urlAsString = "https://getsession.org/privacy-policy/"
        } else {
            urlAsString = nil
        }
        if let urlAsString = urlAsString {
            let url = URL(string: urlAsString)!
            UIApplication.shared.open(url)
        }
    }
}

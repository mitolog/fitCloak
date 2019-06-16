import Foundation
import UIKit

class MyPageViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickyHeaderView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var editProfileLabel: UILabel!

    @IBOutlet weak var chargeView: UIView!
    @IBOutlet var chargePriceAndDateLabel: UILabel!
    @IBOutlet var chargePriceStackView: UIStackView!


    let items: [MyPageItem] = [
        MyPageItem(type: .info, itemName: "Info"),
        MyPageItem(type: .faq, itemName: "FAQ"),
        MyPageItem(type: .about, itemName: "About")
    ]
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
//        bindViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.updateLabels()

        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    // MARK: - custom instance methods
    func updateLabels() {
        self.editProfileLabel.text = "Edit"
    }

    func setupViews() {

//        self.chargeView.layer.borderColor = UIColor.black.cgColor
//        self.chargeView.layer.borderWidth = 0.5
//        self.chargeView.layer.cornerRadius = 8

        self.view.bringSubviewToFront(self.stickyHeaderView)

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self

        let edgeInsets = UIEdgeInsets(top: headerHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        tableView.contentInset = edgeInsets
        tableView.scrollIndicatorInsets = edgeInsets

//        self.chargePriceStackView.isHidden = false
//        editProfileLabel.addGestureRecognizer(UITapGestureRecognizer())
    }

//    func bindViews() {
//
//        viewModel.priceVariable.asObservable()
//            .bind(to: self.chargePriceAndDateLabel.rx.attributedText).disposed(by: disposeBag)
//
//        AppDelegate.shared.isOnService.asDriver()
//            .map{ !$0 }
//            .drive(self.doNotDisturbSwitch.rx.isOn).disposed(by: disposeBag)
//
//        // --------------- UILabel(name) UIImage(icon) ---------------
//        viewModel.userVariable
//            .asDriver()
//            .drive(onNext: { [unowned self] response in
//
//                var errorMessage:String?
//                var errorNote: String?
//
//                switch response {
//                case .got(let jellyUser):
//
//                    // Update profile name & icon
//                    self.userNameLabel.text = jellyUser.family + " " + jellyUser.first
//                    if let photoUrl = jellyUser.photoUrl, !photoUrl.isEmpty {
//
//                        self.iconView.clipsToBounds = true
//                        self.iconView.layer.cornerRadius = self.iconView.bounds.size.width*0.5
//                        self.iconView.sd_setImage(with: URL(string: photoUrl), completed: { (_, error, _, _) in
//                            Debug.print("sd_setImage on mypage profile icon: \(String(describing: error))")
//                        })
//                    }
//
//                    // update user name for chat support
//                    ZDCChat.updateVisitor { user in
//                        user?.name = jellyUser.family + jellyUser.first
//                    }
//                    SwiftMessages.hide(id: Consts.SwiftMessages.userDataBrokenId)
//
//                    // Update tableView content if needed
//                    self.viewModel.updateModels(with: self.currentAppMode, jellyUser: jellyUser)
//
//                    self.updateAlertBadge(with: jellyUser)
//
//                case .notExist:
//                    errorMessage = R.string.error.userDocNotExistMessage()
//                    errorNote = R.string.error.userDocNotExistMessage()
//                    self.viewModel.updateModels(with: self.currentAppMode)
//                case .couldnotFetch(let error):
//                    Alertift
//                        .alert(title: R.string.error.userDocCouldNotFetchTitle(),
//                               message: error.description)
//                        .action(.default(R.string.localizable.ok()))
//                        .show(on: self)
//                    self.viewModel.updateModels(with: self.currentAppMode)
//                case .couldnotParse:
//                    errorMessage = R.string.error.userDocCouldnotParseMessage()
//                    errorNote = R.string.error.userDocCouldnotParseMessage()
//                    self.viewModel.updateModels(with: self.currentAppMode)
//                case .empty:
//                    break
//                }
//
//                if let message = errorMessage {
//                    let messageView = MessageView.viewFromNib(layout: .messageView)
//                    messageView.configureContent(title: message, body: R.string.error.userDocErrorMessageAskText(), iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: R.string.error.userDocAskBtnTitle(), buttonTapHandler: { [unowned self] _ in
//                        SwiftMessages.hide()
//                        ZDCChat.updateVisitor { user in
//                            user?.name = ""
//                        }
//                        self.showChat(tags: ["critical"], note: errorNote)
//                    })
//                    messageView.configureTheme(backgroundColor: UIColor.jellyRed,
//                                               foregroundColor: UIColor.white,
//                                               iconImage: nil, iconText: nil)
//                    var config = SwiftMessages.defaultConfig
//                    config.presentationContext = .viewController(self)
//                    config.presentationStyle = .top
//                    config.duration = .forever
//                    config.shouldAutorotate = true
//                    messageView.id = Consts.SwiftMessages.userDataBrokenId
//                    SwiftMessages.hide(id: Consts.SwiftMessages.doNotDisturbId)
//                    SwiftMessages.show(config: config, view: messageView)
//                }
//            }).disposed(by: disposeBag)
//
//        // --------------- Tap gestures ---------------
//        if let tapGesture = editProfileLabel.gestureRecognizers?.first, tapGesture is UITapGestureRecognizer {
//            tapGesture.rx.event.bind { [unowned self] gesture in
//
//                guard case let .got(jellyUser) = self.viewModel.userVariable.value else {
//                    Debug.print("cannot go profile edit view")
//                    return
//                }
//
//                if let nextVc = R.storyboard.mypage.profileEditViewController() {
//                    // Pass current user info
//                    nextVc.setJellyUser(jellyUser)
//                    let navCon = UINavigationController(rootViewController: nextVc)
//                    self.navigationController?.present(navCon, animated: true, completion: nil)
//                }
//                }.disposed(by: disposeBag)
//        }
//
//        // --------------- UITableView ---------------
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        viewModel.bindTableView(self.tableView)
//
//        self.tableView.rx.modelSelected(MyPage.self).asDriver().drive(onNext: { [unowned self] myPageItem in
//
//            switch myPageItem.name {
//            case .about:
//                if let nextVc = R.storyboard.mypage.settingViewController() {
//                    self.navigationController?.pushViewController(nextVc, animated: true)
//                }
//            case .translator, .bankAccount:
//
//                guard
//                    let storyboardId = myPageItem.nextViewControllerId,
//                    let urlStr = myPageItem.contentUrl,
//                    let mail = Auth.auth().currentUser?.email,
//                    let escapedMail = mail.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)
//                    else {
//                        break
//                }
//
//                let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
//                if let vc = storyboard.instantiateInitialViewController() as? InAppWebViewController {
//                    vc.targetUrl = URL(string: urlStr + escapedMail)
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//
//            case .changeToUserMode, .changeToTranslatorMode:
//
//                if let tabCon = self.tabBarController as? MainTabBarController {
//                    tabCon.switchMode(with: self.currentAppMode)
//                }
//
//            case .info:
//                if let vc = R.storyboard.inAppWebView.inAppWebView(), let urlStr = myPageItem.contentUrl {
//                    vc.targetUrl = URL(string:urlStr)
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            case .faq:
//                print("faq")
//            case .chat:
//                self.showChat()
//            case .payment:
//                self.showPayment()
//                Analytics.logEvent(Consts.Analytics.paymentEventTap, parameters: nil)
//            }
//        }).disposed(by: disposeBag)
//    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.bind(data: self.items[indexPath.row])

//        switch pageItem.type {
//        case .about:
//
//            print("about")
//        case .info:
//            print("info")
//        case .faq:
//            print("faq")
//        }

        return cell
    }
}

// MARK: -
extension MyPageViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = headerHeightConstraint.constant
        if scrollView.contentOffset.y <= -height {
            headerTopLayoutConstraint.constant = 0
        } else {
            let max = -height
            headerTopLayoutConstraint.constant =
                (-scrollView.contentOffset.y - height <= max)
                ? max : -scrollView.contentOffset.y - height
        }
    }
}


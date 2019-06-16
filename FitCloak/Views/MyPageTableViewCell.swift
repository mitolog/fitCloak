import UIKit

class MyPageTableViewCell: BindableTableViewCell<MyPageItem> {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var subTitle: UILabel!
//    let localeLangs = NSLocale.preferredLanguages

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func bind(data: MyPageItem) {

        // pick first preffered language, if it's "ja" then shrink font
//        if let comps = localeLangs.first?.components(separatedBy: "-"),
//            let lang = comps.first, let locale = comps.last, (lang == "ja" || locale == "JP") {
//            self.nameLabel.font = UIFont.systemFont(ofSize: 18)
//        }

        self.nameLabel.text = data.itemName

//        if let sourceOrAlert = myPage.subTitle {
//            self.subTitle.attributedText = sourceOrAlert
//            self.subTitle.isHidden = false
//        } else {
//            self.subTitle.isHidden = true
//        }
    }

//    func setupForSetting(_ item: SettingData) {
//        self.nameLabel.text = item.title
//        self.subTitle.text = item.subTitle
//
//        switch item.name {
//        case .version, .logout:
//            self.accessoryType = .none
//            self.selectionStyle = .none
//        default:
//            self.accessoryType = .disclosureIndicator
//            self.selectionStyle = .default
//        }
//    }
}

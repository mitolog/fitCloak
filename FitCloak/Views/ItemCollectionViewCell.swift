import UIKit

class ItemCollectionViewCell: BindableCollectionViewCell<CloakItem> {

    @IBOutlet weak var itemImageView: UIImageView!

    // called when the view is instantiated via code, not interface builder.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // called via interface builder, but not initialize IBOutlets, IBActions
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // called after all the nib objects initialized
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // called after designable object is instantiated by Interface Builder.
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    override func bind(data: CloakItem) {
        guard
            let itemImageView = self.itemImageView,
            let image = UIImage(named: data.name) else { return }

        itemImageView.image = image
    }
}

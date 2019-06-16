import UIKit
import SwiftForms

class OrderViewController: FormViewController {

    var items: GymItems?

    struct Static {
        static let nameTag = "name"
        static let lastNameTag = "lastName"
        static let picker = "Gym"
        static let birthday = "Date&Time"
        static let categories = "categories"
        static let button = "button"
        static let textView = "textview"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        do {
            let data = try Util.getJSONData("GymItems")
            self.items = try GymItems(data: data!)
        } catch let e {
            print(e)
        }

        self.loadForm()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "closeBtn"), style: .plain, target: self, action: #selector(OrderViewController.close(_:)))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(OrderViewController.submit(_:)))
    }

    // MARK: Actions
    @objc func close(_: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func submit(_: UIBarButtonItem!) {

        let message = self.form.formValues().description

        let alertController = UIAlertController(title: "Is it OK?", message: message, preferredStyle: .alert)

        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }

        alertController.addAction(cancel)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: Private interface

    fileprivate func loadForm() {

        guard let gyms = self.items else { return }

        let form = FormDescriptor(title: "Example Form")

        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)

        var row = FormRowDescriptor(tag: Static.nameTag, type: .name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Miguel Ángel" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.value = "Jack" as AnyObject
        section1.rows.append(row)

        let gymIds: [String] = gyms.map { (item) -> String in
            return String(item.id)
        }
        row = FormRowDescriptor(tag: Static.picker, type: .picker, title: "Gym to Ship")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = gymIds as [AnyObject]
        row.configuration.cell.appearance = ["titleLabel.textColor": UIColor.black]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            let filtered = gyms.filter({ (item) -> Bool in
                return String(item.id) == option
            })

            if (filtered.count > 0 ){
                return filtered[0].name
            }
            return ""
        }

        row.value = "1" as AnyObject

        section1.rows.append(row)

        row = FormRowDescriptor(tag: Static.birthday, type: .dateAndTime, title: "Date & Time")
        row.configuration.cell.showsInputToolbar = true
        section1.rows.append(row)

        row = FormRowDescriptor(tag: Static.categories, type: .multipleSelector, title: "Categories")
        row.configuration.selection.options = ([0, 1, 2, 3, 4] as [Int]) as [AnyObject]
        row.configuration.selection.allowsMultipleSelection = true
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "Restaurant"
            case 1:
                return "Pub"
            case 2:
                return "Shop"
            case 3:
                return "Hotel"
            case 4:
                return "Camping"
            default:
                return ""
            }
        }

//        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
//
//        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Dismiss")
//        row.configuration.button.didSelectClosure = { _ in
//            self.view.endEditing(true)
//        }
//        section2.rows.append(row)

        form.sections = [section1]

        self.form = form
    }
}

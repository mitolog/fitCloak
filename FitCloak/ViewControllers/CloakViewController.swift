//
//  CloakViewController.swift
//  FitCloak
//
//  Created by Yuhei Miyazato on 2019/06/15.
//

import UIKit

class CloakViewController: UIViewController {

    @IBOutlet weak var deliverBtn: UIButton!
    @IBOutlet weak var pickupBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var items: CloakItems?

    override func viewDidLoad() {
        super.viewDidLoad()

        let data = try! Util.getJSONData("CloakItems")
        self.items = try! CloakItems(data: data!)

        self.setupView()

        // Do any additional setup after loading the view.
    }

    private func setupView() {

        // collectionview cell settings
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8

//        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
//            let cellWidth = floor(collectionView.bounds.width / 2)  // *2列*
//
//            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
//            // ここからはオプション マージンとかをなくしている
////            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////            layout.minimumInteritemSpacing = 0 // アイテム間?
////            layout.minimumLineSpacing = 0 // 行間
//
//        }

        // buttons
        self.deliverBtn.layer.cornerRadius = 3
        self.pickupBtn.layer.cornerRadius = 3
        self.pickupBtn.layer.borderColor = UIColor.primaryButton.cgColor
        self.pickupBtn.layer.borderWidth = 1
    }

    override func viewWillLayoutSubviews() {
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CloakViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = self.items else { return 0 }
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        guard let items = self.items else { return cell }

        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath)
        (cell as! ItemCollectionViewCell).bind(data: items[indexPath.row])
        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellSize:CGFloat = self.view.bounds.width*0.5 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
}

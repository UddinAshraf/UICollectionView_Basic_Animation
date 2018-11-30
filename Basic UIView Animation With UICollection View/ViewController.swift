//
//  ViewController.swift
//  Basic UIView Animation With UICollection View
//
//  Created by BS126 on 11/29/18.
//  Copyright © 2018 BS23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var domainCollecetionView: UICollectionView!
    @IBOutlet weak var domainCollecetionViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var domainCollecetionViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var optionCollectionView: UICollectionView!
    @IBOutlet weak var optionCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionCollectionViewBottomConstraint: NSLayoutConstraint!
    
    var domainList:[Domain] = [Domain(domainTilte: "Gmail", domainBackgroundColor: "EF03FF"),
                               Domain(domainTilte: "Dribble", domainBackgroundColor: "66EAE4"),
                               Domain(domainTilte: "Bank Chase", domainBackgroundColor: "5848FF"),
                               Domain(domainTilte: "Facebook", domainBackgroundColor: "A7FBD0")
                               ]
    var optionList: [Option] = [Option(optiontitle: "Password",optionIcon: "Password",optionIconBackgroundColor: "455DFF"),
                               Option(optiontitle: "Image",optionIcon: "Camera",optionIconBackgroundColor: "A3ABDD"),
                               Option(optiontitle: "Video",optionIcon: "Video",optionIconBackgroundColor: "66EAE4"),
                               Option(optiontitle: "Chat",optionIcon: "Chat",optionIconBackgroundColor: "FF7D49")
                               ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //animateOptinCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.domainCollecetionViewLeadingConstraint.constant += domainCollecetionView.bounds.width + 15
        self.domainCollecetionViewTrailingConstraint.constant -= domainCollecetionView.bounds.width + 15
        
        self.optionCollectionViewTopConstraint.constant += optionCollectionView.bounds.height + 20
        self.optionCollectionViewBottomConstraint.constant -= optionCollectionView.bounds.height + 20
      
        self.view.layoutIfNeeded()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.domainCollecetionViewLeadingConstraint.constant = 15//self.domainCollecetionView.bounds.width + 20
            self.domainCollecetionViewTrailingConstraint.constant = 15//self.domainCollecetionView.bounds.width + 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseOut, animations: {
            self.optionCollectionViewTopConstraint.constant = 20//self.optionCollectionView.bounds.height + 20
            self.optionCollectionViewBottomConstraint.constant = 0//self.optionCollectionView.bounds.height + 20
            self.view.layoutIfNeeded()
        }, completion: nil)
          animateOptinCollectionView()
    }
}

//MARK: UICollectionView Datasource and Delegate methods
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == optionCollectionView ? optionList.count : domainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == domainCollecetionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DomainCell", for: indexPath) as! DomainCollectionViewCell
            let item = domainList[indexPath.item]
            cell.domainCellBackgroundView.backgroundColor = UIColor.hexStringToUIColor(hex: item.domainBackgroundColor)
            cell.domainTitleLabel.text = item.domainTilte
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath) as! OptionCollectionViewCell
            let item = optionList[indexPath.item]
            cell.optionTitleLabel.text = item.optiontitle
            cell.optionIconBackgroundView.backgroundColor = UIColor.hexStringToUIColor(hex: item.optionIconBackgroundColor)
            cell.optionIconImageView.image = UIImage(named: item.optionIcon)
            return cell
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = domainCollecetionView.bounds.width - 20
        let availableHeight = domainCollecetionView.bounds.height - 20
        if collectionView == optionCollectionView {
            return CGSize(width: availableWidth / 2, height: 170
            )
        }
        return CGSize(width: availableWidth / 2, height: availableHeight / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: Custom Methods
extension ViewController {
    func animateOptinCollectionView() {
        optionCollectionView.reloadData()
        self.optionCollectionView.layoutIfNeeded()
        let cells = optionCollectionView.visibleCells
        let collectionViewHeight: CGFloat = optionCollectionView.bounds.height
        
        for c in cells {
            let cell: UICollectionViewCell = c as UICollectionViewCell
            cell.transform = CGAffineTransform(translationX: 0 , y: collectionViewHeight)
        }
        var index = 0
        for item in cells {
            let cell: UICollectionViewCell = item as UICollectionViewCell
            UIView.animate(withDuration: 1.5, delay: 0.2 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0 , y: 0)
            }, completion: nil)
            index = index + 1
        }
    }
}

//
//  CategoryViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    let model = CoreModel.coreModel
    let icons: [String] = ["💵","🍞","🍇","🛍","🍟","🍛","🍧","🍺","☕️","🍷","🍽","🎉","🏸","🎪","🎬","🎼","🎲","🚗","🚃","✈️","🛳","🏦","🏥","🏠","🏢","📱","💻","💊"]
    var currentCategory: CategoryModel?
    //private let category = CategoryModel()
    
    @IBOutlet weak var nameCategory: UITextField!
    @IBOutlet weak var iconCollection: UICollectionView!
    @IBOutlet weak var descriptionCategory: UITextField!
    @IBOutlet weak var typeCategory: UISegmentedControl!
    
    @IBOutlet weak var iconCategory: UILabel!
    @IBAction func saveCategory(_ sender: UIBarButtonItem) {
        let nameCategoryText = nameCategory.text ?? "NoName"
        let trimmedCategoryName = nameCategoryText.trimmingCharacters(in: .whitespacesAndNewlines)
        let descr = descriptionCategory.text ?? "No Description"
        let type: CategoryType = typeCategory.selectedSegmentIndex == 0 ? CategoryType.pay : CategoryType.income
        let icon = iconCategory.text
        if trimmedCategoryName.characters.count < 2 {
            showWarningMsg("Incorrect name!")
            return
        }
        if icon == ""{
            showWarningMsg("Select picture for category!")
            return
        }
        if currentCategory == nil {
            if  model.checkCategoryExists(name: trimmedCategoryName) {
                showWarningMsg("Category name exists!")
                return
            } else {
                model.addCategory(name: trimmedCategoryName, descrip: descr, type: type, icon: icon)
            }
        } else {
            model.modifyCategory(byId: currentCategory!.id, name: trimmedCategoryName, descriptionText: descr, type: type, icon: icon)
        }
        model.saveCategories()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showWarningMsg(_ textMsg: String) {
        let alert = UIAlertController(title: "Warning!", message: textMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if currentCategory != nil {
            nameCategory.text = currentCategory?.name
            descriptionCategory.text = currentCategory?.descriptionContext
            typeCategory.selectedSegmentIndex =  currentCategory?.type == .income ? 1 : 0
            iconCategory.text = currentCategory?.icon
        } else {
            iconCategory.text = ""
        }
        nameCategory.delegate = self
        descriptionCategory.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCollectionViewCell
        cell.icon.text = icons[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.iconCollection.alpha = 1
        UIView.animate(withDuration: 1, animations: {
            self.iconCollection.alpha = 0
        })
        iconCategory.text = icons[indexPath.row]
        self.iconCategory.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.iconCategory.alpha = 1
        })

    }
    //To hide keyboard outside of text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameCategory.resignFirstResponder()
        descriptionCategory.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

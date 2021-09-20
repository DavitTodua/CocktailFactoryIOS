//
//  IngredientDetailVC.swift
//  CocktailFactory
//
//  Created by David Todua on 16.09.21.
//

import UIKit
import Alamofire
class IngredientDetailVC: UIViewController {


    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var cocktailsTableView: UITableView!
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    var ingredient: Ingredient?
    private var dependentCocktails:[Cocktail] = []
    
 
    @IBOutlet weak var dependentCocktailsTableView: UITableView!
    
    override func viewDidLoad() {
        dependentCocktailsTableView.delegate = self
        dependentCocktailsTableView.dataSource = self
        dependentCocktailsTableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        setup()
        prepareString(starter: (ingredient?.strIngredient)!)
    }
    
    private func setup() {
        if ingredient != nil {
            descriptionTextLabel.text = ingredient?.strDescription
            ingredientNameLabel.text = ingredient?.strIngredient
            if ingredient?.strDescription == nil {
                descriptionTextLabel.text = "Sorry There Is No Much Story About This " + (ingredient?.strIngredient)!
                descriptionTextLabel.sizeToFit()
            }
            descriptionTextLabel.layer.cornerRadius = 12
            descriptionTextLabel.layer.masksToBounds = true
            self.title = "Ingredient"
        }
        setupDependentCocktails()
    }
    
    private func setupDependentCocktails() {
        let ingredientName = prepareString(starter: ingredient!.strIngredient)
        CocktailServices.init().getCocktailsByIngredient(ingredientName: ingredientName) { (bool,object) in
            let currCocktails = (object as! Cocktails).drinks
            self.dependentCocktails.append(contentsOf: currCocktails)
            self.dependentCocktailsTableView.reloadData()
        }
    }
    private func prepareString(starter:String)->String {
        var result:String = ""
        for char in starter {
            if char == " " {
                result.append("%20")
            } else {
                result.append(char)
            }
        }
        return result
    }
}

extension IngredientDetailVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dependentCocktails.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell") as! CocktailTableViewCell
        
        let currCocktail = dependentCocktails[indexPath.row]
        cell.alcoholicLabel.text = currCocktail.strAlcoholic ?? ""
        cell.cocktailNameLabel.text = currCocktail.strDrink
        cell.categoryLabel.text = currCocktail.strCategory ?? ""

        let url = currCocktail.strDrinkThumb as! URLConvertible
        AF.request(url).response { response in
            if response.data != nil {
                let image = UIImage(data: response.data!)
                cell.avatarImage.image = image
                self.dependentCocktails[indexPath.row].image = image
                
            }
        }
            
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(identifier: "CocktailDetailVC") as! CocktailDetailVC
        let id = dependentCocktails[indexPath.row].idDrink ?? "0"
        
        CocktailServices.init().fetchCocktailById(id: id) { (bool,object) in
            if bool {
                var currCocktail = (object as! Cocktails).drinks[0]
                
                if let image = self.dependentCocktails[indexPath.row].image {
                    VC.avatarImageView?.image = image
                    VC.cocktail = currCocktail
                    currCocktail.image = image
                }
                VC.cocktail = currCocktail
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        dependentCocktailsTableView.deselectRow(at: indexPath, animated: true)
    }
}

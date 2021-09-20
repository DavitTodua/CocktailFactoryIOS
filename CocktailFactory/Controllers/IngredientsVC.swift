//
//  IngredientsVC.swift
//  CocktailFactory
//
//  Created by David Todua on 06.09.21.
//

import UIKit

class IngredientsVC: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients:[Ingredient] = []
    var ingredientsReserve:[Ingredient] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        tableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
        searchBar.delegate = self
        fetchRandomIngredients()
//        CocktailServices.init().getIngredientsByName(ingredientName: "whiskey") { (bool,object) in
//            print(object)
//            print("zd")
//        }
//        CocktailServices.init().getIngredientsById(ingredientId: "2") { (bool,object) in
//            print("ingredienti id")
//            print(object)
//        }
        // Do any additional setup after loading the view.
    }
    
   private func fetchRandomIngredients() {
        for x in 0...15 {
            let range = Range.init(uncheckedBounds: (lower: 1, upper: 615))
            let random = String(Int.random(in: range))            
            CocktailServices.init().getIngredientsById(ingredientId: random) { (bool,object) in
                let ing = (object as! Ingredients).ingredients[0]
                self.ingredients.append(ing)
                self.tableView.reloadData()
            }
        }
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell") as! IngredientTableViewCell
        
//        cell.cocktailNameLabel.text = ingredients[indexPath.row].strIngredient
//        cell.alcoholicLabel.text = ingredients[indexPath.row].strAlcohol
        cell.nameLabel.text = ingredients[indexPath.row].strIngredient
        if let alcohol = ingredients[indexPath.row].strAlcohol {
            if alcohol != "No" {
                cell.alcoholLabel.text = "Alcohol : " + alcohol
                cell.alcoholLabel.textColor = UIColor(named: "Fourth")
            }
        }
        return cell
    }

}

extension IngredientsVC:UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(identifier: "IngredientDetailVC") as! IngredientDetailVC
        VC.ingredient = ingredients[indexPath.row]
        navigationController?.pushViewController(VC, animated: true)
    }
}

extension IngredientsVC:UISearchBarDelegate {
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            return
        }
        let searchIngredientName = prepareString(starter: searchBar.text!)
        let IngredientName2 = searchBar.text
        CocktailServices.init().getIngredientsByName(ingredientName: searchIngredientName) { (bool,object) in
            self.ingredientsReserve = self.ingredients
            let result = (object as! Ingredients).ingredients
            self.ingredients = result
            self.tableView.reloadData()
        }
    }
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ingredients = ingredientsReserve
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            ingredients = ingredientsReserve
            tableView.reloadData()
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

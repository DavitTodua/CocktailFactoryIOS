//
//  MyCocktailsVC.swift
//  CocktailFactory
//
//  Created by David Todua on 06.09.21.
//

import UIKit
import CoreData

class MyCocktailsVC: UIViewController, UITableViewDataSource {
  
 

    @IBOutlet weak var tableView: UITableView!
    var favourites:[CocktailEntity] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        
        LoadContext()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        LoadContext()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell") as! CocktailTableViewCell

        let currCocktail = favourites[indexPath.row]
        cell.alcoholicLabel.text = currCocktail.strAlcoholic ?? ""
        cell.categoryLabel.text = currCocktail.strCategory ?? ""
        cell.cocktailNameLabel.text = currCocktail.strDrink ?? ""
        cell.alcoholicLabel.text = currCocktail.strAlcoholic ?? ""
        
        if let cocktailImage = currCocktail.dataImage {
            cell.avatarImage.image = UIImage(data: cocktailImage)
        }
//        //cell.backgroundColor = .cyan
//        cell.layer.cornerRadius = 15
//        cell.layer.masksToBounds = true
        return cell
    }
    
    
    func ConvertToCocktail(cocktailEntity:CocktailEntity)->Cocktail {
        var cocktail = Cocktail(idDrink: cocktailEntity.idDrink, strDrink: cocktailEntity.strDrink, strCategory: cocktailEntity.strCategory, strIBA: cocktailEntity.strIBA, strAlcoholic: cocktailEntity.strAlcoholic, strGlass: cocktailEntity.strGlass, strInstructions: cocktailEntity.strInstructions, strDrinkThumb: cocktailEntity.strDrinkThumb, strIngredient1: cocktailEntity.strIngredient1, strIngredient2: cocktailEntity.strIngredient2, strIngredient3: cocktailEntity.strIngredient3, strIngredient4: cocktailEntity.strIngredient4, strIngredient5: cocktailEntity.strIngredient5, strIngredient6: cocktailEntity.strIngredient6, strIngredient7: cocktailEntity.strIngredient7, strIngredient8: cocktailEntity.strIngredient8, strIngredient9: cocktailEntity.strIngredient9, strIngredient10: cocktailEntity.strIngredient10, strMeasure1: cocktailEntity.strMeasure1, strMeasure2: cocktailEntity.strMeasure2, strMeasure3: cocktailEntity.strMeasure3, strMeasure4: cocktailEntity.strMeasure4, strMeasure5: cocktailEntity.strMeasure5, strMeasure6: cocktailEntity.strMeasure6, strMeasure7: cocktailEntity.strMeasure7, strMeasure8: cocktailEntity.strMeasure8, strMeasure9: cocktailEntity.strMeasure9, strMeasure10: cocktailEntity.strMeasure10)
        
        if let imageData = cocktailEntity.dataImage {
            let img = UIImage(data: imageData)
            cocktail.image = img
        }
        
        return cocktail
    }
    
    

}

extension MyCocktailsVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let deleting = favourites.remove(at: indexPath.row)
        context.delete(deleting)
        tableView.reloadData()
        SaveContext()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(identifier: "CocktailDetailVC") as! CocktailDetailVC
        
        VC.cocktail = ConvertToCocktail(cocktailEntity: favourites[indexPath.row])
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
}


// MARK: - Working With Context
extension MyCocktailsVC {
    
    func SaveContext() {
        do {
            try context.save()
        } catch {
            print("Couldn't Save Context")
        }
    }
    
    func LoadContext() {
        let request: NSFetchRequest<CocktailEntity> = CocktailEntity.fetchRequest()
        do {
            favourites = try context.fetch(request)
        } catch {
            print("couldn't fetch request")
        }
        tableView.reloadData()
    }
    
    static func addToFavourites(cocktail: Cocktail) {
        
        let tempoContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let cocktailEntity = CocktailEntity(context:tempoContext)
        
        cocktailEntity.idDrink = cocktail.idDrink ?? "0"
        cocktailEntity.dataImage = cocktail.image?.pngData()
        cocktailEntity.strDrink = cocktail.strDrink
        cocktailEntity.strCategory = cocktail.strCategory
        cocktailEntity.strAlcoholic = cocktail.strAlcoholic
        cocktailEntity.strGlass = cocktail.strGlass
        cocktailEntity.strDrinkThumb = cocktail.strDrinkThumb
        cocktailEntity.strIBA = cocktail.strIBA
        cocktailEntity.strInstructions = cocktail.strInstructions
        
        cocktailEntity.strIngredient1 = cocktail.strIngredient1
        cocktailEntity.strIngredient2 = cocktail.strIngredient2
        cocktailEntity.strIngredient3 = cocktail.strIngredient3
        cocktailEntity.strIngredient4 = cocktail.strIngredient4
        cocktailEntity.strIngredient5 = cocktail.strIngredient5
        cocktailEntity.strIngredient6 = cocktail.strIngredient6
        cocktailEntity.strIngredient7 = cocktail.strIngredient7
        cocktailEntity.strIngredient8 = cocktail.strIngredient8
        cocktailEntity.strIngredient9 = cocktail.strIngredient9
        cocktailEntity.strIngredient10 = cocktail.strIngredient10
        
        cocktailEntity.strMeasure1 = cocktail.strMeasure1
        cocktailEntity.strMeasure2 = cocktail.strMeasure2
        cocktailEntity.strMeasure3 = cocktail.strMeasure3
        cocktailEntity.strMeasure4 = cocktail.strMeasure4
        cocktailEntity.strMeasure5 = cocktail.strMeasure5
        cocktailEntity.strMeasure6 = cocktail.strMeasure6
        cocktailEntity.strMeasure7 = cocktail.strMeasure7
        cocktailEntity.strMeasure8 = cocktail.strMeasure8
        cocktailEntity.strMeasure9 = cocktail.strMeasure9
        cocktailEntity.strMeasure10 = cocktail.strMeasure10

        do {
            try tempoContext.save()
        } catch {
            print("Couldn't Save Context")
        }
    }
}

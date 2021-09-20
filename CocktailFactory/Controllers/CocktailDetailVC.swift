//
//  CocktailDetailVC.swift
//  CocktailFactory
//
//  Created by David Todua on 09.09.21.
//

import UIKit
import Alamofire

class CocktailDetailVC: UIViewController {
    @IBOutlet weak var FavouritesButton: UIBarButtonItem!
    private var isFavourite:Bool = false
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    
  
    
    @IBOutlet weak var ingredient1Label: UILabel!
    
    @IBOutlet weak var ingredient2Label: UILabel!
    
    @IBOutlet weak var ingredient3Label: UILabel!
    
    @IBOutlet weak var ingredient4Label: UILabel!
    
    @IBOutlet weak var ingredient5Label: UILabel!
    
    @IBOutlet weak var ingredient6Label: UILabel!
    
    @IBOutlet weak var ingredient7Label: UILabel!
    
    @IBOutlet weak var ingredient8Label: UILabel!
    
    @IBOutlet weak var ingredient9Label: UILabel!
    
    
    
    @IBOutlet weak var measureTextLabel: UILabel!
    
    @IBOutlet weak var prepareTextLabel: UILabel!
    
    var cocktail:Cocktail?
    
    override func viewDidLoad() {
        setup()
    }
    
  
    private func setup() {
        if cocktail != nil {
            avatarImageView.image = cocktail?.image
            nameLabel.text = cocktail?.strDrink
            categoryLabel.text = cocktail?.strCategory
            alcoholLabel.text = cocktail?.strAlcoholic
            
            setupIngredients()
            prepareTextLabel.text = cocktail?.strInstructions
            prepareTextLabel.sizeToFit()
            addFormToLabel(label: ingredient1Label)
            setImage()
        }
        
        
        
    }
    private func setImage() {
        let imageUrl = cocktail?.strDrinkThumb!
        AF.request(imageUrl!).response { (response) in
            let image = UIImage(data: response.data!)
            self.avatarImageView.image = image
        }
    }
    private func setupIngredients() {
        
        if cocktail?.strIngredient1 != nil {
            ingredient1Label.text = cocktail?.strIngredient1
            
            let addMeasureText = (cocktail?.strIngredient1 ?? "") + " " + (cocktail?.strMeasure1 ?? "")
            measureTextLabel.text = addMeasureText
            addFormToLabel(label: ingredient1Label)
        } else {
            measureTextLabel.text = ""
        }
        
        if cocktail?.strIngredient2 != nil {
            ingredient2Label.text = cocktail?.strIngredient2
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient2 ?? "") + " " + (cocktail?.strMeasure2 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient2Label)
        } else {
            ingredient2Label.text = ""
        }
        
        if cocktail?.strIngredient3 != nil {
            ingredient3Label.text = cocktail?.strIngredient3
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient3 ?? "") + " " + (cocktail?.strMeasure3 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText + " kkk"
            addFormToLabel(label: ingredient3Label)
            
        } else {
            ingredient3Label.text = ""
        }
        
        if cocktail?.strIngredient4 != nil {
            ingredient4Label.text = cocktail?.strIngredient4
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient4 ?? "") + " " + (cocktail?.strMeasure4 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient4Label)
        } else {
            ingredient4Label.text = ""
        }
        
        if cocktail?.strIngredient5 != nil {
            ingredient5Label.text = cocktail?.strIngredient5
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient5 ?? "") + " " + (cocktail?.strMeasure5 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient5Label)
        } else {
            ingredient5Label.text = ""
        }
        if cocktail?.strIngredient6 != nil {
            ingredient6Label.text = cocktail?.strIngredient6
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient6 ?? "") + " " + (cocktail?.strMeasure6 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient6Label)
        } else {
            ingredient6Label.text = ""
        }
        
        if cocktail?.strIngredient7 != nil {
            ingredient7Label.text = cocktail?.strIngredient7
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient7 ?? "") + " " + (cocktail?.strMeasure7 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient7Label)
        } else {
            ingredient7Label.text = ""
        }
        
        if cocktail?.strIngredient8 != nil {
            ingredient8Label.text = cocktail?.strIngredient8
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient8 ?? "") + " " + (cocktail?.strMeasure8 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient8Label)
        } else {
            ingredient8Label.text = ""
        }
        
        if cocktail?.strIngredient9 != nil {
            ingredient9Label.text = cocktail?.strIngredient9
            
            let currText = (measureTextLabel.text ?? "")
            let addMeasureText = (cocktail?.strIngredient9 ?? "") + " " + (cocktail?.strMeasure9 ?? "")
            measureTextLabel.text = currText + "\n" + addMeasureText
            addFormToLabel(label: ingredient9Label)
        } else {
            ingredient9Label.text = ""
        }
    }
    
    private func addFormToLabel(label:UILabel) {
        label.backgroundColor = UIColor(named: "Fifth")
        label.text = " " + (label.text ?? "")
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
    }
}


// MARK: - Adding To Favourites
extension CocktailDetailVC {
   
    
    @IBAction func FavouritesButtonPressed(_ sender: UIBarButtonItem) {
        isFavourite = true
        
        if !isFavourite {
            return
        }
        
       
        var alertController = UIAlertController(title: "Add To Favourites?", message: "", preferredStyle: .alert)
        
        let doneAction =  UIAlertAction(title: "Done", style: .default) { (alertAction) in
            
            
            self.cocktail?.image = self.avatarImageView.image
            MyCocktailsVC.addToFavourites(cocktail: self.cocktail!)
            self.setFavouritesImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setFavouritesImage() {
        var imageName = "star"
        if isFavourite {
            imageName = "star.fill"
        }
        
        FavouritesButton.image = UIImage(systemName: imageName)
        }

}

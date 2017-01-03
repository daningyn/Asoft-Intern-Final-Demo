//
//  AppResourceIdentifiers.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/26/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import Foundation

class AppResourceIdentifiers {
    
    //#MARK: - Combine View
    static let kCombineImageCellArray = ["combine-food-image1", "combine-food-image2", "combine-food-image3"]
    static let kCombineNumberRowInSection = [6, 27, 10]
    static let kCombineHeaderInSection = ["Meat", "Fish", "Ride"]
    
    static let kCombineTitlteNamesCellArray = ["Beef", "Pork", "Chicken"]
    static let kCombineDetailNamesCellArray = ["is an excellent source of complete protein and minerals such as zinc, selenium, phosphorus and iron, and B vitamins.", "is known to carry some diseases such as pork tapeworm and trichinosis, although raw pork is commonly eaten in parts of Europe.", "contains a significant amount of phosphorus, potassium, vitamin B12, niacin and monounsaturated fatty acids."]
    
    
    //#MARK: - ChefVideoViewController
    static let kChefVideoChefArray = ["Gordon James Ramsay", "Marco Pierre White", "Wolfgang Puck"]
    static let kChefVideoImageChefArray = ["chef1", "chef2", "chef3"]
    
    
    //#MARK: - ChefQuoteCollectionViewCell
    static let kChefQuoteDetailTextArray = ["I don't like looking back. I'm always constantly looking forward. I'm not the one to sort of sit and cry over spilt milk. I'm too busy looking for the next cow.", "Cooking is about passion, so it may look slightly temperamental in a way that it's too assertive to the naked eye.", "I cook, I create, I'm incredibly excited by what I do, I've still got a lot to achieve.", "There's a bond among a kitchen staff, I think. You spend more time with your chef in the kitchen than you do with your own family.", "Cooking is about passion, so it may look slightly temperamental in a way that it's too assertive to the naked eye.", "There's a bond among a kitchen staff, I think. You spend more time with your chef in the kitchen than you do with your own family.", "I don't like looking back. I'm always constantly looking forward. I'm not the one to sort of sit and cry over spilt milk. I'm too busy looking for the next cow."]
    static let kChefQuoteAddressArray = ["Next, Forward, Busy", "Passion, Eye, Cooking", "Achieve, Create, Excited", "Family, Time, Chef", "Passion, Eye, Cooking", "Achieve, Create, Excited", "Next, Forward, Busy"]
    static let kChefQuoteNumberHeart = [63, 91, 213, 26, 99, 111, 151]
    
    
    //#MARK: - SettingViewController
    static let kSettingOptionArray = ["Notifications", "Block Invites", "General", "Account", "Payments", "Sounds", "Privacy"]
    
    //#MARK: - ChallengeViewController
    static let kDetailPlanningRecipes = ["Mix together all the spices in a bowl.", "Liberally rub the entire brisket with the spices.", "Wrap tightly in plastic wrap and refrigerate for at least 4 hours and up to 24 hours."]
    
    //#MARK: - Search ViewController
    static let kIdentifierSearchImageArray = ["search-1", "search-2", "pizza-1", "pizza-2", "pizza-3"]
    static let kIdentifierSearchNameArray = ["Steak with Cranberry Sauce", "Steak with Cranberry Sauce", "Suprim", "Marinara", "Margaritta"]
    static let kSearchTimeArray = ["15 min", "20 min", "25 min", "10 min", "30 min"]
    static let kIdentifierDidSearchImageArray = ["pizza-1", "pizza-2", "pizza-3"]
    static let kIdentifierDidSearchNameArray = ["Suprim", "Marinara", "Margaritta"]
    static let kDidSearchTimeArray = ["25 min", "10 min", "30 min"]
    static var kResult = 0
    static var kResultString: String {
        get {
            return "\(AppResourceIdentifiers.kResult) recipes found"
        }
    }
    
    //#MARK: - Category ViewController
    static let kCategoryMenuArray = ["GRILL", "FRY", "BOIL", "BAKE"]
    static let kCategoryImageArray = ["category-food-1", "category-food-2", "category-food-3"]
    static let kCategoryNameArray = ["Grilled Spicy Brisket", "Steak with Cranberry Sauce", "Grilled Pork & Potatos"]
    static let kCategoryTimeArray = ["25 min", "10 min", "30 min"]
    static let kCategoryFilterArray = ["", "Pork", "Beef", "Veal", "Chiken", "", "Gluten free", "Sugar free", "Salt Free", "Healthy", "Diet"]
    
    
    //#MARK: - Assets
    static let kIdentifierIconNext = "icon_next"
    static let kIdentifierIconBack = "icon_back"
    static let kIdentifierRectangleNavigationBar = "rectangle-navigationbar"
    static let kIdentifierIconThumb = "icon_thumb"
    static let kIdentifierIconPause = "icon_pause"
    static let kIdentifierIconPlay = "icon_play"
    static let kIdentifierIconFilter = "icon_filter"
    static let kIdentifierIconCheck = "icon_check"
    static let kIdentifierIconNotCheck = "icon_notcheck"
    
}

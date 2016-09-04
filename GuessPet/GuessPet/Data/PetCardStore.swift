//
//  File.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/3.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

struct PetCardStore {
    static func defaultPets() -> [PetCard] {
        return parsePets()
    }
    
    private static func parsePets() -> [PetCard] {
        let filePath = NSBundle.mainBundle().pathForResource("Pets", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: filePath)!
        let petData = dictionary["Pets"] as! [[String : String]]
        
        let pets = petData.map() {
            dict -> PetCard in
            return PetCard(name: dict["name"]!, description: dict["description"]!, image: UIImage(named: dict["image"]!)!)
        }
        
        return pets
    }
}

//
//  DirectionPreference.swift
//  Crystal Gardens
//
//  Created by David Mackenzie on 12/21/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import Foundation

enum DirectionPreference: UInt32 {
    case nbe, nebn, nebe, ebn, ebs, sebe, sebs, sbe, sbw, swbs, swbw, wbs, wbn, nwbw, nwbn, nbw
    static func randomDirectionPreference() -> DirectionPreference {
        // pick and return a new value
        let rand = arc4random_uniform(16)
        return DirectionPreference(rawValue: rand)!
    }
    func directionOrder() -> [[Int]] {
        switch self {
        case .nbe:
            return [[0,1], [1,1], [-1,1], [1,0], [-1,0], [1,-1], [-1,-1], [0,-1]]
        case .nebn:
            return [[1,1], [0,1], [1,0], [-1,1], [1,-1], [-1,0], [0,-1], [-1,-1]]
        case .nebe:
            return [[1,1], [1,0], [0,1], [1,-1], [-1,1], [0,-1], [-1,0], [-1,-1]]
        case .ebn:
            return [[1,0], [1,1], [1,-1], [0,1], [0,-1], [-1,1], [-1,-1], [-1,0]]
        case .ebs:
            return [[1,0], [1,-1], [1,1], [0,-1], [0,1], [-1,-1], [-1,1], [-1,0]]
        case .sebe:
            return [[1,-1], [1,0], [0,-1], [1,1], [-1,-1], [0,1], [-1,0], [-1,1]]
        case .sebs:
            return [[1,-1], [0,-1], [1,0], [-1,-1], [1,1], [-1,0], [0,1], [-1,1]]
        case .sbe:
            return [[0,-1], [1,-1], [-1,-1], [1,0], [-1,0], [1,1], [-1,1], [0,1]]
        case .sbw:
            return [[0,-1], [-1,-1], [1,-1], [-1,0], [1,0], [-1,1], [1,1], [0,1]]
        case .swbs:
            return [[-1,-1], [0,-1], [-1,0], [1,-1], [-1,1], [1,0], [0,1], [1,1]]
        case .swbw:
            return [[-1,-1], [-1,0], [0,-1], [-1,1], [1,-1], [0,1], [1,0], [1,1]]
        case .wbs:
            return [[-1,0], [-1,-1], [-1,1], [0,-1], [0,1], [1,-1], [1,1], [1,0]]
        case .wbn:
            return [[-1,0], [-1,1], [-1,-1], [0,1], [0,-1], [1,1], [1,-1], [1,0]]
        case .nwbw:
            return [[-1,1], [-1,0], [0,1], [-1,-1], [1,1], [0,-1], [1,0], [1,-1]]
        case .nwbn:
            return [[-1,1], [0,1], [-1,0], [1,1], [-1,-1], [1,0], [0,-1], [1,-1]]
        case .nbw:
            return [[0,1], [-1,1], [1,1], [-1,0], [1,0], [-1,-1], [1,-1], [0,-1]]
        }
    }
    
    func label() -> String {
        switch self {
        case .nbe:
            return "North by East";
        case .nebn:
            return "Northeast by North";
        case .nebe:
            return "Northeast by East";
        case .ebn:
            return "East by North";
        case .ebs:
            return "East by South"
        case .sebe:
            return "Southeast by East";
        case .sebs:
            return "Southeast by South";
        case .sbe:
            return "South by East";
        case .sbw:
            return "South by West";
        case .swbs:
            return "Southwest by South";
        case .swbw:
            return "Southwest by West";
        case .wbs:
            return "West by South"
        case .wbn:
            return "West by North"
        case .nwbw:
            return "Northwest by West";
        case .nwbn:
            return "Northwest by North";
        case .nbw:
            return "North by West";
        }
    }
}

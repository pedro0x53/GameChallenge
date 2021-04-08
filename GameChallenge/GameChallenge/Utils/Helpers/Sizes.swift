//
//  Sizes.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 06/04/21.
//

import SpriteKit

class Sizes {
    public static let responsiver = Responsiver(designSize: CGSize(width: 390, height: 844))

    public static let handCard  = Sizes.responsiver.responsiveSize(for: CGSize(width: 117, height: 160))
    public static let boardCard = Sizes.responsiver.responsiveSize(for: CGSize(width: 53, height: 74))
    public static let legend    = Sizes.responsiver.responsiveSize(for: CGSize(width: 276, height: 382))
    public static let buttons   = Sizes.responsiver.responsiveSize(for: CGSize(width: 90, height: 90))
}

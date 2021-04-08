//
//  Responsiver.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 17/03/21.
//
import SpriteKit

class Responsiver {
    private static let deviceSize = UIScreen.main.bounds.size

    let designSize: CGSize

    let sizeProportion: CGFloat

    init(designSize: CGSize) {
        self.designSize = designSize

        let designAspectRatio = designSize.width / designSize.height

        let deviceAspectRatioSize = Responsiver.deviceSize.width / Responsiver.deviceSize.height

        self.sizeProportion = deviceAspectRatioSize / designAspectRatio
    }

    func responsiveSize(for size: CGSize) -> CGSize {
        let newWidth = size.width / sizeProportion
        let newHeight = size.height / sizeProportion

        return CGSize(width: newWidth, height: newHeight)
    }
}

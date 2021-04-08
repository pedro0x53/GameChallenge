//
//  Helper.swift
//  GameChallenge
//
//  Created by Pedro Sousa on 18/03/21.
//
// swiftlint:disable shorthand_operator

import SpriteKit

let radian = CGFloat.pi / 180

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func + (left: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: left.x + scalar, y: left.y + scalar)
}

func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func += (left: inout CGPoint, scalar: CGFloat) {
    left.x += scalar
    left.y += scalar
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func - (left: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: left.x - scalar, y: left.y - scalar)
}

func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func -= (left: inout CGPoint, scalar: CGFloat) {
    left.x -= scalar
    left.y -= scalar
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}

func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

func < (left: CGPoint, right: CGPoint) -> Bool {
    return left.hypotenuse() < right.hypotenuse()
}

func > (left: CGPoint, right: CGPoint) -> Bool {
    return left.hypotenuse() > right.hypotenuse()
}

func < (left: CGPoint, scalar: CGFloat) -> Bool {
    return left.hypotenuse() < scalar
}

func > (left: CGPoint, scalar: CGFloat) -> Bool {
    return left.hypotenuse() > scalar
}

func <= (left: CGPoint, right: CGPoint) -> Bool {
    return left.hypotenuse() <= right.hypotenuse()
}

func >= (left: CGPoint, right: CGPoint) -> Bool {
    return left.hypotenuse() >= right.hypotenuse()
}

func <= (left: CGPoint, scalar: CGFloat) -> Bool {
    return left.hypotenuse() <= scalar
}

func >= (left: CGPoint, scalar: CGFloat) -> Bool {
    return left.hypotenuse() >= scalar
}

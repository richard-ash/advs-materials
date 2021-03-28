/// Sample code from the book, Advanced Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/advanced-swift

import Foundation

// Exercise 1

// An imperative solution
// As you might have expected, about a quarter of the points land in the
// second quadrant.

var pcg = PermutedCongruential(seed: 4321)
var total = 0
for _ in 1...100 {
  if Quadrant(Point.random(inRadius: 1, using: &pcg)) == .ii {
    total += 1
  }
}
print(total)

// Alternate solution to exercise 1
// This code uses higher-order functions, that you will learn about in
// Chapter 11 to compute the Quadrant II count of 100 random points.
// Though it gets the right answer, it creates three temporary arrays
// which is not so space efficient.

pcg = PermutedCongruential(seed: 4321)
var inQuadrantII = (1...100)
  .map { _ in Point.random(inRadius: 1, using: &pcg) }
  .map { Quadrant($0) }
  .filter { $0 == .ii }
  .count
print(inQuadrantII)


// Second alternate solution to exercise 1
pcg = PermutedCongruential(seed: 4321)
let quadrantIICount = (1...100).lazy.reduce(0) { count, _ in
  return count + (Quadrant(Point.random(inRadius: 1, using: &pcg)) == .ii ? 1 : 0)
}
print(quadrantIICount)


// Exercise 2

// Typealias don't create a new type but cam make it easier
// to read your code.

typealias Angle = Measurement<UnitAngle>

func sin(_ angle: Angle) -> Double {
  sin(angle.converted(to: .radians).value)
}

func cos(_ angle: Angle) -> Double {
  cos(angle.converted(to: .radians).value)
}

// Exercise 3

extension Angle {
  static let pi = Measurement(value: .pi, unit: .radians)
}

cos(Angle.pi)     // -1
sin(Angle.pi / 2) // 1

// Exercise 4

let liters = Measurement(value: 1.5, unit: UnitVolume.liters)
let cups = liters.converted(to: .cups)
print(cups)

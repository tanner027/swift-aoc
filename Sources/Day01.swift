import Algorithms
import Foundation
/*
 I found a bash solution as well:
 paste -d '-' <(cat Day01.txt | awk '{print $1}' | sort) <(cat Day01.txt | awk '{print $2}' | sort) | bc | awk '{sub("^-", "", $0); sum += $0}  END{print sum;}'
 */


struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  var list1: [Int] = []
  var list2: [Int] = []

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Int {
    // Calculate the sum of the first set of input data
//    entities.first?.reduce(0, +) ?? 0
    var distances: [Int] = []
    for i in 0..<list1.count {
      distances.append(abs(list1[i] - list2[i]))
    }
    return distances.reduce(0, { $0 + $1 })
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Int {
    var distances: [Int] = []
    let countedSet = NSCountedSet(array: list2)
    for element in list1 {
      let occurrences = countedSet.count(for: element)
      distances.append(occurrences * element)
    }
    return distances.reduce(0, +)
  }
  
  init(data: String) {
    self.data = data
    for line in data.split(separator: "\n") {
      let numbers = line.split(separator: "   ")
      list1.append(Int(numbers[0]) ?? 0)
      list2.append(Int(numbers[1]) ?? 0)
    }
    
    if list1.count != list2.count {
      fatalError("The input data does not contain the same number of entries.")
    }
    
    list1.sort()
    list2.sort()
  }
  
}

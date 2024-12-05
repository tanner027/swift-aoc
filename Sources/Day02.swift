import Algorithms
import Foundation
import os
/*
 I found a bash solution as well:
 paste -d '-' <(cat Day01.txt | awk '{print $1}' | sort) <(cat Day01.txt | awk '{print $2}' | sort) | bc | awk '{sub("^-", "", $0); sum += $0}  END{print sum;}'
 */


struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  
  var data: String
  var entries: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }
  
  enum Direction: Equatable {
    case increasing
    case decreasing
    case equal
    
    init(_ value: Int, second: Int) {
      if (value > second) {
        self = .decreasing
      }
      else if (value == second) {
        self = .equal
      }
      else {
        self = .increasing
      }
    }
  }
  
  
  func isReportSafe(_ report: [Int], dampener: Bool = false) -> Bool {
    
    var directions: [Direction] = []
    var directionsSet: NSCountedSet = []
    for i in 0..<report.count {
      if i == report.count - 1 { continue }
      let direction = Direction(report[i], second: report[i+1])
      directionsSet.add(direction)
      directions.append(direction)
      if let badIndex = getBadReportEntryIndex(report,index: i) {
        if dampener {
          var newReport = report
          newReport.remove(at: badIndex)
          return isReportSafe(newReport)
        }
        return false
      }
    }
    
    print(directionsSet)
    if directionsSet.allObjects.count == 1 {
      return true
    }
    if dampener {
      if directionsSet.count(for: Direction.increasing) > directionsSet.count(for: Direction.decreasing) {
        
      }
    }
    
    return false
  }
  
  func getBadReportEntryIndex(_ report: [Int], index: Int) -> Int? {
    let distance = report[index] - report[index+1]
    switch distance {
    case let x where x > 3 || x == 0:
      return index
    case let x where x < -3:
      return index+1
    default:
      return nil
    }
  }

  func part1() -> Int {
    return entries.reduce(0) { sum, entry in
      if isReportSafe(entry) {
        return sum + 1
      }
      return sum
    }
  }
  
  func isReportSafe(_ report: [Int]) -> Bool {
    
    
    for i in 0..<report.count {
      if i == report.count - 1 { continue }
      let distance = abs(report[i] - report[i+1])
      if (distance > 3 || distance == 0) {
        return false
      }
    }
    return reportIsInOrder(report)
  }
  
  func reportIsInOrder(_ report: [Int]) -> Bool {
    if report.sorted() == report || report.sorted().reversed() == report {
      return true
    }
    return false
  }
  
  func isReportSafeWithDampener(_ report: [Int]) -> Bool {

    // run through the report to determine
    // if removing an element makes it safe
    var reportMutable = report
    for i in 0..<report.count {
      if i == report.count - 1 { continue }
      let distance = report[i] - report[i+1]
      switch distance {
      case let x where x > 3:
        reportMutable.remove(at: i)
        return isReportSafe(reportMutable)
      case let x where x < -3 || x == 0:
        reportMutable.remove(at: i+1)
        return isReportSafe(reportMutable)
      default:
        continue
      }
    }
    
    return true
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Int {
    return entries.reduce(0) { sum, entry in
      if isReportSafeWithDampener(entry) {
        print("Found safe report: \(entry)")
        return sum + 1
      }
      return sum
    }
  }
  
  
  
  
  
}

import Algorithms
import Foundation

struct Day02: AdventDay {
  
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
    var previousDirection: Direction?
    for i in 0..<report.count {
      if i == report.count - 1 { continue }
      let distance = abs(report[i] - report[i+1])
      let currentDirection = Direction(report[i], second: report[i+1])
      if previousDirection == nil { previousDirection = currentDirection }
      // if bad levels detected for the current and next index
      if distance == 0 || distance > 3 || currentDirection != previousDirection {
        if dampener {
          // see if removing the current or next index will give us a valid list
          for indexToRemove in ([i,i+1]) {
            var newReport = report
            newReport.remove(at: indexToRemove)
            if isReportSafe(newReport) {
              return true
            }
          }
        }
        return false
      }
    }
    return true
  }
  
  
  
  func part1() -> Int {
    return entries.reduce(0) { sum, entry in
      if isReportSafe(entry) {
        return sum + 1
      }
      return sum
    }
  }
  
  func part2() -> Int {
    return entries.reduce(0) { sum, entry in
      if isReportSafe(entry, dampener: true) {
        return sum + 1
      }
      return sum
    }
  }
}

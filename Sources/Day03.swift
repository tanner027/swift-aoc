import Algorithms
import Foundation
import RegexBuilder



struct Day03: AdventDay {
  
  var data: String
  
  func part1() -> Int {
    let first   = Reference(Int.self)
    let second  = Reference(Int.self)
    let regex   = Regex {
      "mul("
      TryCapture(as: first) {
          OneOrMore(.digit)
      } transform: { match in
          Int(match)
      }
      ","
      TryCapture(as: second) {
          OneOrMore(.digit)
      } transform: { match in
          Int(match)
      }
      ")"
    }
    
    return data.matches(of: regex).reduce(0) { acc, match in
      return acc + (match[first]) * (match[second])
    }
  }
  
  func part2() -> Int {
    let cleanData = data.replacingOccurrences(of: "\n", with: "")
    let first   = Reference(Int.self)
    let second  = Reference(Int.self)
    let doregex = Regex {
      "do()"
    }
    let dontregex = Regex {
      "don't()"
    }
    let regex   = Regex {
      "mul("
      TryCapture(as: first) {
          OneOrMore(.digit)
      } transform: { match in
          Int(match)
      }
      ","
      TryCapture(as: second) {
          OneOrMore(.digit)
      } transform: { match in
          Int(match)
      }
      ")"
    }
    var total = 0
    var doMult = true;
    let splits = cleanData.split(separator: regex, omittingEmptySubsequences: false)
    let matches = cleanData.matches(of: regex)
    for i in 0..<matches.count {
      let precedingInstructions = splits[i]
      let match = matches[i]
      
      // There are no lines split on mul(\d+,\d+) that have both a do() and don't()
      // so we do not need to manage this edge case
      if doMult && precedingInstructions.matches(of: dontregex).count > 0 {
        doMult = false
      } else if !doMult && precedingInstructions.matches(of: doregex).count > 0 {
        doMult = true
      }
      
      if doMult {
        total += (match[first]) * (match[second])
      }
    }
    return total
    
  }
}


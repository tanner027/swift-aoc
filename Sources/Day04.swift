import Algorithms
import Foundation

struct Day04: AdventDay {
  
  enum Xmas: String {
    case X
    case M
    case A
    case S
    
    func next() -> Xmas? {
      switch self {
      case .X: return .M
      case .M: return .A
      case .A: return .S
      case .S: return nil
      }
    }
    
    init(_ character: Character) {
      switch character {
      case "X": self = .X
      case "M": self = .M
      case "A": self = .A
      case "S": self = .S
      default: fatalError("Invalid character \(character)")
      }
    }
  }
  
  var data: String
  
  var wordSearchGRID: [[Xmas]] {
    data.split(separator: "\n").map{
      $0.map{Xmas.init($0)}
    }
  }

  func part1() -> Int {
    var found = 0
    for row in 0..<wordSearchGRID.count {
      for column in 0..<wordSearchGRID[row].count {
        if wordSearchGRID[row][column] == .X {
          found += findXmas(column: column, row: row)
          print("Found X at \((row,column)), found \(found)")
        }
      }
    }
    return found
  }
  
  func findXmas(column: Int, row: Int, current: Xmas = .X) -> Int {
    guard let next = current.next() else { return 1 }
    
    let coords: [(Int, Int)] = [
      // top
      (column, row + 1),
      // top left
      (column - 1, row + 1),
      // top right
      (column + 1, row + 1),
      // left
      (column - 1, row),
      // right
      (column + 1, row),
      // bottom
      (column, row - 1),
      // bottom left
      (column - 1, row - 1),
      // bottom left
      (column + 1, row - 1),
    ]
    
    // NOTE: since the grid dimensions are the same we can use wordSearchGRID.count here
    // prone to cause bugs if input changes
    let validCoords = coords.filter{ coord in
      return coord.0 >= 0 && coord.0 < wordSearchGRID.count && coord.1 >= 0 && coord.1 < wordSearchGRID.count
    }
    
    var found = 0
    for coord in validCoords {
      if wordSearchGRID[coord.1][coord.0] == next {
        print("found \(next) at \((coord.1, coord.0)): \(validCoords)")
        found += findXmas(column: coord.0, row: coord.1, current: next)
      }
    }
    print("found \(found) on the way back from \(current)")
    return found
  }
  
  func part2() -> Int {
0
  }
}

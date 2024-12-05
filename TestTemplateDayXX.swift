//
//  Day01Tests.swift
//  AdventOfCode
//
//  Created by Curtis Couture on 12/2/24.
//

import Testing

@testable import AdventOfCode

struct DayXXTests {
  let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
  
  @Test func testPart1() async throws {
    let challenge = DayXX(data: testData)
    #expect(String(describing: challenge.part1()) == "0")
  }
  
  @Test func testPart2() async throws {
    let challenge = DayXX(data: testData)
    #expect(String(describing: challenge.part2()) == "0")
  }
  
}

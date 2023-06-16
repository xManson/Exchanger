//
//  String+RangeConversion.swift
//

import Foundation

extension String {

    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(
                utf16.startIndex,
                offsetBy: nsRange.location,
                limitedBy: utf16.endIndex
            ),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else {
            return nil
        }
        return from..<to
    }

    public func nsRange(from range: Range<String.Index>) -> NSRange? {
        guard
            range.lowerBound <= endIndex && range.upperBound <= endIndex,
            let lower16 = String.UTF16View.Index(range.lowerBound, within: utf16),
            let upper16 = String.UTF16View.Index(range.upperBound, within: utf16)
        else {
            return nil
        }
        let nsRange = NSRange(
            location: utf16.distance(from: utf16.startIndex, to: lower16),
            length: utf16.distance(from: lower16, to: upper16)
        )
        return nsRange
    }

    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }

}

//
//  Extensions.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 12/01/2024.
//

import Foundation

extension String {
    func upperFirstChar() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

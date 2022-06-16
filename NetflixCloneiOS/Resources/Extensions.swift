//
//  Extensions.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 09/06/22.
//

import Foundation


extension String {
    func capitilizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

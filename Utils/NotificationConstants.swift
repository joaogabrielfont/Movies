//
//  NotificationConstants.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 04/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import Foundation
extension Notification.Name {
    static let ImageDownloaded = Notification.Name("ImageDownloaded")
    static let MoviesDownloaded = Notification.Name("MoviesDownloaded")
}

struct NotificationKeys {
    static let movieId = "id"
}

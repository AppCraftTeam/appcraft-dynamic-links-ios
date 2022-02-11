//
//  FBReader.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 13.01.2022.
//

import UIKit
import Firebase

struct FBReader: Reader {
    
    func readFromUserActivity(_ activity: NSUserActivity, completion: @escaping PathCompletionHandler) -> Bool {
        guard let webPageURL = activity.webpageURL else { return false }
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(webPageURL) { (dynamicLink, _) in
            guard let dynamicLink = dynamicLink?.url else { return }
            completion(getPath(from: dynamicLink))
        }
        return handled
    }
    
    func readFromURL(_ url: URL, completion: PathCompletionHandler) -> Bool {
        guard let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url),
              let dynamicLinkURL = dynamicLink.url
        else { return false }
        completion(getPath(from: dynamicLinkURL))
        return true
    }
}

// MARK: - Supporting methods
private extension FBReader {
    
    func getPath(from url: URL) -> NavigatablePath? {
        guard let dynamicLinkURL = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)?.url else { return nil }
        let urlString = dynamicLinkURL.absoluteString
        let navPath = NavigationPath(urlString: urlString)
        return navPath
    }
}

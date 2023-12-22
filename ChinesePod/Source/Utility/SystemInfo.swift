//
//  SystemInfo.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 22/12/2023.
//

import Foundation

class SystemInfo {
    public static func getVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    public static func getBuild() -> String {
        return Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? ""
    }
    public static func getGitHash() -> String {
        let plistDict: NSDictionary? = self.loadPlist("GitHash")
        var gitHash:String = plistDict?["GIT_COMMIT_HASH"] as? String ?? "---"
        gitHash = gitHash.isEmpty ? "---" : gitHash
        return gitHash
    }
    
    private static func loadPlist(_ resourceName: String) -> NSDictionary? {
        var plistDict: NSDictionary?
        if let path = Bundle.main.path(forResource: resourceName, ofType: "plist") {
            plistDict = NSDictionary(contentsOfFile: path)
        }
        return plistDict
    }
}

//
//  VersionBuildView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct VersionBuildView: View {
    var appVersion: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? NSLocalizedString("Unknown", comment: "Unknown")
    }
    
    var appBuild: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? NSLocalizedString("Unknown", comment: "Unknown")
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text("\(appVersion).\(appBuild)")
        }
        .font(.caption)
        .fontWeight(.light)
        .foregroundStyle(.shade3)
    }
}

#Preview {
    VersionBuildView()
}


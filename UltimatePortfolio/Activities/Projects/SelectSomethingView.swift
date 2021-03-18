//
//  SelectSomethingView.swift
//  UltimatePortfolio
//
//  Created by David Hughes on 17/03/2021.
//

import SwiftUI

struct SelectSomethingView: View {
    var body: some View {
        Text("Please select something from the menu to begin.")
            .italic()
            .foregroundColor(.secondary)
            .padding()
            .multilineTextAlignment(.center)
    }
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}

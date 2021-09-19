//
//  MeView.swift
//  HotProspects
//
//  Created by Chad Smith on 9/17/21.
//

import SwiftUI

struct MeView: View {
    @ObservedObject private var meViewModel = MyDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $meViewModel.name)
                    .textContentType(.name)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $meViewModel.email)
                    .textContentType(.emailAddress)
                    .font(.subheadline)
                    .padding([.horizontal, .bottom])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                QRCodeViewer(data: meViewModel.qrData)
                Spacer()
            }
            .navigationTitle("Your Code")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}

//
//  EmptyView.swift
//  MyWeatherApp
//
//  Created by Master IDL on 20/01/2026.
//

import SwiftUI
struct EmptyView : View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            Text("Aucune ville ajoutée")
                .font(.title2)
                .bold()
            
            Text("Appuyez sur le + pour ajouter votre première ville.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

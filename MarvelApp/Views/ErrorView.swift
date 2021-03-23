//
//  ErrorView.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import SwiftUI

typealias ErrorViewActionHandler = () -> Void

struct ErrorView: View {
    let error: Error
    let handler: ErrorViewActionHandler
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom)
            Text("Error")
                .font(.system(size: 30, weight: .heavy))
                .padding(.bottom,5)
            Text(error.localizedDescription)
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
            Button(action: handler, label: {
                Text("Retry")
                    .font(.system(size: 16, weight: .bold))
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }.padding()
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: MarvelError.dataReturnedNil) {}
    }
}

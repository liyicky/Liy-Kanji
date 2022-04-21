//
//  HeaderView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - PROPERTIES
//    @Environment(\.goBack) private var back
    
    @Binding var showSettingsView: Bool
    @Binding var showInfoView: Bool
    @Binding var goBack: Bool

    
    var body: some View {
        HStack {
            
            if (goBack) {
                Button(action: {
                    goBack = false
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.black)
                })
                .accentColor(Color.primary)
            }
            
            Button(action: {
                self.showSettingsView.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.green, .black)
                    .symbolRenderingMode(.palette)
            })
            .accentColor(Color.primary)
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
            
            
            Spacer()
            
            Text("Liy-Kanji")
                .font(.system(.title))
                .fontWeight(.heavy)
            
            Spacer()
            
            Button(action: {
                self.showSettingsView.toggle()
            }, label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.green, .black)
                    .symbolRenderingMode(.palette)
            })
            .accentColor(Color.primary)
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
            
        }.padding()
    }
}


struct HeaderView_Previews: PreviewProvider {
    @State static var showSettings: Bool = false
    @State static var showInfo: Bool = false
    @State static var goBack: Bool = false
    static var previews: some View {
        HeaderView(showSettingsView: $showSettings, showInfoView: $showInfo, goBack: $goBack)
    }
}

//
//  HintView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/06/06.
//

import SwiftUI

struct HintView: View {
    
    var hint: Hint
    
    var body: some View {
        VStack {
            Text(hint.mnemonic ?? "Out of hints!")
                .font(.footnote)
                .foregroundColor(Color.gray)
            
            Spacer()
            HStack {
                Text("~ " + (hint.author ?? "Anonymous"))
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                Text(hint.date?.toString(format: "MM-dd-yyyy") ?? "a long long time ago")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            }
        }.padding(5)
    }
}

//
//  SaveButtonView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/06/02.
//

import SwiftUI

struct SaveButtonView: View {
    
    @State var isComplete = false
    var onCompletion: () -> Void
    
    var saveButtonSpeed = 0.5
    
    var body: some View {
        ZStack(alignment: .center) {
            
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .foregroundColor(Color.white)
                .frame(width: 200, height: 50)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                .onLongPressGesture(minimumDuration: saveButtonSpeed, maximumDistance: 50, perform: {
                    withAnimation(.easeInOut) {
                        onCompletion()
                        
                        isComplete = false
                    }
                }, onPressingChanged: { isPressing in
                    if isPressing {
                        withAnimation(.easeInOut(duration: saveButtonSpeed)) {
                            isComplete = true
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut) {
                                isComplete = false
                            }
                        }
                    }
                })
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .foregroundColor(isComplete ? Color.green.opacity(1) : Color.green.opacity(0))
                .frame(width: isComplete ? 200 : 0, height: 50, alignment: .leading)
            Text("SAVE")
                .foregroundColor(isComplete ? Color.white : Color.gray.opacity(0.5))
            
            }
            .padding()
        }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView(onCompletion: {})
    }
}

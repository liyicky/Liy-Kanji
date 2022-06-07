//
//  CardStackView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct CardStackView: View {
    
    // MARK: - PROPERTIES
    @State var cardViews: [CardView] = []
    
    // MARK: - Card Swipe Properties
    @GestureState private var dragState = DragState.inactive
    private let dragAreaThreashhold: CGFloat = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    
    
    // MARK: - Drag States
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .inactive, .pressing:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .dragging, .pressing:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(cardViews) { card in
                if isTop(cardView: card) {
                    card
                        .zIndex(1)
                        .offset(x: self.dragState.translation.width, y: self.dragState.translation.height)
                        .scaleEffect(self.dragState.isDragging ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: Double(self.dragState.translation.width / 12)))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: { (value, state, transaction) in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                .onChanged({ longPressOrDragEvent in
                                    handleLongPressOrDragGesture(longPressOrDragEvent)
                                })
                                    .onEnded({ (value) in
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        
                                        // MARK: - SWIPPING LEFT
                                        if drag.translation.width < -self.dragAreaThreashhold {
                                            print("Swipped Left")
                                            SM2Algo.UpdateCard(card: card.kanjiCard, success: false)
                                            AppManager.shared.leftSwipe()
                                        }
                                        
                                        // MARK: - SWIPPING RIGHT
                                        if drag.translation.width > self.dragAreaThreashhold {
                                            print("Swipped Right")
                                            SM2Algo.UpdateCard(card: card.kanjiCard, success: true)
                                            AppManager.shared.rightSwipe()
                                        }
                                        
                                        if drag.translation.width < -self.dragAreaThreashhold || drag.translation.width > self.dragAreaThreashhold {
                                            populate()
                                        }
                                    })
                        )
                        .transition(self.cardRemovalTransition)
                } else {
                    card
                        .offset(x: 0, y: 5)
                }
            }
        }.onAppear {
            populate()
        }
    } // ZStack
    
    func populate() {
        cardViews = []
        
        if let topCard = AppManager.shared.topCard {
            cardViews.append(CardView(kanjiCard: topCard))
        }
        
        withAnimation {
            if let nextCard = AppManager.shared.nextCard {
                cardViews.append(CardView(kanjiCard: nextCard))
            }
        }
    }
    
    func isTop(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id} )
        else {
            return false
        }
        return index == 0
    }
}

//struct CardStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardStackView()
//    }
//}

extension CardStackView {
    func handleLongPressOrDragGesture(_ value:SequenceGesture<LongPressGesture, DragGesture>.Value){
        guard case .second(true, let drag?) = value else {
            return
        }
        
        if drag.translation.width < -self.dragAreaThreashhold {
            self.cardRemovalTransition = .leadingBottom
        }
        
        if drag.translation.width > self.dragAreaThreashhold {
            self.cardRemovalTransition = .trailingBottom
        }
    }
}

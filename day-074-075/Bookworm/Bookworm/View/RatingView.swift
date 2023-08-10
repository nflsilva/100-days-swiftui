//
//  RatingView.swift
//  Bookworm
//
//  Created by nfls on 20/06/2023.
//

import SwiftUI

struct AccessibilityRating: ViewModifier {
    
    let rating: Int
    
    func body(content: Content) -> some View {
        content
            .accessibilityLabel("\(rating == 1 ? "1 star" : "\(rating) stars")")
            .accessibilityRemoveTraits(.isImage)
            .accessibilityAddTraits(rating > 1 ? .isButton : [.isButton, .isSelected])
    }
}

struct RatingView: View {
    
    @Binding var rating: Int16
    var label = ""
    var maximumRating = 5
    let offImage = Image(systemName: "star.fill")
    let onImage = Image(systemName: "star.fill")
    
    let offColor = Color.gray
    let onColor = Color.yellow
 
    var body: some View {
        HStack {
            ForEach(1..<(maximumRating + 1)) { rating in
                if rating <= max(self.rating, 1) {
                    onImage
                        .foregroundColor(onColor)
                        .onTapGesture {
                            setRatingTo(rating)
                        }
                }
                else
                {
                    offImage
                        .foregroundColor(offColor)
                        .onTapGesture {
                            setRatingTo(rating)
                        }
                }
            }
        }
        .accessibilityElement()
        .modifier(AccessibilityRating(rating: Int(rating)))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1}
            default:
                break
            }
        }
        
        
    }
    
    private func setRatingTo(_ rating: Int) {
        self.rating = Int16(rating)
    }
}

struct RatingView_Previews: PreviewProvider {
    @State static var rating = Int16(1)
    static var previews: some View {
        RatingView(rating: $rating)
    }
}

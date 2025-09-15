//
//  CusomAlignmentHStack.swift
//  CustomAlignmentVStack
//
//  Created by Chan Jung on 9/15/25.
//

import Foundation
import SwiftUI

public struct CustomAlignmentHStack: Layout {
    var alignment: VerticalAlignment = .center
    var spacing: CGFloat = 8
    
    // returns a size proposed for the CustomAlignmentVStack view.
    // iterates thru the child views, find out the largest width, and add heights + applicable spaing values
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.dimensions(in: proposal) }
        
        let maxHeight: CGFloat = sizes.map(\.height).max() ?? 0
        let width: CGFloat = sizes.reduce(0) { partialResult, newSize in
                partialResult + newSize.width + spacing
        } - spacing  // removing the last added spacing
        
        return .init(width: width, height: maxHeight)
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let sizes = subviews.map { $0.dimensions(in: ProposedViewSize(width: bounds.width, height: bounds.width)) }
        
        // individual view's size and the corrosponding view
        for (viewSize, view) in zip(sizes, subviews) {
            let preferredVAlignment = view[PreferredVAlignment.self] ?? .center
            
            let yOffset: CGFloat = {
                switch preferredVAlignment {
                case .top: return 0
                case .bottom, .firstTextBaseline, .lastTextBaseline: return (bounds.height - viewSize.height)
                case .center: return ((bounds.height - viewSize.height) / 2)
                default:
                    return 0
                }
            }()
            
            view.place(at: CGPoint(x: origin.x, y: origin.y + yOffset),
                       proposal: ProposedViewSize(width: viewSize.width, height: viewSize.height))
            
            origin.x += viewSize.width + spacing
        }
    }
}

nonisolated struct PreferredVAlignment: LayoutValueKey {
    static let defaultValue: VerticalAlignment? = nil
}

extension View {
    public func preferredVAlignment(_ alignment: VerticalAlignment?) -> some View {
        layoutValue(key: PreferredVAlignment.self, value: alignment)
    }
}
#Preview {
    CustomAlignmentHStack {
        Rectangle().fill(Color.blue).frame(width: 50, height: 70)
        
        Text("🥕 top")
            .preferredVAlignment(.top)
        
        Text("🥕 center")
            .preferredVAlignment(.center)
        
        Text("🥕 bottom")
            .preferredVAlignment(.bottom)
    }
    .border(Color.red)
}

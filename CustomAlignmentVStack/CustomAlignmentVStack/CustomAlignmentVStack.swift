//
//  CustomAlignmentVStack.swift
//  CustomAlignmentVStack
//
//  Created by Chan Jung on 9/15/25.
//

import Foundation
import SwiftUI

public struct CustomAlignmentVStack: Layout {
    var alignment: HorizontalAlignment = .center
    var spacing: CGFloat = 8
    
    // returns a size proposed for the CustomAlignmentVStack view.
    // iterates thru the child views, find out the largest width, and add heights + applicable spaing values
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.dimensions(in: proposal) }
        
        let maxWidth: CGFloat = sizes.map(\.width).max() ?? 0
        let height: CGFloat = sizes.reduce(0) { partialResult, newSize in
                partialResult + newSize.height + spacing
        } - spacing  // removing the last added spacing
        
        return .init(width: maxWidth, height: height)
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let sizes = subviews.map { $0.dimensions(in: ProposedViewSize(width: bounds.width, height: bounds.width)) }
        
        for (viewSize, view) in zip(sizes, subviews) {
            
            // get which alignment this should be in
            let elementAlignment = view[PreferredAlignment.self] ?? self.alignment
            
            let xAxisOffset: CGFloat = {
                switch elementAlignment {
                case .leading:
                    return 0
                case .center:
                    return (bounds.width - viewSize.width) / 2
                case .trailing:
                    return bounds.width - viewSize.width
                default:
                    return (bounds.width - viewSize.width) / 2
                }
            }()
            
            view.place(at: CGPoint(x: origin.x + xAxisOffset, y: origin.y),
                       proposal: ProposedViewSize(width: viewSize.width, height: viewSize.height))
            
            origin.y += viewSize.height + spacing
        }
    }
}

nonisolated struct PreferredAlignment: LayoutValueKey {
    static let defaultValue: HorizontalAlignment? = nil
}

extension View {
    public func preferredAlignment(_ alignment: HorizontalAlignment?) -> some View {
        layoutValue(key: PreferredAlignment.self, value: alignment)
    }
}

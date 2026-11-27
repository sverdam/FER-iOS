//
//  AnimatedSquiggle.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

import SwiftUI

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        func curve(_ x1: CGFloat, _ y1: CGFloat,
                   _ x2: CGFloat, _ y2: CGFloat,
                   _ x: CGFloat, _ y: CGFloat) {
            path.addCurve(to: CGPoint(x: x, y: y),
                          control1: CGPoint(x: x1, y: y1),
                          control2: CGPoint(x: x2, y: y2))
        }

        path.move(to: CGPoint(x: -60, y: 127))
        curve(0, 104, 55, 51, 116, 71)
        curve(172, 91, 151, 140, 133, 176)
        curve(108, 236, 85, 275, 100, 311)
        curve(118, 351, 174, 335, 236, 281)
        curve(304, 221, 370, 121, 422, 83)
        curve(474, 49, 524, 91, 491, 151)
        curve(451, 241, 385, 331, 372, 431)
        curve(366, 521, 430, 520, 500, 470)
        curve(541, 446, 600, 410, 650, 385)

        let scale = rect.width / 569
        return path.applying(CGAffineTransform(scaleX: scale, y: scale))
    }
}

struct AnimatedSquiggle: View {
    @State private var progress: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            SquiggleShape()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [WelcomeColors.squiggleTeal, WelcomeColors.squiggleBlue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(
                        lineWidth: 100 * geo.size.width / 569,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        }
        .aspectRatio(569.0 / 570.0, contentMode: .fit)
        .allowsHitTesting(false)
        .onAppear {
            withAnimation(.timingCurve(0.4, 0, 0.2, 1, duration: 2.5)) {
                progress = 1
            }
        }
    }
}

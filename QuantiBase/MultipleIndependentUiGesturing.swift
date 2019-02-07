//
//  MultipleIndependentTapGesturing.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 22/06/2017.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

// Hidden tap and press gestures may be used to evoke states of application that are not possible to induce during UI tests (i.e. no internet connection).
// Such gestures can be hidden away from regular users by assigning them to hidden views or making them almost imposible for users to induce (i.e. 7x tap or press for 10s).
// There might be multiple such gestures for a single view (because there might be more difficult states to evoke when UI testing)
// and thus multiple different tap or press gestures must be used (i.e. 7x tap + 8x tap). The problem is that 8x tap gesture also invokes 7x tap gesture action.
// -> setIndependency(for:) makes these similar gestures independent from each other.

// Tap gestures
protocol MultipleIndependentUiTapGesturing {
    var uiTapGestureRecognizers: [UITapGestureRecognizer] { get }

    func setIndependency(for recognizers: [UITapGestureRecognizer])
}

extension MultipleIndependentUiTapGesturing {
    func setIndependency(fof recognizers: [UITapGestureRecognizer]) {
        recognizers.forEach { outerGestureRecognizer in
                recognizers.filter { $0.numberOfTapsRequired > outerGestureRecognizer.numberOfTapsRequired }
                    .forEach { innerGestureRecognizer in
                        outerGestureRecognizer.require(toFail: innerGestureRecognizer)
                    }
        }
    }
}

// Press gestures
protocol MultipleIndependentUiPressGesturing {
    var uiPressGestureRecognizers: [UILongPressGestureRecognizer] { get }

    func setIndependency(for recognizers: [UILongPressGestureRecognizer])
}

extension MultipleIndependentUiPressGesturing {
    func setIndependency(for recognizers: [UILongPressGestureRecognizer]) {
        recognizers.forEach { (outerGestureRecognizer) in
            recognizers.filter { $0.minimumPressDuration > outerGestureRecognizer.minimumPressDuration }
                .forEach({ (innerGestureRecognizer) in
                    outerGestureRecognizer.require(toFail: innerGestureRecognizer)
                })
        }
    }
}

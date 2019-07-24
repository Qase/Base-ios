//
//  PrecedenceGroups.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/07/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}

precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: EffectfulComposition
}

precedencegroup Composition {
    associativity: left
    higherThan: SingleTypeComposition
}

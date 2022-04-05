//
//  Bag.swift
//  AnimationChallenge
//
//  Created by Md Shah Alam on 4/3/22.
//

import SwiftUI


// MARK: Bag Data Model and Sample Bag Data
struct Bag: Identifiable {
    var id = UUID().uuidString
    var bagTitle: String
    var artwork: String
}

var bags: [Bag] = [
    Bag(bagTitle: "Bag 1", artwork: "bag1"),
    Bag(bagTitle: "Bag 2", artwork: "bag2"),
    Bag(bagTitle: "Bag 3", artwork: "bag3"),
    Bag(bagTitle: "Bag 4", artwork: "bag4"),
    Bag(bagTitle: "Bag 5", artwork: "bag5"),
    Bag(bagTitle: "Bag 6", artwork: "bag6"),
]

// MARK: Dummy Text
var sampleText = "Loren Ipsum is simply dummy texg of the printing and typesetting industry. Loren Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'loren ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."

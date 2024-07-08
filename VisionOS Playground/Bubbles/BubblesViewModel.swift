//
//  ViewModel.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 04/07/2024.
//

import SwiftUI
import RealityKit

@Observable
class BubblesViewModel {
    
    var isShowingImmersiveBubbles = false
    var isShowingVolumeticBubbles = false
    var bubbleData: [CryptoBubble] = [
        CryptoBubble(
            name: "BTC",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/BTC.png",
            priceChange: 4.2
        ),
        CryptoBubble(
            name: "ETH",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/matter/icons/currency/ic_ETH@3x.png",
            priceChange: -1.3
        ),
        CryptoBubble(
            name: "AVAX",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/AVAX.png",
            priceChange: 6.2
        ),
        CryptoBubble(
            name: "XRP",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/XRP.png",
            priceChange: -6.2
        ),
        CryptoBubble(
            name: "SOL",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/SOL_1.png",
            priceChange: 6.5
        ),
        CryptoBubble(
            name: "AAVE",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/AAVE_colour_128.png",
            priceChange: 4.6
        ),
        CryptoBubble(
            name: "CRV",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/CRV_colour_128.png",
            priceChange: -3.3
        ),
        CryptoBubble(
            name: "ATOM",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/ic_currency_colour_ATOM_128x128.png",
            priceChange: 4.4
        ),
        CryptoBubble(
            name: "DOT",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/ic_currency_colour_dot_128x128.png",
            priceChange: 3.7
        ),
        CryptoBubble(
            name: "MATIC",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/MATIC_1.png",
            priceChange: 4.8
        ),
        CryptoBubble(
            name: "ADA",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/ADA_1.png",
            priceChange: -4.9
        ),
        CryptoBubble(
            name: "LINK",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/LINK.png",
            priceChange: -2.4
        ),
        CryptoBubble(
            name: "UNI",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/UNI.png",
            priceChange: 3.5
        ),
        CryptoBubble(
            name: "LTC",
            icon: "https://d32exi8v9av3ux.cloudfront.net/static/themes/luno_v3/icons/currency/LTC.png",
            priceChange: -3.4
        )
    ]

}

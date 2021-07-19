//
//  CongratsView.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 19/07/2021.
//

import SwiftUI

struct LottieAnimationTypeCongrats: View {
    let filename: String
    var body: some View {
        VStack{
            LottieView(filename: "TaskCompletedGIF")
                .frame(width: 200, height: 200)
        }
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationTypeCongrats(filename: "TaskCompletedGIF")
            .previewDevice("iPhone 12 Pro Max")
    }
}

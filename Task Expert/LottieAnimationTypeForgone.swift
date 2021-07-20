//
//  LottieAnimationTypeForgone.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 19/07/2021.
//

import SwiftUI

struct LottieAnimationTypeForgone: View {
    var body: some View {
        VStack{
            LottieView(filename: "TaskForgone")
                .frame(width: 200, height: 200)
        }
    }
}

struct LottieAnimationTypeForgone_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationTypeForgone()
    }
}

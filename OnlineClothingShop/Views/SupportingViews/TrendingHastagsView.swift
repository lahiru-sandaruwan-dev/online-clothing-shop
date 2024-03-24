//
//  TrendingHastagsView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct TrendingHashtagsView: View {
    var body: some View {
        VStack {
            Text("@Trending")
                .font(tenorSans(18))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            HashtagsView(tags: hashtags)
                .padding([.leading, .trailing], 30)
        }
        
    }
}

struct TrendingHashtagsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingHashtagsView()
    }
}

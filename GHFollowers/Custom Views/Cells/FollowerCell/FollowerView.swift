//
//  FollowerView.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 14.12.2024.
//

import SwiftUI

struct FollowerView: View {
    var follower: Follower
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("avatarPlaceholder")
            }
            .clipShape(Circle())
            Text(follower.login)
                .bold()
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "Doan", avatarUrl: ""))
}

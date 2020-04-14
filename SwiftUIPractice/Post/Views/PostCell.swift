//
//  PostCell.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/11.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                post.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        PostVipBadge(vip: true)
                            .offset(x: 16, y: 16)
                )
                
                VStack(alignment: .leading) {
                    Text(post.name)
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading,10)
                
                if !post.isFollowed {
                    Spacer()
                    
                    Button(action: {
                        print("click follow button")
                    }) {
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                        .frame(width: 50, height: 26)//增大点击区域及圆角
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Text(post.text)
                .font(.system(size: 17))
            
            if !post.images.isEmpty{
                loadImage(name: post.images.first!)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 30, height: (UIScreen.main.bounds.width - 30) * 0.75)
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                PostCellToolbarButton(image: "message", text: post.commentCountText, color: .black) {
                    print("clicked message")
                }
                
                Spacer()
                
                PostCellToolbarButton(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color: post.isLiked ? .red : .black) {
                    print("clicked heart")
                }
                
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(.init(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
        .padding([.horizontal,.top], 15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: loadPostListData("PostListData_recommend_1.json").list[0])
    }
}

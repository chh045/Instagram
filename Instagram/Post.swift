//
//  Post.swift
//  Instagram
//
//  Created by Huang Edison on 3/7/17.
//  Copyright © 2017 Edison. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var image: UIImage?
    var caption: String?
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
    class func postUserImage(image: UIImage, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let post = PFObject(className: "Post")
        
        post["media"] = getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)!
            }
        }
        return nil
    }
}

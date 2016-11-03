//
//  ViewController.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button: UIButton = UIButton(type: .custom)
        button.backgroundColor = UIColor.orange
        button.frame = CGRect(x: 0, y: 100, width: 150, height: 40)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("测试", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func buttonAction(sender: UIButton) {
        
        let loginReq = UserLoginRequest()
        loginReq.userId = 10086
        loginReq.password = "123456789"
        loginReq.nickname = "一枝花"
        print("登录用户ID：\(loginReq.userId)，密码：\(loginReq.password)，昵称：\(loginReq.nickname)")
        
        let data: Data =  loginReq.packageData()
        
        let loginResp = UserLoginResponse(data: data)
        print("返回用户ID：\(loginResp.userId)，密码：\(loginResp.password)，昵称：\(loginResp.nickname)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  QRViewController.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 10..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit
import AVFoundation
class QRreaderViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var videoPreview: UIView!
    let avCaptureSession = AVCaptureSession()
    
    var QRcontents = String()
    
    enum error :Error {
        case noCameraAvailabel
        case videoInputFailed
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try scanQRcode()
        }catch{
            print("Failed to scan the QRcode.")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as!
            AVMetadataMachineReadableCodeObject
            if machineReadableCode.type ==
                AVMetadataMachineReadableCodeObject.ObjectType.qr{
                QRcontents = machineReadableCode.stringValue!
                
                checkQRcode(contents:QRcontents)
                // Stop capture session
                //                videoPreviewLayer?.isHidden = true
                //                qrCodeFrameView?.isHidden = true
                
                self.avCaptureSession.stopRunning()
            }
        }
        
    }
    
    func scanQRcode() throws{
        
        guard  let avCaptureDevice = AVCaptureDevice.default(for : AVMediaType.video) else {
            print("No camera")
            throw error.noCameraAvailabel
        }
        guard  let avCaptureInput = try? AVCaptureDeviceInput(device : avCaptureDevice) else {
            print("Failed to init camera")
            throw error.videoInputFailed
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        
        avCaptureMetadataOutput.metadataObjectTypes =
            [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer =
            AVCaptureVideoPreviewLayer(session:avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity =
            AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back_sleepout"{
            //print("prepare")
            //let destination = segue.destination as! CheckQRViewController
            //destination.check(qrContents:stringUrl)
            let destination = segue.destination as! SleepoutViewController
            
            
        }
    }
    
    func checkQRcode(contents:String){
        let contentArray = contents.split(separator: "/")
        print("부모님 번호",contentArray[2])//0 => notice_id 1=>emirim_id
        
        let noticeID : String = String(contentArray[0])
        let emirimID : String = String(contentArray[1])
        
        //let parentPhone : String = "01011112222"
        // get User Data
        let defaults = UserDefaults.standard
        let parentPhone = defaults.string(forKey: "parent_phone") ?? "Unknown user"
        
        if contentArray[2] == parentPhone{
            recognizeSleepout(noticeID:noticeID,emirimID:emirimID)
            
        }else{
            showAlert(title:"외박인증에 실패했습니다.",message:"등록된 부모님 번호로 인증을 받아주세요.")
        }
        
        
        
        
        
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // alert.addAction(UIAlertAction(title: "Yes", style: .cancle, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            
            self.performSegue(withIdentifier: "back_sleepout", sender: self)
            
        }))
        self.present(alert, animated: true)
        
        
    }
    
    func recognizeSleepout(noticeID:String,emirimID:String){
        DispatchQueue.global(qos: .userInitiated).async {
            
            //요청할 url
            var components = URLComponents(string: "https://dorm.emirim.kr/updateSleepoutRecognize.php")
            //요청변수
            components?.queryItems = [
                URLQueryItem(name: "notice_id", value: noticeID),
                URLQueryItem(name: "emirim_id", value: emirimID),
            ]
            
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                // print(response!)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    DispatchQueue.main.async {
                        
                        
                        if let return_data =  json["return_code"] as? [[String: Any]]{
                            print("리턴 데이터 : ",return_data);
                            for return_data_item in return_data {
                                
                                let return_code : Int = return_data_item["return_code"]! as! Int
                                
                                
                                // let _ : String = return_data_item["return_message"] as! String
                                if(return_code == 1){
                                    self.showAlert(title: "외박인증에 성공했습니다.", message: "인증이 성공적으로 끝났습니다.")
                                }else{
                                    self.showAlert(title: "외박인증에 실패했습니다.", message: "다시 시도해주세요.")
                                }
                            }//for
                            
                        }//return_data
                        
                    }//ui updating
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
        }
        
    }
    
    
    
    
    
}

//
//  InspectViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/16/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit
import Material
import Motion
import Vision
import AVKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON
import AudioToolbox
import PKHUD



class InspectViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate{
    var damageType = "damage type"
    var representedDamage = "damage type"
    var car:car?
    var user = UserManager.manager.currentUser
    var stillImageOutput: AVCapturePhotoOutput!
    @IBOutlet weak var recordButton: RaisedButton!
    
    let cameraOutput = AVCapturePhotoOutput()
    
    
    
    @objc func handleGestureLong(press: UILongPressGestureRecognizer) {
      
        if press.state == .began {
            
        print(cameraOutput)
            
           AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
          print(damageType, "start")
           representedDamage = damageType
        }
        if press.state == .ended{
            print(representedDamage, "end")
            print(cameraOutput)
            
            switch representedDamage {
            case "scratches":
                let params = ["damage_type_id": 1]
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        HUD.flash(.success, delay: 1.0)
                        print(response.result)
                }
            case "chips":
                let params = ["damage_type_id": 3]
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        HUD.flash(.success, delay: 1.0)
                        print(response.result)
                }
            case "dents":
                 let params = ["damage_type_id": 2]
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        HUD.flash(.success, delay: 1.0)
                        print(response.result)
                }
            case "curbRash":
                 let params = ["damage_type_id": 4]
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        HUD.flash(.success, delay: 1.0)
                        print(response.result)
                }
            default:
                print("how did this even happen")
                HUD.flash(.error, delay: 1.0)
            }
        }
    }
   
    @objc func handleTap(press: UITapGestureRecognizer){
        if press.state == .ended {
            print("too short")
        }
    }
 
    
    
    
    let identifierLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .white
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stillImageOutput = AVCapturePhotoOutput()
        print(car!.user_id, "wooooooooooo")
        print(user!.fullName, "current user")
        let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(handleGestureLong(press:)))
        let tapPressGestureRecogn = UITapGestureRecognizer(target: self, action: #selector(handleTap(press:)))
        longPressGestureRecogn.minimumPressDuration = 3.0
        recordButton.addGestureRecognizer(longPressGestureRecogn)
        recordButton.addGestureRecognizer(tapPressGestureRecogn)
     
        
        // here is where we start up the camera
        // for more details visit: https://www.letsbuildthatapp.com/course_video?id=1252
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        
        captureSession.startRunning()
       
        
    

        
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        view.addSubview(recordButton)
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
        //        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
     
        
        //this is where I add my Model!!!
        guard let model = try? VNCoreMLModel(for: damageClassifier3().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
        
      
            
//                        print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
//            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                if firstObservation.confidence * 100 > 65{
                    if firstObservation.identifier == "dents"{
                        self.identifierLabel.text = "Dent \(floor(firstObservation.confidence * 100))%"
                        self.damageType = firstObservation.identifier
                    }
                    else if firstObservation.identifier == "scratches"{
                        self.identifierLabel.text = "Scratch \(floor(firstObservation.confidence * 100))%"
                        self.damageType = firstObservation.identifier
                    }
                    else if firstObservation.identifier == "chips"{
                        self.identifierLabel.text = "Chip \(floor(firstObservation.confidence * 100))%"
                        self.damageType = firstObservation.identifier
                    }
                    else if firstObservation.identifier == "curbRash"{
                        self.identifierLabel.text = "Curb Rash \(floor(firstObservation.confidence * 100))%"
                        self.damageType = firstObservation.identifier
                    }
                    else if firstObservation.identifier == "noDamage"{
                        self.identifierLabel.text = "No damage detected"
                        self.damageType = firstObservation.identifier
                    }
                    else if firstObservation.identifier == "largeDamage"{
                        self.identifierLabel.text = "Significant damage detected"
                        self.damageType = firstObservation.identifier
                    }
            }
                
        }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
}


//
//  SwiftUIView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import SwiftyJSON
import Alamofire

//猫图片上传视图
struct UploadImageView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var saved=false
    @State private var notFoundCat=false

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showingFilterSheet = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .alert(isPresented: $saved ){
                            if notFoundCat {
                                return Alert(title: Text("上传失败"),
                                      message: Text("图中可能没有猫"),
                                      dismissButton: .default(Text("OK")))
                            }
                            return Alert(title: Text("已上传"),
                              message: Text("上传成功"),
                              dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func loadImage() {
        do{
            guard let inputImage = inputImage else { return }
            
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }catch _{
            print("unknown bug")
        }
    }

    func save() {
        //调用图片上传接口
        //判断是否上传成功
        //成功则提示成功
        //否则提示失败
        uploadCatImage(image: processedImage!)

    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func uploadCatImage(image:UIImage){
        //封装Headers
        let headers: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        let imageData=image.jpegData(compressionQuality: 0.5)!
        
        //发送请求
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file",fileName: "file",mimeType: "image/jpg")
        }, to: "https://api.thecatapi.com/v1/images/upload",headers: headers).response{
            (response) in
            let code=response.response?.statusCode
            if code==201{
                print("success")
            }else{
                print("error")
                //上传失败，图中没有猫
                self.notFoundCat=true
            }
            self.saved=true
        }
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
       UploadImageView()
    }
}



import UIKit
import AVFoundation
var player: AVAudioPlayer?

class ViewController: UIViewController {
    
    //let eggTimes = ["Soft":300, "Medium":420, "Hard":720]
    let eggTimes = ["Soft":3, "Medium":4, "Hard":7]
    var timer = Timer()
    var totalTime = 0
    var secondPast = 0
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }

    @IBAction func hardnessSelected(_ sender: UIButton)
    {
        timer.invalidate()
        status.text = "How do you like your eggs?"
        progressBar.progress = 0.0
        secondPast = 0
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondPast < totalTime {
            secondPast += 1
            print("SecondPast: \(Float(secondPast))")
            print("TotalTime: \(Float(totalTime))")
            progressBar.progress = Float(secondPast)/Float(totalTime)
          
        }
        else{
            timer.invalidate()
            playSound()
            status.text = "Done!!"
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

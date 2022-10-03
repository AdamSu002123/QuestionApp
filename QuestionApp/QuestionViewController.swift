//
//  QuestionViewController.swift
//  QuestionApp
//
//  Created by gih96984 on 2022/9/6.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var numberQuestionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var optionButtons: [UIButton]!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var queCountSlider: UISlider!
    @IBOutlet weak var timesLabel: UILabel!
    
    
    //15題
    var ques:[Que] = [Que(depiction: "世界上會寫程式的彼得潘有幾個？", option: ["1","2","3","4"], answer: "1"),Que(depiction: "梅花梅花幾月開？", option: ["1月","5月","6月","想開就開"], answer: "想開就開"),Que(depiction: "華盛頓小時候砍倒他父親的櫻桃樹時，父親為什麼沒馬上處罰他？", option: ["壓根沒有那棵櫻桃樹","櫻桃樹還活著","他手上還有斧頭","他爸氣死了"], answer: "他手上還有斧頭"),Que(depiction: "上完廁所，要用左手、還是右手擦屁屁會比較好？", option: ["左手","衛生紙比較好","右手","沒在擦的"], answer: "衛生紙比較好"),Que(depiction: "一顆心值多少錢？", option: ["一文不值","十元","一億","無價"], answer: "一億"),Que(depiction: "以下哪一個大洲的面積最大？", option: ["大洋洲","南美洲","非洲","亞洲"], answer: "亞洲"),Que(depiction: "什麼蔬菜被稱為營養豐富的「小人參」?", option: ["胡蘿蔔","茄子","白菜","絲瓜"], answer: "胡蘿蔔"),Que(depiction: "以下哪種行為習慣不會造成骨盆旋移？", option: ["蹺二郎腿","騎自行車","踢毽子","扔鉛球"], answer: "騎自行車"),Que(depiction: "夜盲症是因為缺乏什麼而引起的？", option: ["維生素A","維生素B","維生素C","維生素D"], answer: "維生素A"),Que(depiction: "請問一般情況下牛皮紙是用材料做成的？", option: ["樹皮","牛皮","豬皮","草根"], answer: "樹皮"),Que(depiction: "《三十六計》是體現古代卓越軍事思想的一部兵書，下列不屬於《三十六計》的是：", option: ["渾水摸魚","反戈一擊","笑裡藏刀","反客為主"], answer: "反戈一擊"),Que(depiction: "“月上柳梢頭，人約黃昏後”描寫的是哪個傳統節日？", option: ["中秋節","元宵節","端午節","七夕節"], answer: "元宵節"),Que(depiction: "被稱為「英雄樹」的是哪種植物？", option: ["龍眼","木棉","富貴菊","蓮花"], answer: "木棉"),Que(depiction: "下列哪一種樂器的發聲原理和法國號最類似?", option: ["豎琴","鋼琴","直笛","三角鐵"], answer: "直笛"),Que(depiction: "排著對上廁所猜一地名?", option: ["倫敦","臺灣","英格蘭","伊朗"], answer: "倫敦")]
    
    //題數
    var quecount = 0
    //分數
    var grade = 0
    //解答
    var trueAnswer = String() // ""
    //時間
    var counter = 0.0
    var timer:Timer? = nil
    //時間
    //timesLabel.text = String(0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //每次進入題目都會不同
        ques.shuffle()
        start()
        setSliderValue()

    }
    
    //開始
    func start(){
        //開始計時
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        if !ques.isEmpty{
        numberQuestionLabel.text = "\(quecount + 1)"
            gradeLabel.text = "\(grade)"
        descriptionLabel.text = ques[quecount].depiction
        trueAnswer = ques[quecount].answer
        ques[quecount].option.shuffle()
        for i in 0...3{
            optionButtons[i].setTitle(ques[quecount].option[i], for: .normal)
        }
        setSliderValue()
        }

    }
    
    //判斷答題
    @IBAction func ansClick(_ sender: UIButton) {
        quecount += 1
        if sender.currentTitle == trueAnswer && counter < 3 {
            grade += 5
            gradeLabel.text = "\(grade)"
            }
        if quecount < 10{
            resetTimer()
            start()
        }else{
            resetTimer()
            totalgrade()
        }
    }
    
    //設置slider
    func setSliderValue() {
        queCountSlider.maximumValue = Float(9)//0~9
        queCountSlider.value = Float(quecount)
 //     queCountSlider.text = "\(index+1)/10"
    }
    
    //重新開始
    func restart(){
        quecount = 0
        grade = 0
        numberQuestionLabel.text = "\(quecount + 1)"
        gradeLabel.text = "\(grade)"
        gradeLabel.text = "0"
        ques.shuffle()
        start()
        setSliderValue()
    }
    
    //彈出訊息設定
    func alterMessage(title:String,message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let replayAction = UIAlertAction(title: "再玩一次", style: .default) { _ in
            self.restart()}
        alertController.addAction(replayAction)
        self.present(alertController, animated: true, completion: nil)
        resetTimer()
    }
    
   //計算並彈出視窗訊息
    func totalgrade(){
       
        if grade >= 40 && grade <= 50{
            alterMessage(title: "總分\(grade)", message: "你真棒👍🏻")
        }
        else if grade >= 20 && grade < 40 {
            alterMessage(title: "總分\(grade)", message: "一般般啦👐🏻")
        }
        else if grade >= 10 && grade < 20 {
            alterMessage(title: "總分\(grade)", message: "要加油囉👈🏻")
        }
        else {
            alterMessage(title: "總分\(grade)", message: "再接再勵囉🐥")
        }
        
    }

    //計時器歸零
    func resetTimer() {
        timer?.invalidate()
        counter = 0.0
        timesLabel.text = String(counter)
    }
    //開始計時
    @objc func UpdateTimer() {
        counter += 0.1
        timesLabel.text = String(format: "%.1f", counter)
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
}

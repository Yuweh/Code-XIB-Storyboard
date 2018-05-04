// this code is for a game wheel like wordscape

import UIKit

class GameWheel: UIView {

    var level: Level = Level(questionSet: "ImeeMarcos")
    let TileMargin: CGFloat = 1.0 //
    private var tiles = [TileView]()
    
    //EXP ********************
    var path = UIBezierPath()
    var initialLocation = CGPoint.zero
    var finalLocation = CGPoint.zero
    var shapeLayer = CAShapeLayer()
    var swiped = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        

    }
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        path.fill()
        setupView()
        //********
        let randomIndex = randomNumber(min: 0, max: UInt32(level.questions.count-1))
        let anagramPair = level.questions[randomIndex]
        let anagram1 = anagramPair[0] as! String
        //********
        
        let center = CGPoint(x: bounds.width/2 , y: bounds.height/2)
        let radius : CGFloat = 100
        let count = anagram1.count
        
        var angle = CGFloat(2 * M_PI)
        let step = CGFloat(2 * M_PI) / CGFloat(count)
        
        //let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        

        //calculate the tile size
        let tileSide = ceil(ScreenWidth * 1.0 / CGFloat(max(anagram1.characters.count, anagram1.characters.count))) - TileMargin
        
        
        for (index, letter) in anagram1.enumerated() {
            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
            
            //let label = TileView(letter: letter, sideLength: tileSide)
            let label = UILabel()
            label.text = "\(letter)"
            label.text = String(letter).uppercased()
            label.font = UIFont(name: "Arial", size: 25)
            label.textColor = UIColor.black
            label.sizeToFit()
            label.frame.origin.x = x - label.frame.midX
            label.frame.origin.y = y - label.frame.midY
            
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:)))
            label.addGestureRecognizer(tapGesture)
            
            self.addSubview(label)
            angle += step
        }
        
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        // Your code goes here
    }
    
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
//        let line = CAShapeLayer()
//        let linePath = UIBezierPath()
//        linePath.move(to: start)
//        linePath.addLine(to: end)
//        line.path = linePath.cgPath
//        line.strokeColor = UIColor.red.cgColor
//        line.lineWidth = 1
//        line.lineJoin = kCALineJoinRound
//        self.layer.addSublayer(line)
        
        let path = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 6
        shapeLayer.strokeColor = UIColor.orange.cgColor
        path.removeAllPoints()
        path.move(to: start)
        path.addLine(to: end)
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func setupView(){
        self.layer.addSublayer(shapeLayer)
        self.shapeLayer.lineWidth = 6
        self.shapeLayer.strokeColor = UIColor.orange.cgColor 
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let location = touches.first?.location(in: self){
            initialLocation = location
        }
//        swiped = false
//        if let touch = touches.first as? UITouch {
//            initialLocation = touch.location(in: self)
//        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        swiped = true
        if let location = touches.first?.location(in: self){
//            let dx =  location.x //- initialLocation.x
//            let dy = location.y //- initialLocation.y
//
//            finalLocation = abs(dx) > abs(dy) ? CGPoint(x: location.x, y: initialLocation.y) : CGPoint(x: initialLocation.x, y: location.y)
//
            path.removeAllPoints()
            path.move(to: initialLocation)
            path.addLine(to: finalLocation)

            shapeLayer.path = path.cgPath

            finalLocation = location
            //addLine(fromPoint: initialLocation, toPoint: finalLocation)


        }
        
//        if let touch = touches.first as? UITouch {
//            let currentPoint = touch.location(in: self)
//            addLine(fromPoint: initialLocation, toPoint: finalLocation)
//
//            // 7
//            finalLocation = currentPoint
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if swiped {
            addLine(fromPoint: initialLocation, toPoint: finalLocation)
        }
        
        initialLocation = CGPoint.zero
        finalLocation = CGPoint.zero
    }
}

//
//  GameViewController.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 29.03.2023.
//

import UIKit

enum Direction {
  case up
  case down
}

class GameViewController: UIViewController {
  
  // MARK: -IBOutlet
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dataPicker: UIDatePicker!
  
  // MARK: let/var
  let userDefaults = UserDefaults.standard.value(Setting.self, forKey: "key")
  let bottomShip = UIImageView()
  let ship = UIImageView()
  let octopus = UIImageView()
  let shark = UIImageView()
  let fish = UIImageView()
  let fish1 = UIImageView()
  let fish2 = UIImageView()
  let dory = UIImageView()
  let ballFish = UIImageView()
  let progress = UIProgressView()
  var arrayView = [UIView]()
  var timer = Timer()
  var timer2 = Timer()
  let blur = UIVisualEffectView()
  let buttonPlay = UIButton()
  let buttonSettings = UIButton()
  let buttonMenu = UIButton()
  let buttonPoints = UIButton()
  let imageView = UIImageView()
  let formatter = DateFormatter()
  private var nikcName = String()
  private var timeString = Int()
  private var nameShip = String()
  private var dateResult = String()
  private var count = 1
  private var setting: Setting?
 
  // MARK: lifeCircle funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
    label.textColor = .black
    label.text = "1"
    view.addSubview(bottomShip)
    view.addSubview(ship)
    view.addSubview(octopus)
    view.addSubview(shark)
    view.addSubview(fish)
    view.addSubview(fish1)
    view.addSubview(fish2)
    view.addSubview(dory)
    view.addSubview(ballFish)
    view.addSubview(progress)
    blur.isHidden = true
    dataPicker.isHidden = true
    buttonPlay.isHidden = true
    buttonMenu.isHidden = true
    buttonPoints.isHidden = true
    buttonSettings.isHidden = true
    imageView.isHidden = true
    
    arrayView = [ship,shark,fish,fish1,fish2,dory,ballFish]
    nameLabel.text = userDefaults?.name
  }
 
   func createView() {
    
    bottomShip.createBottomShip()
     bottomShip.image = UIImage(named: userDefaults?.color ?? "shipSmall")
    octopus.frame = CGRect(x: self.view.frame.maxX , y: self.view.frame.maxY - 110, width: 120, height: 120)
    octopus.createOctopus()
    ship.frame = CGRect(x: self.view.frame.maxX, y: self.view.frame.minY , width: 100, height: 100)
    ship.createShip()
    shark.frame = CGRect(x: self.view.frame.maxX , y: self.view.frame.maxY - 300 , width: 180, height: 110)
    shark.createShark()
    fish.frame = CGRect(x: self.view.frame.maxX , y: self.view.frame.maxY - 200 , width: 80, height: 50)
    fish.createFish()
    fish1.frame = CGRect(x: self.view.frame.minX - 150 , y: self.view.frame.maxY - 150 , width: 80, height: 50)
    fish1.createFish1()
    fish2.frame = CGRect(x: self.view.frame.maxX , y: self.view.frame.maxY - 120, width: 80, height: 50)
    fish2.createFish2()
    dory.frame = CGRect(x: self.view.frame.minX - 150 , y: self.view.frame.maxY - 280 , width: 80, height: 50)
    dory.createDorry()
    progress.frame = CGRect(x: self.view.frame.midX - 150, y: self.view.frame.maxY - 20, width: 300, height: 1)
    ballFish.frame = CGRect(x: self.view.frame.maxX , y: self.view.frame.maxY - 80, width: 80, height: 80)
    buttonPlay.frame = CGRect(x: self.view.frame.midX - 55, y: self.view.frame.midY + 75, width: 100, height: 100)
    buttonMenu.frame = CGRect(x: self.view.frame.midX - 150, y: self.view.frame.midY + 75, width: 70, height: 70)
    buttonSettings.frame = CGRect(x: self.view.frame.midX + 75, y: self.view.frame.midY + 75, width: 70, height: 70)
     buttonPoints.frame = CGRect(x: self.view.frame.maxX - 100, y: self.view.frame.midY - 180, width: 70, height: 70)
     label.frame = CGRect(x: self.view.frame.maxX - 150 , y: self.view.frame.minY + 20 , width: 60, height: 20)
     ballFish.createBallFish()
     progress.tintColor = .systemBackground
     progress.progress = 1
     let date = dataPicker.date
     formatter.dateFormat = "MM-dd-yyyy HH:mm"

     dateResult = formatter.string(from: date)
     timerPush()
   }
  
  // MARK: @IBAction
  
  @IBAction func buttonBack(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
 
  @IBAction func upBottom(_ sender: UIButton) {
    limit(dirrection: .up)
  }
  @IBAction func downBottom(_ sender: UIButton) {
    limit(dirrection: .down)
  }
  
  // MARK: limit of the progress
  private func limit(dirrection: Direction) {
    UIView.animate(withDuration: 0.3) {
      switch dirrection {
      case .up:
        if self.bottomShip.frame.origin.y < self.view.frame.minY + 50  {
          self.progress.progress = 1
          return
        }
        self.bottomShip.frame.origin.y -= self.bottomShip.frame.width / 4
      case .down:
        if self.bottomShip.frame.origin.y > self.view.frame.maxY{
          self.progress.progress = 0
          self.showGameOver()
        }
        self.bottomShip.frame.origin.y += self.bottomShip.frame.width / 4
      }
    }
  }
  
  // MARK: Game Over View
  private func showGameOver() {
    saveResultGame()
    count = 0
    label.text = count.description
    timer.invalidate()
    blur.isHidden = false
    blur.frame = self.view.frame
    blur.effect = UIBlurEffect(style: .regular)
    view.addSubview(blur)
    
    let image = UIImage(named: "gameOver")
    imageView.isHidden = false
    imageView.image = image
    imageView.frame = CGRect(x: self.view.frame.midX - 150, y: self.view.frame.midY - 100, width: 300, height: 150)
    view.addSubview(imageView)
    
    let imagePlay = UIImage(named: "play 1")
    buttonPlay.isHidden = false
    buttonPlay.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
    buttonPlay.setBackgroundImage(imagePlay, for: .normal)
    buttonPlay.imageView?.contentMode = .scaleAspectFit
    
    view.addSubview(buttonPlay)
    
    let imageSettings = UIImage(named: "settings")
    buttonSettings.isHidden = false
    buttonSettings.setBackgroundImage(imageSettings, for: .normal)
    buttonSettings.imageView?.contentMode = .scaleAspectFit
    buttonSettings.addTarget(self, action: #selector(toTheSetting), for: .touchUpInside)
    view.addSubview(buttonSettings)
    
    let imagePoints = UIImage(named: "table")
    buttonPoints.isHidden = false
    buttonPoints.setBackgroundImage(imagePoints, for: .normal)
    buttonPoints.imageView?.contentMode = .scaleAspectFit
    buttonPoints.addTarget(self, action: #selector(toThePointController), for: .touchUpInside)
    view.addSubview(buttonPoints)
    
    let imageMenu = UIImage(named: "restart")
    buttonMenu.isHidden = false
    buttonMenu.setBackgroundImage(imageMenu, for: .normal)
    buttonMenu.imageView?.contentMode = .scaleAspectFit
    buttonMenu.addTarget(self, action: #selector(toTheMenu), for: .touchUpInside)
    view.addSubview(buttonMenu)
  }
  
  // MARK: Save Result
  private func saveResultGame() {
    nikcName = userDefaults?.name ?? "Unknown"
    timeString = count
    nameShip = userDefaults?.color ?? "Unknown Ship"
    
    let result = Result(nickName: nikcName ,time: timeString, date: dateResult, color: nameShip)
    var resultArray = UserDefaults.standard.value([Result].self, forKey: "ResultKey") ?? [Result]()
    resultArray.append(result)
    UserDefaults.standard.set(encodable: resultArray, forKey: "ResultKey")
    
    for result in resultArray {
      print("nickName: \(result.nickName) , time: \(result.time), color: \(result.color), date: \(result.date)")
      
      print(resultArray.count)
    }
  }
  
  // MARK: func back
  @IBAction func toTheSetting() {
    guard let settings = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as?  SettingsViewController else { return }
    navigationController?.pushViewController(settings, animated: true)
  }
  
  @IBAction func toTheMenu() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func toThePointController() {
    guard let pointView = storyboard?.instantiateViewController(withIdentifier: "PointsViewController") as? PointsViewController else { return }
        navigationController?.pushViewController(pointView, animated: true)
  }
  
  // MARK: Timer
  private func timerPush() {
    timer = Timer.scheduledTimer(withTimeInterval: 20 , repeats: true) { _ in
      self.movingFishandDorry()
    }
    timer = Timer.scheduledTimer(withTimeInterval: 15 , repeats: true) { _ in
      self.movingShipandFish()
    }
    timer = Timer.scheduledTimer(withTimeInterval: 25 , repeats: true) { _ in
      self.movingShark()
    }
    timer = Timer.scheduledTimer(withTimeInterval: 35 , repeats: true) { _ in
      self.movingOctopus()
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { [self] _ in
      for views in arrayView {
        if let presentationFrameA = views.layer.presentation()?.frame,
           presentationFrameA.intersects(bottomShip.frame) {
          progress.progress -= 0.5
        }
      }
    }
    timer = Timer.scheduledTimer(withTimeInterval: 1 , repeats: true) { [self]_ in
      count += 1
      label.text = count.description
      self.progress.progress -= 0.07
      if self.progress.progress == 0.0 {
        showGameOver()
        timer.fire()
      }
    }
  }
  
  // MARK: Animations
  private func movingFishandDorry(){
    UIView.animate(withDuration: 10) { [self] in
      fish.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2 + 250
      fish2.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2
      dory.frame.origin.x += self.view.frame.size.width + self.view.frame.size.width / 2
    } completion: { _ in
      self.fish2.frame.origin.x = self.view.frame.maxX
      self.fish.frame.origin.x = self.view.frame.maxX + 150
      self.dory.frame.origin.x = self.view.frame.minX - 250
      self.timer.fire()
    }
  }
  private func movingShipandFish(){
    UIView.animate(withDuration: 10) { [self] in
      
      ship.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2
      fish1.frame.origin.x += self.view.frame.size.width + self.view.frame.size.width / 2
      ballFish.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2
    } completion: { _ in
      self.ship.frame.origin.x = self.view.frame.maxX
      self.fish1.frame.origin.x = self.view.frame.minX - 350
      self.ballFish.frame.origin.x = self.view.frame.maxX + 200
      self.timer.fire()
    }
  }
  private func movingShark() {
    UIView.animate(withDuration: 10) { [self] in
      
      shark.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2
    } completion: { _ in
      self.shark.frame.origin.x = self.view.frame.maxX + 100
      self.timer.fire()
    }
  }
  private func movingOctopus() {
    UIView.animate(withDuration: 10) { [self] in
      
      octopus.frame.origin.x -= self.view.frame.size.width + self.view.frame.size.width / 2
    } completion: { _ in
      self.octopus.frame.origin.x = self.view.frame.maxX
      self.timer.fire()
    }
  }
  
  // MARK: RestartGame
  @IBAction private func playAgain() {
      timer.invalidate()
      blur.isHidden = true
      imageView.isHidden = true
      buttonPlay.isHidden = true
      buttonMenu.isHidden = true
      buttonSettings.isHidden = true
      buttonPoints.isHidden = true
      imageView.isHidden = true
      self.bottomShip.frame.origin.y = self.view.frame.midY
      self.fish2.frame.origin.x = self.view.frame.maxX
      self.fish.frame.origin.x = self.view.frame.maxX + 150
      self.dory.frame.origin.x = self.view.frame.minX - 250
      self.ship.frame.origin.x = self.view.frame.maxX
      self.fish1.frame.origin.x = self.view.frame.minX - 350
      self.ballFish.frame.origin.x = self.view.frame.maxX + 200
      self.octopus.frame.origin.x = self.view.frame.maxX
      progress.progress = 1
      timer = Timer.scheduledTimer(withTimeInterval: 1 , repeats: true) { [self]_ in
      count += 1
      label.text = count.description
      self.progress.progress -= 0.07
      if self.progress.progress == 0.0 {
        showGameOver()
      }
    }
  }
}

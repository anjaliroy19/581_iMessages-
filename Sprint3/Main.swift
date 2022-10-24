class Main {
  
  //declare calss instance property
  static let messagesShared = Main() 
  
  //implement class initializer
  init() {
   print("New instance of class is being created") 
  }
  
  func processMain() {
   print("Started process.")
    let myCode = [Int]()
  }
  
  //call fn of singleton class
  Main.messagesShared.processMain()
  
  //call messages code operation fn again
  Main.messagesShared.processMain()
}

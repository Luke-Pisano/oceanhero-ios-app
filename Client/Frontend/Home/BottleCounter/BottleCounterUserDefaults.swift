import Foundation

public class BottleCounterUserDefaults {
  private let groupName: String

  private struct Keys {
    static let individualBottleCounter = "com.oceanhero.app.individualBottleCounter"
    static let currentBottleCounter = "com.oceanhero.app.currentBottleCounter"
    static let animationFromCurrentBottleCounterValue = "com.oceanhero.app.animationFromCurrentBottleCounterValue"
  }

  private var userDefaults: UserDefaults? {
    return UserDefaults(suiteName: groupName)
  }

  init(groupName: String =  "group.com.oceanhero.app") {
    self.groupName = groupName
  }

  var animationFromCurrentBottleCounterValue: Bool {
    get {
      return userDefaults?.bool(forKey: Keys.animationFromCurrentBottleCounterValue, defaultValue: true) ?? true
    }

    set {
      userDefaults?.setValue(newValue, forKey: Keys.animationFromCurrentBottleCounterValue)
    }
  }

  public var individualBottleCounter: Int {
    get {
      return UserDefaults.standard.integer(forKey: Keys.individualBottleCounter)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: Keys.individualBottleCounter)
      UserDefaults.standard.synchronize()
    }
  }

  public var currentBottleCounter: Int {
    get {
      return UserDefaults.standard.integer(forKey: Keys.currentBottleCounter)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: Keys.currentBottleCounter)
      UserDefaults.standard.synchronize()
    }
  }
}

extension UserDefaults {
  public func bool(forKey key: String, defaultValue: Bool) -> Bool {
    return object(forKey: key) as? Bool ?? defaultValue
  }
}

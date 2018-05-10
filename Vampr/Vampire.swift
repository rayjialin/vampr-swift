// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class Vampire {
  
  var name: String
  var yearConverted: Int
  var offspring: [Vampire] = []
  var creator: Vampire?
  
  init(name: String, yearConverted: Int) {
    self.name = name
    self.yearConverted = yearConverted
  }
  
  // MARK: Simple tree methods
  
  /// Adds the vampire as an offspring of this vampire
  func add(offspring: Vampire) {
    self.offspring.append(offspring)
    offspring.creator = self
  }
  
  /// The total number of vampires created by that vampire
  var numberOfOffspring: Int {
    return sumAllOffSpringVampr(self.offspring)
  }
  
  /// Returns the number of vampires away from the original vampire this vampire is
  var numberOfVampiresFromOriginal: Int {
    var numberOfAncestors = 0
    var currentVampire = self
    
    while true{
      guard let vampire = currentVampire.creator else {
        break
      }
      
      currentVampire = vampire
      numberOfAncestors += 1
    }
    return numberOfAncestors
  }
  
  /// Returns true if this vampire is more senior than the other vampire. (Who is closer to the original vampire)
  func isMoreSenior(than vampire: Vampire) -> Bool {
    return self.numberOfVampiresFromOriginal < vampire.numberOfVampiresFromOriginal ? true : false
  }
  
  // MARK: Stretch 
  
  /**
   Returns the closest common ancestor of two vampires.
   The closest common anscestor should be the more senior vampire if a direct ancestor is used.
   
   - Example:
   * when comparing Ansel and Sarah, Ansel is the closest common anscestor.
   * when comparing Ansel and Andrew, Ansel is the closest common anscestor.
   */
  func closestCommonAncestor(vampire: Vampire) -> Vampire {

    if self.creator === nil {
      return self
    }

    if vampire.creator === nil {
      return vampire
    }
    
    if self === vampire {
      return self
    }
    
    if self.creator === vampire.creator {
      return self.creator!
    }
    
    var ancestor = self
    var ancestorParam = self
//
    if self.isMoreSenior(than: vampire){
      ancestor = self
      ancestorParam = vampire
    }else {
      ancestor = vampire
      ancestorParam = self
    }
//
    while ancestor.creator != nil {

      while ancestorParam.creator != nil {
        if ancestorParam === ancestor{
          return ancestor
        }

        if ancestorParam.creator === ancestor {
          return ancestor
        }

        ancestorParam = ancestorParam.creator!
      }
    }
    
    return ancestor.creator!
  }
  
  // recursion to get all offsprings
  func sumAllOffSpringVampr(_ vampires: [Vampire]) -> Int{
    var totalOffSpring = 0
    for vampire in vampires{
      // recursive case
      if vampire.offspring.count > 0 {
        totalOffSpring += sumAllOffSpringVampr(vampire.offspring)
      }else {
        // base case
        totalOffSpring += 1
      }
    }
    return totalOffSpring
  }
  
  
}

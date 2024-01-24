import UIKit

/*
func addNumbers(num1:Int,num2:Int)->Int {
    return num1 + num2
}
let result = addNumbers(num1: 1, num2: 2)
print(result)
*/

/*
var sample = {(num1:Int,num2:Int)->Int in
    return num1 + num2
}
let result = sample(1,2)
print(result)
*/

/*
var traiangle = {(top:Int,bottom:Int)->Int in
    return top * bottom / 2
}

let result = traiangle(4,6)
print(result)
*/

var Trapezoid = {(top:Int,bottom:Int,height)->Int in
    return (top + bottom) * height / 2
}

let area = Trapezoid(4,6,8)
print(area)

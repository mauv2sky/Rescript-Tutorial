/* Variant
 * 지금까지 Rescript의 대부분의 자료구조는 익숙했을 것이다.
 * 이 섹션에서는 매우 중요하면서도 익숙하지 않은 자료구조인 Variant를 소개하려 한다.
 * 대부분의 언어에서 많은 자료구조는 AND에 대한 특성을 가지지만, Variant는 우리가 OR을 표현할 수 있게 해준다.
 * 아래의 myResponse는 Yes, No와 PrettyMuch의 케이스를 가지는 Variant 타입이다.
 * 우리는 이것을 variant 생성자라고 부르며, |는 각 생성자를 분리하는 역할을 한다.
 * Variant의 생성자는 첫글자를 대문자로 시작해야 한다.
 */
 type myResponse = 
    | Yes
    | No
    | PrettyMuch

 let areYouCrushingIt = Yes


/* Variant Needs an Explicit Definition
 * 만약 사용중인 Variant가 다른 파일에 있다면, Record를 사용하는 것처럼 해당 범위로 가져올 수 있다.
 */
 let pet: Zoo.animal = Dog   // 더 선호되는 방식
 // 또는
 let pet2 = Zoo.Dog


/* Constructor Arguments
 * Variant의 생성자는 ,로 구분되는 추가데이터를 가질 수 있다.
 */
 type account = 
    | None
    | Instagram(string)
    | Facebook(string, int)

 let myAccount = Facebook("Josh", 26)
 let friendAccount = Instagram("Jenny")

 // 만약 Variant의 인자가 여러 개의 필드를 가진다면, 가독성을 높이기 위해 Record와 같은 문법을 사용할 수 있다.
 // 이것은 기술적으로 "inline record"라고 하며 Variant 생성자 내에서만 허용된다.
 // Rescript의 다른 곳에서는 Record 타입 선언을 inline으로 할 수 없다.
 type user = 
    | Number(int)
    | Id({name: string, password: string})

 let me = Id({name: "Joe", password: "123"})

 // 물론 일반적인 Record 타입을 Variant의 인자로 사용할 수도 있다.
 type u = {name: string, password: string}
 type userTwo =
    | Number(int)
    | Id(u)

 let meTwo = Id({name: "Ivy", password: "qwer"})
 // 출력은 이전보다 성능이 낮고 못생겨 보인다.


/* JavaScript Output
 * Variant 값은 타입 선언에 따라 가능한 JavaScript 출력 3개로 컴파일된다.
    - 인자가 없는 Variant의 생성자 -> 숫자로 컴파일된다.
    - 인자가 있는 Variant의 생성자 -> TAG 필드와, 인자의 갯수만큼 차례대로 _N(0부터)의 필드를 가진다.
    - 타입선언에 단일 생성자만 포함된 인자가 있는 Variant -> TAG 필드가 없는 Object로 컴파일된다.
    - 레이블된 Variant 인자(선언된 record타입을 inline)는 _N 대신 레이블 이름을 가진 객체로 컴파일된다.
      객체에는 이전 규칙을 따라 TAG 필드가 있거나 없을 수 있다.
 */
 type greeting = Hello | Goodbye
 let g1 = Hello
 let g2 = Goodbye

 type outcome = Good | Error(string)
 let o1 = Good
 let o2 = Error("oops!")

 type family = Child | Mom(int, string) | Dad(int)
 let f1 = Child
 let f2 = Mom(30, "Jane")
 let f3 = Dad(32)

 type person = Teacher | Student({gpa: float})
 let p1 = Teacher
 let p2 = Student({gpa: 99.5})

 type s = {score: float}
 type adventurer = Warrior(s) | Wizard(string)
 let a1 = Warrior({score: 10.5})
 let a2 = Wizard("Joe")


/* Tips & Tricks
 * 2개의 인수를 전달하는 생성자와 단일 튜플 인수를 전달하는 생성자를 혼동하지 않도록 주의가 필요하다.
 */
 type account1 =
   | Facebook(string, int)  // 2 arguments
type account2 = 
   | Instagram((string, int))  // 1 argument
 
 // Variant는 생성자가 있어야 한다.
 // type myType = int | string 처럼 생성자가 없는 Variant는 Rescript에서 허용하지 않으며,
 // type myType = Int(int) | String(string)처럼 각 분기에 생성자가 필요하다.

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

 // Variant는 Javascript와 상호운용된다.
 // 꽤 많은 Javascript 라이브러리가 여러 타입의 인자를 허용하는 함수를 제공한다.
 // number과 string을 인자로 받는 myLibrary 함수가 있다고 했을 때, 각 타입의 인자를 단일 바인딩된 함수로 전달하려고 할 것이다.
 @bs.module("./myLibrary") external draw : 'a => unit = "draw"

 type animal = 
   | MyFloat(float)
   | MyString(string)

 let betterDraw = (animal) =>
   switch animal {
      | MyFloat(f) => draw(f)
      | MyString(s) => draw(s)
   }

 betterDraw(MyFloat(1.5))
 // 다른 타입의 인자를 하나의 바인딩된 함수로 전달하면 출력 코드가 혼란스러워질 수 있다.
 // 동일한 JS 호출로 컴파일되는 두개의 external을 정의하는 것이 좋다.
 // Rescript는 이를 위한 몇 가지 다른 방법도 제공한다.
 // https://rescript-lang.org/docs/manual/latest/bind-to-js-function#modeling-polymorphic-function
 @bs.module("./myLibrary") external drawFloat: float => unit = "draw"
 @bs.module("./myLibrary") external drawString: string => unit = "draw"

 // Variant 타입은 필드 이름을 통해 찾아진다.
 // Rescript Record와 비슷하게 함수는 두 개의 Variant가 공유하는 임의의 생성자를 허용하지 않는다.
 // 하지만 Rescript는 이를 허용하는 기능을 제공하는데, 이를 Polymorphic Variant라고 한다.


/* Design Decision 
 * [Polymorphic, open etc] Variant는 다른 언어에서 버그의 주요 원인인 'nullable 타입'의 필요성을 제거한다.
 * 철학적으로 말하면, 문제는 여러가지의 가능한 조건들로부터 야기된다.
 * 우리가 버그라고 부르는 대부분의 문제는 잘못된 조건 핸들링으로부터 발생된다.
 * 타입 시스템은 마술처럼 버그를 제거하지 않으며, 처리되지 않은 조건을 지적하고 이를 커버하도록 요청한다.
 * 즉, "이것 또는 저것"을 올바르게 모델링하는 능력이 중요하다.
 * 성능 측면에서 variant는 잠재적으로 프로그램의 논리 속도를 엄청나게 높일 수 있다. JS와 Rescript의 코드를 비교해보자.
 */
 // Javascript 
 %%raw(`
   var data = 'dog'
   if (data === 'dog') {
      console.log('Wof');
   } else if (data === 'cat') {
      console.log('Meow');
   } else if (data === 'bird') {
      console.log('Kashiiin');
   }
 `)
 // Rescript Variant
 // type anyAnimal은 type anyAnimal = 0 | 1 | 2로 바뀌고,
 // switch는 O(1)로 컴파일된다.
 type anyAnimal = Dog | Cat | Bird
 let data = Dog
 switch data {
    | Dog => Js.log("Wof")
    | Cat => Js.log("Meow")
    | Bird => Js.log("Kashiiin")
 }
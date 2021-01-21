/* Pattern Matching /Destructuring
 * Pattern Matching은 Rescript의 가장 큰 특징 중 하나이다.
 * 다음 3가지 뛰어난 기능을 하나로 결합한다.
    - 비구조화(Destructuring) : 구조화된 배열 또는 객체를 개별적인 변수에 할당
    - 데이터의 형태를 기반으로 하는 switch
    - 완전성 검사
 * 각 기능을 아래에서 자세히 다루어본다.
 */


/* Destructuring
 * JavaScript조차도 우리가 원하는 부분을 추출하고 변수 이름을 할당하기 위해
 * 자료구조를 '개방'하는 비구조화 기능이 존재한다.
 */
 let coordinates = (10, 20, 30)
 let (x, _, _) = coordinates
 Js.log(x)

 // 비구조화는 기본으로 제공되는 대부분의 자료구조에서 작동된다.
 // Record
 type student = {name: string, age: int}
 let student1 = {name: "John", age: 10}
 let {name} = student1      // "John"이 'name'에 할당된다.
 // Variant
 type reslut =
    | Success(string)
 let myResult = Success("You did it!")
 let Success(message) = myResult     // "You did it!"이 'message'에 할당된다.

 // 일반적으로 바인딩을 배치하는 모든 곳에서 비구조화를 사용할 수 있다.
 type result1 =
    | Complete(string)
 let displayMessage = (Complete(m)) => {
     // 매개변수를 비구조화하여 성공 메시지 문자열을 직접적으로 추출할 수 있다.
     Js.log(m)
 }
 displayMessage(Complete("You did it!"))

 // Record에서는 비구조화하는 동안 이름을 변경할 수 있다.
 let {name: n} = student1   // "John"이 'n'에 할당된다.

 // 이론적으로 최상위 레벨에서도 배열과 리스트를 비구조화 시킬 수 있다.
 let myArray = [1, 2, 3]
 let [item1, item2, _] = myArray
 // 1은 'item1', 2는 'item2'로 할당되고 3번째 항목은 무시된다.
 // let myList = list{1, 2, 3}
 // let list{head, ...tail} = myList
 // (위의 코드는 최상위 수준 바인딩 에러 발생 : https://github.com/rescript-lang/rescript-compiler/issues/4912)
 // 1은 'head', 'list{2, 3}'은 'tail'에 할당된다.
 // 하지만 배열 예제는 권장하지 않으며 리스트 예제는 에러를 발생할 것이다.
 // 이는 안정성을 위해서 존재한다. 아래에서 볼 수 있듯이 switch를 통해 destructuring array 및 list를 올바르게 사용할 수 있다.


/* Switch Based on Shape of Data
 * 패턴 매칭의 비구조화 기능은 좋지만, 코드 구조화에 대해 생각하는 방식을 실제로 변경하지 않는다.
 * 코드에 대해 생각하는 패러다임을 바꾸는 하나의 방법은 데이터의 형태에 따라 코드를 실행하는 것이다.
 * Variant를 생각해보자.
 */
 type payload =
    | BadResult(int)
    | GoodResult(string)
    | NoResult
 // 값이 GoodResult(...)인 경우 성공 메시지를 출력하고, 값이 NoResult일 때는 다르게 작동하는 등
 // 세 가지 케이스를 각각 다르게 처리하고 싶다.
 // 이런 경우, 다른 언어에서는 읽기 어렵고 오류가 발생하기 쉬운 일련의 if-else로 끝이 난다.
 // Rescript에서는 강력한 switch 패턴 매칭 기능을 사용하여 개별화된 인자에 따라 올바른 코드를 호출하면서 값을 디스트럭처링할 수 있다.
 let data = GoodResult("Product shipped!")
 switch data {
     | GoodResult(theMessage) =>
        Js.log("Success! " ++ theMessage)
     | BadResult(errorCode) =>
        Js.log("Something's wrong. The error code is: " ++ Js.Int.toString(errorCode))
     | NoResult =>
        Js.log("Bah.")
 }
 // 정확한 값의 형태를 기반으로, 깔끔하고 컴파일러에 검증된 코드의 선형 목록으로 표현할 수 있다.
 // 아래는 다른 언어로 코딩할 때 머리가 좀 아파질 실제 시나리오이다.
 type status = Vacations(int) | Sabbatical(int) | Sick | Present
 type reportCard = {passing: bool, gpa: float}
 type person =
    | Teacher({
        name: string,
        age: int
    })
    | Student({
        name: string,
        status: status,
        reportCard: reportCard
    })
 // 이 시나리오에 대한 요구사항이다.
 //     - Mary나 Joe의 이름을 가진 교사는 비공식적으로 인사한다.
 //     - 다른 교사는 공식적으로 인사한다.
 //     - 학생인 경우, 학기를 통과하면 축하해준다.
 //     - 만약 학생의 평균 평점이 0이고 휴가중이거나 안식일이면 다른 메시지를 표시한다.
 //     - 모든 학생을 위한 메시지를 표시한다.
 // Rescript를 사용하면 쉽게 코딩할 수 있다.
 let person1 = Teacher({name: "Jane", age: 35})

 let message = switch person1 {
 | Teacher({name: "Mary" | "Joe"}) =>
    `Hey, still going to the party on Saturday?`
 | Teacher({name}) =>
    `Hello ${name}.`
 | Student({name, reportCard: {passing: true, gpa}}) =>
    `Congrats ${name}, nice GPA of ${Js.Float.toString(gpa)}`
 | Student({
     reportCard: {gpa: 0.0},
     status: Vacations(daysLeft) | Sabbatical(daysLeft)
    }) =>
     `Come back in ${Js.Int.toString(daysLeft)} days!`
 | Student({status: Sick}) =>
     `How are you feeling?`
 | Student({name}) =>
     `Good luck next semester ${name}!`
 }
 // 값을 간결하게 분석하고
 // "Mary" | "Joe" 와 "Vacations" | "Sabbatical"과 같이 중첩 패턴 검사를 할 수 있으며
 // daysLeft 값을 추출하는 동안 바인딩 메시지에 인사말을 할당할 수 있었다.
 // 다음은 인라인 튜플을 활용한 패턴매칭의 다른 예제이다.
 type animal = Dog | Cat | Bird
 let isBig = true
 let myAnimal = Dog
 let categoryId = switch (isBig, myAnimal) {
     | (true, Dog) => 1
     | (true, Cat) => 2
     | (true, Bird) => 3
     | (false, Dog | Cat) => 4
     | (false, Bird) => 5
 }
 //     ISBIG\MYANIMAL      DOG     CAT     BIRD
 // --------------------------------------------------
 //         true             1       2       3
 //         false            4       4       5
 
 // 이전 person 예제에서 보여준 중첩 패턴 검사는 switch의 최상위 수준에서도 작동한다.
 let myStatus = Vacations(10)
 switch myStatus {
 | Vacations(days)
 | Sabbatical(days) => Js.log(`Come back in ${Js.Int.toString(days)} days!`)
 | Sick
 | Present => Js.log("Hey! How are you?")
 }
 // 여러 케이스가 같은 방식으로 처리된다면 논리의 특정 타입으로 정리할 수 있다.
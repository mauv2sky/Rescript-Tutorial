/* Pattern Matching /Destructuring
 * 패턴매칭은 리스크립트의 가장 큰 특징 중 하나로, 다음 세가지의 뛰어난 기능을 하나로 결합한다.
    - 구조분해 : 구조화된 배열 또는 객체를 개별적인 변수에 할당
    - 데이터의 형태를 기반으로 하는 switch문
    - 완전성 검사
 * 각 기능을 아래에서 자세히 다루어본다.
 */


/* 구조분해(Destructuring)
 * 자바스크립트조차도 우리가 원하는 부분을 추출하고 변수 이름을 할당하기 위해
 * 자료구조를 '개방'하는 구조분해 기능이 존재한다.
 */
 let coordinates = (10, 20, 30)
 let (x, _, _) = coordinates
 Js.log(x)

 // 구조분해는 기본으로 제공되는 대부분의 자료구조에서 작동한다.
 // Record
 type student = {name: string, age: int}
 let student1 = {name: "John", age: 10}
 let {name} = student1      // "John"이 'name'에 할당된다.
 // Variant
 type reslut =
    | Success(string)
 let myResult = Success("You did it!")
 let Success(message) = myResult     // "You did it!"이 'message'에 할당된다.

 // 일반적으로 바인딩을 배치하는 모든 곳에서 구조분해를 사용할 수 있다.
 type result1 =
    | Complete(string)
 let displayMessage = (Complete(m)) => {
     // 매개변수를 구조분해하여 성공 메시지 문자열을 직접적으로 추출할 수 있다.
     Js.log(m)
 }
 displayMessage(Complete("You did it!"))

 // 레코드는 구조분해 시에 이름을 변경할 수 있다.
 let {name: n} = student1   // "John"이 'n'에 할당된다.

 // 이론적으로 최상위 레벨에서도 배열과 리스트를 구조분해 시킬 수 있다.
 let myArray = [1, 2, 3]
 let [item1, item2, _] = myArray
 // 1은 'item1', 2는 'item2'로 할당되고 3번째 항목은 무시된다.
 // let myList = list{1, 2, 3}
 // let list{head, ...tail} = myList
 // (위의 코드는 최상위 수준 바인딩 에러 발생 : https://github.com/rescript-lang/rescript-compiler/issues/4912)
 // 1은 'head', 'list{2, 3}'은 'tail'에 할당된다.
 // 하지만 위의 배열 예제는 강하게 권장하지 않으며 리스트 예제는 에러를 발생할 것이다.
 // 단지 이런 것도 가능하다는 것을 보여주기 위한 예시로 가급적 튜플을 사용하는 것을 권장한다.
 // 다음 내용에서 볼 수 있듯이 switch를 사용하여 배열과 리스트를 올바르게 구조분해할 수 있다.


/* 데이터 형태에 따른 switch문(Switch Based on Shape of Data)
 * 패턴 매칭은 구조분해가 되는 장점을 지니면서도 작성자가 의도하는 코드의 구조에는 영향을 주지 않는다.
 * 코드에 대해 생각하는 패러다임을 바꾸는 하나의 방법은 데이터의 형태에 따라 다른 코드를 실행하는 것이다.
 * 배리언트를 생각해보자.
 */
 type payload =
    | BadResult(int)
    | GoodResult(string)
    | NoResult
 // 위의 세 가지 케이스를 각각 다르게 처리하고 싶다고 가정해보자.
 // 이런 상황에 다른 언어에서는 일련의 if-else를 연거푸 작성하곤 하는데, 이는 읽기가 어렵고 오류가 발생하기 쉽다.
 // 리스크립트에서는 강력한 switch 패턴매칭을 사용하여 구조분해를 하고, 각각 분해된 결과의 오른편에 작성된 코드가 실행되도록 한다.
 let data = GoodResult("Product shipped!")
 switch data {
     | GoodResult(theMessage) =>
        Js.log("Success! " ++ theMessage)
     | BadResult(errorCode) =>
        Js.log("Something's wrong. The error code is: " ++ Js.Int.toString(errorCode))
     | NoResult =>
        Js.log("Bah.")
 }
 // 정확한 값의 형태를 기반으로 실행 가능한 깔끔하고 컴파일러가 검증한 선형적인 코드로 표현할 수 있다.
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
 //     - Mary나 Joe의 이름을 가진 교사는 사적으로 인사한다.
 //     - 다른 교사는 공식적으로 인사한다.
 //     - 학생인 경우 학기를 통과하면 축하해준다.
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
 
 // 폴-스루(Fall-Through) 패턴
 // 이전 person 예제에서 보여준 중첩 패턴 검사는 switch의 최상위 수준에서도 작동한다.
 let myStatus = Vacations(10)
 switch myStatus {
 | Vacations(days)
 | Sabbatical(days) => Js.log(`Come back in ${Js.Int.toString(days)} days!`)
 | Sick
 | Present => Js.log("Hey! How are you?")
 }
 // 여러 케이스가 같은 방식으로 처리를 해야 하면 특정 타입으로 로직을 정리할 수 있다.
 
 // Teacher(payload)와 같은 값이 있는데 Teacher 부분에서 패턴 일치만 하고 payload는 무시하려는 경우에는
 // 다음과 같이 _ 와일드 카드를 사용할 수 있다.
 switch person1 {
    | Teacher(_) => Js.log("Hi teacher")
    | Student(_) => Js.log("Hey student")
 }
 // _는 switch의 최상위 수준에서도 작동하며 catch-all 조건으로 사용된다.
 switch myStatus {
    | Vacations(_) => Js.log("Have fun!")
    | _ => Js.log("Ok.")
 }
 // 하지만 최상위 수준의 catch-all 조건을 남용하면 안된다.
 // 가급적 모든 경우의 수를 작성하는 것을 권장한다.
 switch myStatus {
    | Vacations(_) => Js.log("Have fun!")
    | Sabbatical(_) | Sick | Present => Js.log("Ok.")
 }
 // 일일이 작성하는 것이 번거로울 수 있지만 이는 한 번만 하면 끝나는 작업이다.
 // 만약 Quarantined라는 배리언트를 status 타입에 추가하거나, 패턴이 일치하는 위치를 변경해야 할 때 도움이 된다.
 // 최상위 수준의 와일드 카드는 잠재적으로 버그를 일으킬 수 있기 때문에 주의해야 한다.
 
 // When절
 // 때때로 값의 형태보다 더 많은 조건을 확인하거나 임의의 검사를 실행하고 싶은 경우가 있다.
 // 그럴 때 다음과 같이 작성하고 싶을 수 있다.
 switch person1 {
    | Teacher(_) => ()
    | Student({reportCard: {gpa}}) =>
      if gpa < 0.5 {
         Js.log("What's happening")
      } else {
         Js.log("Heyo")
      }
 }
 // switch 패턴은 패턴을 선형으로 유지하기 위해 임의 검사 if에 대한 바로가기를 지원한다.
 // 이 때 when 절을 이용할 수 있다.
 switch person1 {
    | Teacher(_) => ()
    | Student({reportCard: {gpa}}) when gpa < 0.5 =>
      Js.log("What's happening")
    | Student(_) =>
      Js.log("Heyo")
 }

 // 예외 매칭
 // 함수에서 예외가 발생하면, 함수의 일반적으로 반환되는 값에 추가하여 해당 예외도 일치시킬 수 있다.
 let myItems = list{1, 2, 3}
 let theItem = 1
 switch List.find(i => i === theItem, myItems) {
   | item => Js.log(item)
   | exception Not_found => Js.log("No such item found!")
 }

 // 배열 매칭
 let students = ["Jane", "Harvey", "patrick"]
 switch students {
    | [] => Js.log("There are no students")
    | [student1] =>
      Js.log("There's a single student here: " ++ student1)
    | manyStudents =>
      Js.log2("The students are: ", manyStudents)
 }

 // 리스트 매칭
 // 리스트 패턴매칭은 배열과 유사하나 리스트의 꼬리를 추출하는 추가 기능이 있다. (첫 번째 요소를 제외한 모든 요소)
 let rec printStudents = (students) => {
    switch students {
       | list{} => ()
       | list{student} => Js.log("Last student: " ++ student)
       | list{student1, ...otherStudents} =>
         Js.log(student1)
         printStudents(otherStudents)
    }
 }
 printStudents(list{"Jane", "Harvey", "Patrick"})

 // 주의할 점: let-binding한 이름이나 기타 항목이 아닌 패턴으로만 리터럴(ex. 구체적인 값)을 전달할 수 있다.
 // 아래의 코드는 에러가 발생한다.
 // let coordinates = (10, 20, 30)
 // let centerY = 20
 // switch coordinates {
 //   | (x, centerY, _) => Js.log(x)
 // }
 // coordinates의 두 번째 값과 centerY의 값이 동일해 옳은 로직이라고 생각할 수 있으나,
 // coordinates의 두 번째 값이 centerY에 할당되는 것으로 해석하기 때문에 옳은 방식으로 볼 수 없다.


/* 완전성 검사(Exhaustiveness Check)
 * 리스크립트는 가장 중요한 패턴 매칭 기능인 '누락된 패턴을 컴파일 시점 검사(compile-time check of missing patterns)' 하는 기능도 제공한다.
 * 위의 예시를 다시 한 번 살펴보자.
 */
 let message = switch person1 {
   | Teacher({name: "Mary" | "Joe"}) =>
      `Hey, still going to the party on Saturday?` 
   | Student({name, reportCard: {passing: true, gpa}}) =>
      `Congrats ${name}, nice GPA of ${Js.Float.toString(gpa)} you got there!`
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
 // 이전 예시와 다르게 Teacher({name})이 "Mary" 또는 "Joe"가 아닌 조건에 대한 처리하는 부분을 제거했다.
 // 모든 시나리오를 처리하지 못하는 것은 대부분의 프로그램 버그를 발생하는 원인이 되며, 이는 다른 사람이 작성한 코드를 리팩토링할 때 자주 발생된다.
 // 다행히 리스크립트의 경우 컴파일러에서 다음과 같이 알려준다.
 /*
      Warning 8: this pattern-matching is not exhaustive.
      Here is an example of a value that is not matched:
      Some({name: ""})
 */
 // 리스크립트의 완전성 검사를 통해 코드를 실행하기 전에 중요한 버그의 전체 범주를 지울 수 있다.
 // 다음은 대부분의 nullable 값이 처리되는 방식이다.
 let myNullableValue = Some(5)
 switch myNullableValue {
    | Some(v) => Js.log("value is present")
    | None => Js.log("value is absent")
 }
 // None 케이스를 처리하지 않으면 컴파일러가 경고한다.
 // 이로써 더이상 코드에 undefined 버그는 발생하지 않는다.


/* 결론 및 팁
 * 간결한 구조분해 구문, switch의 적절한 조건 처리, 정적 완전성 검사를 통해
 * 패턴 매칭이 올바른 코드를 작성하기 위한 획기적인 방법임을 습득하기 바란다.
 * 추가로 몇 가지 집어보자면,
      - 와일드 카드(_)를 남용하지 않도록 하자. 컴파일러가 더 나은 완정성 검사를 하지 못하도록 막는다.
        배리언트에 새 케이스를 추가하는 리팩토링을 할 때 특히 중요하다. 다양한 타입들을 허용하는 경우에만 사용하도록 하자.
      - when 절을 아껴서 사용하고, 가능하면 최대한 패턴 매칭을 단조롭게 만들자.
        이것이 버그를 줄이는 최고의 방법이다.
   아래는 가장 나쁜 코드부터 최고의 코드까지 나열한 것이다.
 */
 let optionBoolToBool = opt => {
    if opt == None {
       false
    } else if opt === Some(true) {
       true
    } else {
       false
    }
 }
 // 위 코드조각 대신 우리는 이제 패턴매칭을 사용할 수 있다.
 let optionBoolToBool = opt => {
    switch opt {
       | None => false
       | Some(a) => a? true : false
    }
 }
 // 약간 나아졌으나 여전히 중첩되어있다.
 let optionBoolToBool = opt => {
    switch opt {
       | None => false
       | Some(true) => true
       | Some(false) => false
    }
 }
 // 훨씬 선형적으로 보인다! 여기서 아래처럼 시도할 수 있다.
 let optionBoolToBool = opt =>{
    switch opt {
       | Some(true) => true
       | _ => false
    }
 }
 // 훨씬 간결하지만 앞서 말했던 완전성 검사를 사용할 수 없다. 아래의 코드가 최선의 방법이다.
 let optionBoolToBool = opt => {
    switch opt {
       | Some(trueOrFalse) => trueOrFalse
       | None => false
    }
 }
 // 분기가 많은 if-else 구문 대신에 패턴매칭 사용을 권장한다. 더 간결하고 성능도 뛰어나다.

/* Pipe
 * Rescript는 파이프라고 부르는 작지만 놀랍도록 유용한 -> 연산자를 제공한다.
 * -> 연산자를 사용하면 코드의 안과 밖을 뒤집을 수 있다. 즉 a(b)가 b->a로 표현된다.
 * 런타임 비용이 들지 않는 간단한 구문이다.
 * 함수호출문이 여러 개의 함수로 중첩되어 있을 때 이를 쉽게 읽기가 힘들다.
 * 파이프를 사용하면 같은 함수호출문이라도 간소화하여 읽기 쉽게 표현할 수 있다.
 */
 // 원본 코드
 /*
     validateAge(getAge(parseData(person)))
 */
 // Pipe를 사용한 코드
 /* 
     person
        -> parseData
        -> getAge
        -> validateAge
 */
 // 함수가 둘 이상의 인수를 취할 때도 작동한다.
 /* 
     a(one, two, three)

     one -> a(two, three)
 */
 // Pipe는 객체지향 프로그래밍을 모방하기 위해 사용된다.
 // Java와 같은 객체지향언어에서 myStudent.getName은 Rescript에서는 myStudent -> getName으로 표기된다. (getName(myStudent))
 // 이는 거대한 클래스 시스템에서의 단점 없이 OOP의 좋은 부분만을 읽을 수 있게 도와준다.


/* Tips & Tricks
 * Pipe는 정확한 목적을 위해 사용되어야 하며 남용해서는 안된다.
 * Pipe를 활용하기 위해 라이브러리의 API를 만드는 경우가 있는데 이는 잘못된 생각이다.
 */


/* JS Method Chaining
 * 이 개념을 시작하기에 앞서 Rescript의 binding API에 대한 사전지식이 요구된다.
 * https://rescript-lang.org/docs/manual/latest/bind-to-js-function#object-method
 * JavaScript의 API는 종종 객체와 연결되며 다음과 같이 체인이 가능하다.
    const result = [1, 2, 3].map(a => a + 1).filter(a => a % 2 === 0);
    asyncRequest()
        .setWaitDuration(4000)
        .send();
 * 위의 연결동작이 필요하지 않다고 가정한다면 이전 섹션의 bs.send를 사용하여 각 경우에 바인딩한다.
     @bs.send external map: (array<'a>, 'a => 'b) => array<'b> = "map"
     @bs.send external filter: (array<'a>, 'a => bool) => array<'a> = "filter"

     type request
     @bs.val external asyncRequest: unit => request = "asyncRequest"
     @bs.send external setWaitDuration: (request, int) => request = "setWaitDuration"
     @bs.send external send: request => unit = "send"
 * Rescript에서 다음처럼 사용할 수 있다.
     let result = Js.Array2.filter(
         Js.Array2.map([1, 2, 3], a => a + 1),
         a => mod(a, 2) == 0
     )
     send(setWaitDuration(asyncRequest(), 4000))
 * 같은 코드를 Pipe를 사용함으로써 간소화할 수 있다.
     let result = [1, 2, 3]
        -> map(a => a + 1)
        -> filter(a => mod(a, 2) == 0)
     asyncRequest() -> setWaitDuration(4000) -> send
 */


/* Pipe Into Variants
 * 함수처럼 Pipe를 Variant의 생성자로 만들 수 있다.
     let result = name -> preprocess -> Some
     // 다음 코드와 동일하다.
     let result = Some(preprocess(name))
 * Variant 생성자를 함수로 사용하면 다른 곳에서는 작동하지 않는다.
 */


/* Pipe Placeholders
 * Placeholder는 밑줄로 작성되며 나중에 함수의 인수를 채울 것임을 Rescript에게 알린다.
 * 다음 두 가지는 동일한 의미를 갖는다.
     let addTo7 = (x) => add3(3, x, 4)
     let addTo7 = add3(3, _, 4)
 * 가끔 내가 가지고 있는 값을 첫번째 위치로 파이프 시키고 싶지 않을 수 있다.
 * 이런 경우에 Placeholder 값을 표시하여 파이프할 인수를 표시할 수 있다.
 * person과 name을 인수로 갖는 namePerson이라는 함수가 있다고 가정하면 person을 다음과 같이 파이프화 시킬 수 있다.
     makePerson(~age=47, ())
        -> namePerson("Jane")
 * person 객체에 적용하고 싶은 name이 있을 경우, placeholder를 사용할 수 있다.
     getName(input)
        -> namePerson(personDetails, _)
 * 이를 통해 위치 인수로 파이프 할 수 있다. 이름이 지정된 인수에 대해서도 작동한다.
     getName(input)
        -> namePerson(~person=personDetails, ~name=_)
 */
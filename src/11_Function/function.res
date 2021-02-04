/* Function
 * 함수는 화살표로 선언되고 표현식을 반환한다.
 */
 let greet = (name) => Js.log("Hello " ++ name)
 // 함수 이름을 사용하여 호출할 수 있다.
 greet("world!")
 // 다중 인자 함수는 쉼표로 구분되는 인자를 가진다.
 let add = (x, y, z) => Js.log(x + y + z)
 add(1, 2, 3)
 // 길이가 긴 함수의 경우 중괄호로 감싸면 된다.
 let greetMore = (name) => {
     let part1 = "Hello"
     part1 ++ " " ++ name
 }
 // 만약 인자가 없는 함수인 경우 소괄호를 비워두면 된다.
 let greetMore = () => {
     "Hello world!"
 }


/* Labeled Arguments
 * 다중 인자 함수, 특히 인수가 동일한 타입인 함수는 호출할 때 혼란스러울 수 있다.
 * 인자의 이름 앞에 ~ 기호를 붙여 레이블을 인수에 첨부할 수 있다. 
 */
 let addCoordinates = (~x, ~y) => Js.log(x + y)
 addCoordinates(~x=5, ~y=6)
 addCoordinates(~y=6, ~x=5)     // 임의의 순서로 명시 가능하다.
 // 선언의 ~x 부분은 함수가 x로 레이블된 인자를 허용하고 함수 내에서 동일한 이름으로 참조할 수 있음을 의미한다.
 // 간결성을 위해 다른 이름으로 함수 본문 내부의 인수를 참조할 수도 있다.
 let setColor = (color) => Js.log(color)
 let startAt = (r1, r2) => Js.log(r1)
 let drawCircle = (~radius as r, ~color as c) => {
     setColor(c)
     startAt(r, r)
 }
 drawCircle(~radius=10, ~color="red")
 // 타입을 구체적으로 명시할 수도 있다.
 let drawCircle = (~radius as r: int, ~color as c: string) => {
     setColor(c)
     startAt(r, r)
 }


/* Optional Labeled Arguments
 * 레이블된 함수 인자를 ?를 사용해 선언함으로써 선택적으로 만들 수도 있다.
 * 그러면 함수 호출 시 해당 인자는 생략이 가능하다.
 */
 let drawCircle = (~color, ~radius=?, ()) => {
     setColor(color)
     switch radius {
         | None => startAt(1, 1)
         | Some(r_) => startAt(r_, r_)
     }
 }
 // radius는 표준 라이브러리인 option 타입으로 감싸지며, 기본값은 None이고 값이 주어지면 Some으로 래핑된다.
 // 타입 시스템을 위해선, 선택적 인자를 가질 때마다 그 뒤에 적어도 하나의 위치 인자(라벨이 지정되지 않은 필수인자)가 있는지 확인해야 한다.
 // 만약 없다면, 위의 코드처럼 더미 단위 () 인자를 추가하자.

 // 선택적 레이블된 인자를 가진 함수는 서명 및 타입주석에 대해 혼란을 야기할 수 있다.
 // 실제로 선택적 레이블된 인자의 타입은 어디서 함수를 호출하는지, 함수 본문 내부에서 사용하는지에 따라 다르게 보인다.
 // 함수 외부에서 실제 값은 전달되거나 완전히 없어지며, 함수 내부에서 인자는 항상 존재하나 선택적으로 값을 가진다.
 // 즉, 함수 타입을 작성하는지 또는 매개변수 타입 주석을 작성하는지에 따라 타입 서명이 달라지게 된다.
 // -> 함수 타입 작성의 경우 실제 값, 매개변수 타입 주석일 경우 option이 된다.
 // 이전 예제로 돌아가서 서명과 타입주석을 인자에 추가하면 다음과 같다.
 
 type color = string
 let drawCircle: (~color: color, ~radius: int=?, unit) => unit =
    (~color: color, ~radius: option<int>=?, ()) => {
        setColor(color)
        switch radius {
            | None => startAt(1, 1)
            | Some(r_) => startAt(r_, r_)
        }
    }
    /* 69번 줄에서 에러가 발생하여 주석처리합니다.
       This pattern matches values of type \"option/1028"<int>
       but a pattern was expected which matches values of type \"option/10"<int> */
 
 // 첫번째 줄은 함수 서명으로 인터페이스 파일에 정의되어 있다. (Signatures 참고)
 // 함수 서명은 외부세계와 상호작용하는 타입을 설명하므로 실제로 호출될 때 int를 예상하기 때문에 radius의 타입은 int가 된다.
 // 두번째 줄은 함수 본문에서 사용할 때 인자 타입을 기억하는데 도움이 되도록 인자에 주석을 추가한 것이다. radius는 함수 내부에서 option<int>이다.
 // 선택적 레이블된 인자를 가지는 함수에 대한 서명을 작성하는 것이 힘들 때 위의 내용을 사용하자.

 // 때로는 값이 None인지 Some(a)인지 알지 못한채 값을 함수에 전달할 수 있다.
 let color = "red"
 let payloadRadius = Some(5)
 let result = 
    switch payloadRadius {
    | None => drawCircle(~color, ())
    | Some(r) => drawCircle(~color, ~radius=r, ())
    }
 // 위 코드를 더 짧게 간추릴 수 있다.
 let result = drawCircle(~color, ~radius=?payloadRadius, ())
 // "radius는 선택인자이며 값을 전달할 때 int여야하지만 전달하는 값이 None인지 Some(val)인지 알 수 없으므로 통과한다."를 의미한다.

 // 선택인자에 기본값을 적용할 수 있다. 이런 경우에는 option타입으로 래핑하지 않는다.
 let drawCircle = (~radius=1, ~color, ()) => {
     setColor(color)
     startAt(radius, radius)
 }


/* Recursive Functions
 * Rescript는 함수가 자체 내에서 재귀적으로 호출되는 것을 방지하는 정상적인 기본값을 선택한다.
 * 재귀함수는 let 뒤에 rec 키워드를 명시함으로써 만들 수 있다.
 */
 let rec neverTerminate = () => neverTerminate()
 // 함수를 재귀적으로 호출하는 것은 성능과 호출 스택에 좋지 않다.
 // 그러나 Rescript는 꼬리 재귀를 빠른 Javascript 루프로 똑똑하게 컴파일한다.
 // JavaScript로 컴파일된 코드를 살펴보길 바란다.
 let rec listHas = (list, item) =>
    switch list {
    | list{} => false
    | list{a, ...rest} => a === item || listHas(rest, item)
    }

 // 상호 재귀함수는 rec 키워드를 사용하여 단일 재귀함수처럼 시작한 다음 and를 통해 연결된다.
 let rec callSecond = () => callFirst()
 and callFirst = () => callSecond()


/* Uncurried Function
 * Rescript의 함수는 기본적으로 커리되며, 이는 컴파일된 JS 출력에서 Rescript가 제공하는 몇 안되는 패널티 중 하나이다.
 * 컴파일러는 가능한 한 커리를 제거하기 위해 최선을 다한다.
 * 하지만 특정 상황에서는 점표기법을 사용하여 언-커리를 보장할 수 있다. 
 */
 let add = (. x, y) => Js.log(x + y)
 add(. 1, 2)
 // 단일 unit ()인자를 갖는 함수가 커리를 호출해야 하는 경우 ignore()함수를 사용하면 된다.
 let echo = (. a) => a
 echo(. ignore())
 // 언-커리 함수의 타입을 명시할 경우 똑같이 점을 추가하면 된다.
 // 선언한 곳, 호출한 곳 모두 언-커리 주석(.)을 명시해야 한다.

 // 이 기능은 사소해 보이지만, 실제로는 주요 함수형 언어에서 가장 중요한 특징 중 하나이다.
 // JS 출력에서 커리 런타임에 대한 언급을 제거할 때 사용하면 좋다.


/* Tips & Tricks
 * 다음은 함수 구문에 대한 차트시트이다.
 */
 /**
  * Declaration
 */
 // 익명 함수 (anonymous function)
 (x, y) => 1
 // bind to a name
 let add = (x, y) => 1

 // labeled
 let add = (~first as x, ~second as y) => x + y
 // with punning sugar
 let add = (~first, ~second) => first + second

 // labeled with default value
 let add = (~first as x=1, ~second as y=2) => x + y
 // with punning
 let add = (~first=1, ~second=2) => first + second

 // optional
 // let add = (~first as x=?, ~second as y=?) => switch x {...}
 // with punning
 // let add = (~first=?, ~second=?) => switch first {...}

 /**
  * With Type Annotation
  */
  // anonymous function
  (x: int, y: int) : int => 1
  // bind to a name
  let add = (x: int, y: int) : int => 1

  // labeled
  let add = (~first as x: int, ~second as y: int) : int => x + y
  // with punning sugar
  let add = (~first:int, ~second:int) : int => first + second

  // labeled with default value
  let add = (~first as x: int=1, ~second as y: int=2) : int => x + y
  // with punning sugar
  let add = (~first: int=1, ~second: int=2) : int => first + second

  //optional
  // let add = (~first as x:option<int>=?, ~second as y:option<int>=?) : int => switch x {...}
  // with punning sugar
  // 호출자는 option<int>가 아닌 int를 전달한다.
  // 함수 내부에서 first와 second는 option<int>이다.
  // let add = (~first: option<int>=?, ~second: option<int>=?) : int => switch first {...}

 /**
  * Application
  */
  add(x, y)

  // labeled
  add(~first=1, ~second=2)
  // with punning sugar
  add(~first, ~second)

  // application with default value. Same as normal application
  add(~first=1, ~second=2)

  // explicit optional application
  add(~first=?Some(5), ~second=?Some(2))
  // with punning
  add(~first?, ~second?)

 /**
  * With Type Annotation
  */
  // labeled
  add(~first=1: int, ~second=2: int)
  // with punning sugar
  add(~first: int, ~second: int)

  //application with default value. Same as normal application
  add(~first=1: int, ~second=2: int)

  // explicit optional application
  add(~first=?Some(1): option<int>, ~second=?Some(2): option<int>)
  // no punning sugar when you want to type annotation

 /**
  * Standard Type Signature
  */
  // first are type, second are type, return type
  type add = (int, int) => int

  // labeled
  type add = (~first: int, ~second: int) => int

  // labeled
  type add = (~first: int=?, ~second: int=?, unit) => int
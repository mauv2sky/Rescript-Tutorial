/* Unboxed
 * 리스크립트에서 싱글 페이로드를 갖는 베리언트와 싱글 필드를 갖는 레코드를 살펴보자.
 */
 type name = Name(string)
 let studentName = Name("Joe")

 type greeting = {message: string}
 let hi = {message: "hello!"}
 // 자바스크립트 출력을 보면 studentName과 hi가 자바스크립트 객체로 컴파일된 것을 확인할 수 있다.
 // (배리언트와 레코드에 관한 내용은 해당 섹션을 참고하자.)
 // 성능이 중요하거나 특정 자바스크립트 인터롭 상황의 경우 리스크립트가 제공하는 unwrap(또는 unbox) 기능을 사용할 수 있다.
 // Unbox는 단일 생성자와 싱글 페이로드로 구성된 배리언트와 싱글 필드의 레코드가 JS로 변환될 때, 해당 객체의 래퍼를 벗겨낸다.
 // 즉 리스크립트의 unbox의 기능은 불필요한 객체 대신 변수로 변환한다.
 // 타입 선언 위에 @unboxed를 작성하면 된다.
 @unboxed
 type name1 = Name(string)
 let studentName = Name("Ivy")

 @unboxed
 type greeting1 = {message: string}
 let hi = {message: "hello!"}
 // 훨씬 깔끔해진 출력결과를 확인할 수 있다.


/* Usage
 * 싱글 페이로드가 있는 배리언트와 레코드가 필요한 이유는 무엇일까? 왜 그냥 페이로드를 넘기지 않는 것일까?
 * 다음은 배리언트에 대한 사용 예시이다.
 * 로컬/ 월드별 좌표계를 사용하는 게임이 있다고 가정하자.
 */
 type coordinates = {x: float, y: float}

 let renderDot = (coordinates) => {
     Js.log3("Pretend to draw at:", coordinates.x, coordinates.y)
 }

 let toWorldCoordinates = (localCoordinates) => {
     {
         x: localCoordinates.x +. 10.,
         y: localCoordinates.y +. 20.
     }
 }

 let playerLocalCoordinates = {x: 20.5, y: 30.5}

 renderDot(playerLocalCoordinates)
 // 이 코드는 뭔가 잘못되었다. renderDot은 전역 좌표를 기준으로 렌더링하는데 인자로 로컬 좌표가 전달되었다.
 // 코드를 수정해서 잘못된 좌표 타입이 전달되지 않도록 해보자.
 type coordinates1 = {x: float, y: float}
 @unboxed type localCoordinates1 = Local(coordinates1)
 @unboxed type worldCoordinates1 = World(coordinates1)

 let renderDot = (World(coordinates1)) => {
     Js.log3("Pretend to draw at:", coordinates1.x, coordinates1.y)
 }

 let toWorldCoordinates = (Local(coordinates1)) => {
     World({
         x: coordinates1.x +. 10.,
         y: coordinates1.y +. 20.
     })
 }

 let playerLocalCoordinates = Local({x: 20.5, y: 30.5})
 
 // renderDot(playerLocalCoordinates)는 에러가 발생한다.
 // 다음처럼 로컬좌표 타입을 월드좌표로 변환하는 과정을 강제시켜야 한다.
 renderDot(playerLocalCoordinates->toWorldCoordinates)

 // 이제 renderDot은 worldCoordinates만을 입력으로 받게 된다.
 // 배리언트 타입과 인자 구조분해를 조화롭게 사용함으로써 성능 저하없이 더 안전한 코드를 만들게 되었다.
 // unboxed 속성은 깔끔하고 배리언트 래퍼가 없는 JS 코드로 컴파일된 것을 확인할 수 있다.

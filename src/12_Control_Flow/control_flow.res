/* Control flow
 * Rescript는 if, else, 삼항 연산자, for 그리고 while을 제공한다.
 * Rescript는 또한 자체 섹션에서 다룰 유명한 패턴 매칭도 지원한다.
 */

/* If-Else 및 삼항
 * JavaScript와 달리 Rescript if는 표현식으로 if 내부의 내용을 평가한다.
 */
 let message = if isMorning {
     "Good morning!"
 } else {
     "Hello!"
 }
 // if-else의 최종 분기 else가 존재하지 않을 경우 else 안에 ()를 사용할 수도 있다.
 let displayMenu = () => Js.log("")
 
 if showMenu {
     displayMenu()
 }
 // 다음 코드는 위의 코드와 같은 기능을 한다.
 if showMenu {
     displayMenu()
 } else {
     ()
 }
 // 다음과 같이 작성하면 에러가 발생한다.
 // if result = if showMenu{ 1 + 2 }
 // 기본적으로 else 분기에는 암시적 unit 타입이 있고, if 분기에는 int 타입이 있다는 타입 에러가 발생한다.
 // 직관적으로 이것은 의미가 있다 : showMenu가 거짓이라면 결과값은 무엇일까?
 // Rescript는 삼항 연산을 제공하지만 가능하면 if-else 조건문을 사용하는 것이 좋다.
 // Rescript에는 패턴매칭으로 인해 조건이 필요한 코드의 모든 카테고리를 제거하므로 if-else와 삼항 연산이 다른 언어보다 적게 사용된다.
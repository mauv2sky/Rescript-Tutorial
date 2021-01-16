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

 
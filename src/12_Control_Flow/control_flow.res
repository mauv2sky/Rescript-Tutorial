/* Control flow
 * 리스크립트는 if-else, 삼항 연산자, for 그리고 while을 제공한다.
 */

/* If-Else 및 삼항
 * 자바스크립트와 달리 리스크립트의 if는 표현식으로 if 내부의 내용을 평가한다.
 */
 let isMorning = true
 let message = if isMorning {
     "Good morning!"
 } else {
     "Hello!"
 }
 
 let displayMenu = () => Js.log("")
 let showMenu = true
 if showMenu {
     displayMenu()
 }
 // if-else의 최종 분기 else가 존재하지 않을 경우 else 안에 ()를 사용할 수도 있다.
 // else는 암시적으로 unit 타입을 반환함을 알 수 있다.
 if showMenu {
     displayMenu()
 } else {
     ()
 }
 // 다음과 같이 작성하면 에러가 발생한다.
 // if result = if showMenu{ 1 + 2 }
 // 기본적으로 else 분기에는 암시적 unit 타입이 있고, if 분기에는 int 타입이 있다는 타입 에러가 발생한다.
 // 리스크립트는 삼항 연산을 제공하지만 가능하면 if-else 조건문을 사용하는 것이 좋다.
 // 리스크립트는 패턴매칭을 통해 조건이 필요한 코드의 모든 카테고리를 제거하므로, if-else와 삼항 연산이 다른 언어보다 적게 사용된다.


/* For Loops
 * for 루프는 시작 값에서 끝 값까지(또는 포함) 반복적인 연산을 수행한다.
 */
 for x in 1 to 3 {
     Js.log(x)
     Js.log(" ")
     // prints : 1 2 3
 }
 // downto를 사용하면 반대 방향으로 루프를 돌릴 수 있다.
 for x in 3 downto 1 {
     Js.log(x)
     Js.log(" ")
 }

 
/* While 루프
 * While 루프는 조건이 참인 동안 본문 코드블록을 반복 실행한다.
 */
 let num = ref(0)
 while num < ref(3) {
     Js.log(num)
     num := num.contents + 1
 }
 // 리스크립트에는 루프 탈출 키워드인 break가 존재하지 않는다.
 // 하지만 리스크립트에서 제공하는 mutable binding을 사용함으로써 루프를 탈출할 수 있다.
 let break = ref(false)

 while !break.contents {
     if Js.Math.random() > 0.3 {
         break := true
     } else {
         Js.log("Still running")
     }
 }

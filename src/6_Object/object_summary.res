/* Object
 * 리스크립트 객체는 레코드와 비슷하지만 다음과 같은 차이가 있다.
    - 타입선언이 불필요하다.
    - 레코드와 달리 구조적(structural)이고 더 다형적(polymorphic)이다.
    - 객체가 JS로부터 전달된 것이 아니면 변경할 수 없다.
    - 패턴 매칭(pattern matching)을 지원하지 않는다.
 * 리스크립트 레코드가 자바스크립트 객체로 깨끗하게 컴파일되긴 하나,
 * 자바스크립트 객체에 대한 에뮬레이션/바인딩에는 리스크립트 객체가 더 적합하다.
 */


/* Type Declaration
 * 레코드와 달리 타입선언을 선택적으로 할 수 있다.
 * 객체의 타입은 값에 의해 추론되기 때문에 타입선언이 필요하지 않다.
 * 그렇지만 객체의 타입선언은 다음과 같이 할 수 있다.
 * 레코드의 타입선언 문법과 비슷해 보이지만 필드의 이름이 "로 감싸져 있다.
 */
 type person = {
     "age": int,
     "name": string
 }


/* Creation
 * 새로운 객체를 만드는 방법은 아래의 코드 me와 같다.
 * 위에서 언급했듯이, 레코드와는 달리 객체에서는 필드와 일치하는 타입선언을 찾으려고 하지 않고 값의 타입으로 인해 추정된다.
 * 이 기능은 편리하지만, 다음의 other 코드는 오류없이 통과하게 된다.
 */
 let me = {
     "age": 5,
     "name": "Baby ReScript"
 }

 let other = {
     "age": "hello!"
     // age는 string이 아니지만 에러 발생 안함.
 }
 // 타입검사는 person 타입과 other를 비교하지 않기 때문에 이런 현상이 발생한다.
 // 만약 명시적으로 객체의 타입을 명시하고 싶다면 타입주석을 사용하면 된다.
 /*     let another: person = {
             "age": "hello!"
             // 에러가 발생한다.
        }
 */


/* Access
 * 레코드의 .점표기법과 다르게 []를 사용하여 객체 필드에 접근한다.
 */
 let age = me["age"]


/* Update
 * 객체는 자바스크립트로부터 오는 바인딩이 아닌 경우 업데이트를 허용하지 않는다.
 * 만약 수정이 되는 상황이라면 = 를 사용하면 된다.
 */
 type student = {
     @bs.set "age": int,
     @bs.set "name": string
 }
 @bs.module("./test.js") external student1 : student = "student1"

 student1["name"] = "Mary"
 Js.log(student1)

/* Object
 * Rescript object는 record와 비슷하지만 다음과 같은 차이가 있다.
    - 타입선언이 필요하지 않다.
    - record와 달리 구조적(structural)이고 더 다형적(polymorphic)이다.
    - JS에서 object를 제공하지 않는 한 업데이트를 지원하지 않는다.
    - 패턴 매칭(pattern matching)을 지원하지 않는다.
 * 비록 Rescript record는 깨끗한 자바스크립트 object로 컴파일되지만,
 * Rescript object는 자바스크립트 object에 대한 에뮬레이션/바인딩에 더 적합하다.
 */


/* Type Declaration
 * record와 달리 타입선언을 선택적으로 사용할 수 있다.
 * object의 타입은 값에 의해 추론되기 때문에 타입선언이 필요하지 않다.
 * 그래도 object의 타입선언은 다음과 같이 할 수 있다.
 * Record의 타입선언 문법과 비슷해 보이지만 필드의 이름이 "로 감싸져 있다.
 */
 type person = {
     "age": int,
     "name": string
 }


/* Creation
 * 새로운 object를 만드는 방법은 me와 같다.
 * 위에서 언급했듯이, record와는 달리 object에서는 필드와 일치하는 타입선언을 찾으려고 하지 않고 값의 타입으로 인해 추정된다.
 * 이 기능은 편리하지만, 다음의 other 코드는 오류없이 통과함을 보여준다.
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
 // 만약 명시적으로 object의 타입을 명시하고 싶다면 타입주석을 사용하면 된다.
 /*     let another: person = {
             "age": "hello!"
             // 에러가 발생한다.
        }
 */


/* Access
 * record의 점.표기법과 다르게 []를 사용하여 object 필드에 접근한다.
 */
 let age = me["age"]


/* Update
 * object는 자바스크립트로부터 오는 바인딩이 아닌 경우 업데이트를 허용하지 않는다.
 * 이 경우에는 = 를 사용한다.
 */
 type student = {
     @bs.set "age": int,
     @bs.set "name": string
 }
 @bs.module("./test.js") external student1 : student = "student1"

 student1["name"] = "Mary"
 Js.log(student1)
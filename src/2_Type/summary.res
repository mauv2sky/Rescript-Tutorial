/* 타입은 Rescript의 하이라이트라고 볼 수 있다. 타입 시스템의 특징은 아래와 같다.
 * 1. 강함 -- 타입은 다른 타입으로 변하지 않는다.
 *      자바스크립트에서는 코드가 실행될 때(런타임 시) 변수 타입이 변경될 수 있다.
 *      이런 상황은 읽기 또는 디버깅 시에 코드를 이해하는 것을 어렵게 한다.
 * 2. 정적 -- Rescript 타입은 컴파일 후 지워지고 런타임에는 존재하지 않으므로,
 *      타입으로 인해 성능이 저하되는 건 걱정하지 않아도 된다.
 *      런타임 중에는 타입 정보가 필요하지 않고, 컴파일 시간 동안 타입 오류를 보고해줌으로써
 *      더 빠르게 버그를 알고 수정할 수 있다.
 * 3. 안정적 -- 이 특징은 JS로 컴파일되는 다른 타입 언어와 비교할 때 가장 큰 차별화된 요소이다.
 *      대부분의 타입 시스템은 값의 타입을 추측하고 때로는 편집기에 잘못된 타입을 표시하지만,
 *      Rescript의 타입 시스템은 결코 잘못 되지 않는다.
 *      부정확한 타입 시스템이 기대 불일치로 인해 위험해질 수 있다고 믿기 때문이다.
 * 4. 빠름 -- 많은 개발자가 프로젝트 빌드 시간 중 타입 검사에 들어가는 시간을 과소평가 한다.
 *      Rescript의 타입 검사기는 가장 빠른 것 중 하나이다.
 * 5. 추론 -- 타입에 대한 정보를 적을 필요가 없다. Rescript는 값을 추론할 수 있다.
 *      부정확하지 않고, 타입 어노테이션 없이 프로그램의 타입을 추론할 수 있다.
 */



/* 추론
 * 값을 통해 추론한다. 아래의 add 함수가 두 개의 int를 덧셈 연산하는 것을 통해
 * 반환값이 int임을 추론할 수 있다.
 */
let score = 10
let add = (a, b) => a + b


/* 타입 주석
 * 선택적으로 유형을 적어 값에 주석을 달 수도 있다.
 * 만약 타입 주석이 Rescript가 추론한 타입과 일치하지 않으면, Rescript는 컴파일 시간에 오류를 보고한다.
 * 다른 언어와 다르게, 타입 주석이 정확하다고 가정하지 않는다.
 * 표현식을 괄호로 묶고 주석을 달 수도 있다. 아래와 같이 다양한 타입 주석 방법이 있다.
 */
 let myInt = 5
 let myInt : int = 5
 let myInt = (5 : int) + (4 : int)
 let add = (x : int, y : int) : int => x + y



/* 타입 별칭 */
type scoreType = int
let x : scoreType = 10



/* 타입 매개 변수
 * 타입은 다른 언어의 제네릭과 유사한 매개 변수를 허용한다.
 * 중복을 없애기 위해 고안되었으며, 매개변수 이름 앞에 ' 를 기입하면 된다.
 * 타입 시스템은 (int, int, int)와 같은 타입 선언이 필요 없다.
 * 타입 매개 변수를 허용하지 않은 경우, arrayOfString, arrayOfInt 등의 표준 라이브러리의 타입을 정의해야 한다.
 */
 // 일반 표기 방식
 type intCoordinates = (int, int, int)
 type floatCoordinates = (float, float, float)

 let a: intCoordinates = (10, 20, 20)
 let b: floatCoordinates = (10.5, 20.5, 20.5)

 // Rescript 타입 시스템
 type coordinates<'a> = ('a, 'a, 'a)

 let a: coordinates<int> = (10, 20, 20)
 let b: coordinates<float> = (10.5, 20.5, 20.5)

 // 유형은 많은 인수를 이용해 구성 가능하다.
 type result<'a, 'b> =
    | Ok('a)
    | Error('b)
 
 type myPayload = {data : string}

 type myPayloadResults<'errorType> = array<result<myPayload, 'errorType>>

 let payloadResults : myPayloadResults<string> = [
     Ok({data : "hi"}),
     Ok({data : "bye"}),
     Error("Something wrong happened!")
 ]



/* 재귀 타입
 * 함수와 마찬가지로 rec을 사용하여 자신을 참조할 수 있다.
 */
 type rec person = {
     name : string,
     friends : array<person>
 }



/* 상호 재귀 타입
 * 타입을 and를 통해 상호재귀적일 수도 있다.
 */
 type rec student = {taughtBy : teacher}
 and teacher = {students : array<student>}



/* 타입 탈출 해치
 * Rescript의 타입 시스템은 강력하며 암시적 타입 캐스팅, 값의 타입을 무작위로 추측하는 것과 같은
 * 위험하고 안전하지 않은 작업을 허용하지 않는다.
 * 그러나 실용주의에 따라 타입 시스템에 거짓말 할 수 있는 단일 탈출 해치를 노출할 수 있다.
 * 이 기능은 기존의 지나치게 동적인 JS코드로 작업할 때 세련되게 사용하되, 절대 남용해선 안된다.
 */
 external convertToFloat : int => float = "%identity"
 let age = 10
 let gpa = 2.1 +. convertToFloat(age)
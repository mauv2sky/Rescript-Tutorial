/* 'let binding'은 '변수 선언'이라고 할 수 있다.*/
let greeting = "hello!"
let score = 10
let newscore = 10 + score



/* Block Scope
 * 바인딩의 유효범위는 {}이며, 암시적으로 범위의 마지막 줄의 값이 반환된다.
 */
let message = {
    let part1 = "hello"
    let part2 = "world"
    part1 ++ " " ++ part2
}
// 여기서 part1과 part2 참조 못함



/* Design Decisions
 * Rescript의 if, while 구문 및 함수는 모두 동일한 블록 스코프 방식이다.
 */
let displayGreeting = true
if displayGreeting {
    let message = "Enjoying the docs so far?"
    Js.log(message)
}
// 여기서 message 참조 못함



/* Binding Are Immutable
 * let 바인딩은 불변하며, 즉 변경이 불가능하다.
 * 이는 타입 시스템이 다른 언어보다 훨씬 더 많은 것을 추론하고 최적화하는데 도움이 된다는 것을 뜻한다.
 */



/* Binding Shadowing
 * First Example : JavaScript pattern
 * var result = 0;
 * result = calculate(result);
 * result = calculateSomeMore(result);
 * 위 코드를 아래와 같이 작성할 수 도 있다.
 * Second Example : JavaScript pattern
 * var result1 = 0;
 * var result2 = calculate(result1);
 * var result3 = calculateSomeMore(result2);
 * 위의 두번 째 예시처럼, Rescript는 같은 이름으로 let 바인딩을 재사용하면 이전의 let 바인딩은 같은 이름의 바인딩에 의해 가려진다.
 * 즉, 초기에 let 바인딩된 값은 변경되지 않으며, 바인딩을 참조할 때는 위에 가장 가까운 바인딩을 참조하는 것을 알 수 있다.
 * 바인딩된 값을 정말 변경하고 싶다면, Rescript의 mutation 기능을 참고하면 된다. (https://rescript-lang.org/docs/manual/latest/mutation)
 * mutation은 많은 코드를 변경하고 조금 무거운 기능이다.
 */
 let result = 0
 let result = 1 + result
 let result = 2 + result
 // 추천하는 방법은 아니나 아래의 코드도 유효하다.
 let result = "hello"
 Js.log(result) // "hello" 출력
 let result = 1
 Js.log(result) // 1 출력



 /* Private let bindings
  * 모듈 시스템에서는 기본적으로 모든 것이 public하다.
  * 어떤 값을 숨길 수 있는 유일한 방법은 public한 필드와 private한 필드를 나누어 별도의 모듈 선언을 통해 바인딩하는 것이었다.
  * 7.2.버전 릴리즈에 Private let 바인딩을 도입한 이후 별도의 필드를 나누지 않고도 간편하게 바인딩 할 수 있게 되었다.
  * %private 키워드를 통해 직접 private 필드를 설정할 수 있다.
  * %private는 파일 수준 모듈에도 적용 가능하기 때문에 특정 필드를 숨기기 위한 별도의 인터페이스 파일을 만들 필요가 없다.
  * 하지만, 인터페이스 파일 분리(Rescript Signature 참고)는 보다 나은 성능을 나타내고, 별도의 컴파일 유닛과 문서화에 적합하기 때문에 권장되는 방식이다.
  * %private는 다음과 같은 시나리오에 적합하다.
  *     - 코드 제너레이터는 일부의 숨기고 싶은 값들을 public 필드로 합성하는 데 어려워하며 많은 시간이 소요된다.
  *     - 프로토타입을 하는 동안엔 숨기고 싶은 값이 있어도 인터페이스 파일이 아직 안정적이지 않은 경우.
  */
  // 기능 도입 전
  module A : {
      let b : int
  } = {
      let a = 3
      let b = 4
  }
  // 기능 도입 후
  // %private 사용
  module A' = {
      %%private(let a = 3)
      let b = 4
  }

/* 'let binding'은 '변수 선언'이라고 할 수 있다.*/
let greeting = "hello!"
let score = 10
let newscore = 10 + score



/* Block Scope
 * 바인딩 범위는 {}
 * 범위의 마지막 줄이 암시적으로 반환된다.
 */
let message = {
    let part1 = "hello"
    let part2 = "world"
    part1 ++ " " ++ part2
}
// 여기서 part1과 part2 참조 못함



/* Design Decisions
 * Rescript의 if, while 및 함수는 모두 동일한 블록 스코프 메커니즘을 사용한다.
 */
let displayGreeting = true
if displayGreeting {
    let message = "Enjoying the docs so far?"
    Js.log(message)
}
// 여기서 message 참조 못함



/* Binding Are Immutable
 * let binding은 불변하다.
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
 * Rescript에서는 Second Ex처럼
 * 동일한 이름의 let binding을 재사용하면, 이전의 let binding은 가려진다.
 * 즉, 초기에 let binding된 값은 변경되지 않는다.
 * 바인딩을 참조할 때는 위에 가장 가까운 바인딩을 참조한다.
 * 값을 이동하거나 코드의 많은 부분을 변경할 경우엔, 조금 더 강한 mutation feature를 제공한다.
 * mutation feature : https://rescript-lang.org/docs/manual/latest/mutation
 */
 let result = 0
 let result = 1 + result
 let result = 2 + result
 // 추천하는 방법은 아니나 아래의 코드도 유효하다.
 let result = "hello"
 Js.log(result)
 let result = 1
 Js.log(result)



 /* Private let bindings
  * 모듈 시스템에서는 기본적으로 모두 public하지만,
  * 숨기고 싶은 값이 있을 경우엔 public한 필드와 private한 필드를
  * 별도의 시그니처를 사용해 let binding하는 방법밖에 없었다.
  * 7.2.버전 릴리즈에 도입된 Private let bindings를 통해 간편하게 바인딩 할 수 있다.
  * %private를 통해 직접적으로 private 필드를 설정할 수 있다.
  * %private는 파일 수준 모듈에도 적용된다.
  * 하지만, 시그니처를 제공하는 방법이 별도의 컴파일 유닛과 문서화에 적합해 권장된다.
  * %private는 다음과 같은 시나리오에 적합하다.
  * 코드 제너레이터는 일부의 숨기고 싶은 값들을 public 필드로 합성하기 위해선 어렵고 많은 시간이 소요된다.
  * 프로토타입을 하는 동안엔 숨기고 싶은 값이 있어도 인터페이스 파일이 아직 안정적이지 않다면,
  * %private가 빠르게 prototyping하도록 도와준다.
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
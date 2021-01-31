/* Async & Promise
 * 비동기 프로그래밍을 위한 Rescript의 기본 메커니즘은 JavaScript(콜백 및 약속)와 동일하다.
 * JavaScript로 깔끔하게 컴파일하고 무거운 커스텀 런타임을 피하고 싶기 때문이다.
 * 하지만, 향후에 코루틴과 유사한 기능을 도입할 계획이다.
 * 이런 이유로 Rescript는 키워드 async 및 await를 언어에 도입하는 것을 연기하고 있다.
 * Rescript의 (예정된) Promise API 바인딩 revamp + pipe로 인해 비동기 코드가 다른 것보다 좋게 보일 것이다.
 */


/* Promise
 * Rescript는 JavaScript promises를 기본적으로 지원한다.
 * 일반적으로 필요한 3가지 기능은 다음과 같다.
     - Js.Promise.resolve: 'a => Js.Promise.t('a)
     - Js.Promise.then_: ('a => Js.Promise.t('b),
         Js.Promise.t('a)) => Js.Promise.t('b)
     - Js.Promise.catch: (Js.Promise.error => Js.Promise.t('a),
         Js.Promise.t('a)) => Js.Promise.t('a)
 * 다음은 Rescript측에서 promise를 생성하기 위한 타입 서명이다.
 */
 Js.Promise.make :(
    (
        ~resolve: (. 'a) => unit,
        ~reject: (. exn) => unit
    ) => unit
 ) => Js.Promise.t<'a>
 // 이 타입 서명은 make가 2개의 명명된 인수인 resolve와 reject의 콜백을 취함을 의미한다.
 // 두 인수 모두 언-커리 콜백(점 포함)이다.
 // make는 생성된 promise를 반환한다.


/* Usage
 * pipe 연산자를 사용한다.
 */
 let myPromise = Js.Promise.make((~resolve, ~reject) => resolve(. 2))

 myPromise->Js.Promise.then_(Value => {
     Js.log(value)
     Js.Promise.resolve(value + 2)
 }, _)->Js.Promise.then_(value => {
     Js.log(value)
     Js.Promise.resolve(value + 3)
 }, _)->Js.Promise.catch(err => {
     Js.log2("Failure!!", err)
     Js.Promise.resolve(-2)
 }, _)
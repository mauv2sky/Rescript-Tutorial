/* String
 * Rescript의 문자열은 큰 따옴표("")를 사용해 표기한다.
 */
 let greeting = "Hello world"
 let multilineGreeting = "Hello
 world!"
 // 문자열끼리 연결하기 위해서는 ++를 사용한다.
 let greetings = "Hello " ++ "world!"


/* 문자열 보간
 * 문자열에만 허용되는 특별한 문법이 있다.
 *      여러줄의 문자열
 *      필요하지 않은 특수 문자 이스케이핑
 *      보간법 (Interpolation)
 *      적절한 유니코드 처리
 * 특수 문자를 이스케이프할 필요가 없다는 점을 제외하면 JS의 백틱 문자열(`) 보간과 같다.
 * 보간법을 사용할 때 바인딩된 값이 문자열이 아닐 경우 문자열로 변환해야 한다.
 * 보간법을 사용할 때 바인딩을 문자열로 암시적으로 변환하려면 j를 앞에 추가하면 된다.
 */
 let name = "Joe"
 let greeting = `Hello
 World
 👋
 ${name}
 `
 let age = 10
 let message = j`Today I am $age years old.`


/* 용법
 * API 문서(JS.string 부분)를 참조하면 Rescript와 유사함을 알 수 있다.
 * Rescript 문자열은 JS 문자열에 매핑되므로 두 표준 라이브러리에서 문자열 작업을 혼합 및 일치 시킬 수 있다.
 */


/* Tips $ Tricks
 * 비타입 언어의 경우 문자열의 의미를 오버로드하는 경우가 많다.
 * 이런 열악한 문자열 타입에 과부하가 걸릴수록 타입 시스템이 도움을 줄 수 있다.
 * Rescript는 간결하고 빠른, 유지 가능한 타입 및 자료구조를 제공한다.
 */


/* Char 
 * Rescript에는 단일 문자로 구성된 문자열 타입이 있다.
 * 하지만, char는 유니코드 또는 UTF-8을 지원하지 않으므로 권장되지 않는다.
 * string을 char로 변환하려면 "a".[0].Char 를,
 * char를 string으로 변환하려면 String.make(1,'a').
 */
 let firstLetterOfAlphabet = 'a'


/* 정규식 (Regular Expression)
 * Rescript 정규식은 JS에 상응하는 부분으로 깔끔하게 컴파일된다.
 * 정규표현식에는 Js.Re.t 타입이 있다.
 */
 let r = %re("/b/g")


/* Boolean
 * Rescript boolean에는 bool타입을 가지며 true 또는 false를 가진다.
    && : AND 연산자
    || : OR 연산자
    ! : NOT 연산자
    <=, >=, <, >
    == : 구조 같음을 판단하는 연산자. 자료구조를 자세히 비교한다. 유의해서 사용 필요
    === : 참조가 동일한지 판단하는 연산자. 얕은 비교를 한다
    != : 구조가 다름을 판단하는 연산자
    !== : 참조가 다름을 판단하는 연산자
 * ReScript의 true/false는 JavaScript의 true/false로 컴파일 된다.
 */
 let a = (1, 2) == (1, 2)
 let b = (1, 2) === (1, 2)
 let myTuple = (1, 2)
 let c = myTuple === myTuple


/* Integer
 * 32비트이며 필요한 경우 잘린다. +, -, *, / 등의 기본 연산자를 제공한다.
 * JS 숫자에 바인딩할 때는 긴 값일 경우 잘릴 수 있기 때문에 주의가 필요하다.
 * 대신 JS 숫자(날짜 등)를 float로 바인딩하면 된다.
 * 가독성을 위해서 .NET과 같은 숫자 리터럴 중간에 밑줄을 넣을 수도 있다.
 * 1_000_000 <= 밑줄은 세 자리마다가 아니라 숫자 내 어디에나 배치 가능하다.
 */



/* Floats
 * float 타입은 Integer와 다른 연산자를 요구한다. +., -., *., /.를 사용한다.
 */
 let floatExample = 0.5 +. 0.6


/* Unit
 * Unit타입에는 JS의 undefined로 컴파일되는 단일 값 ()가 존재한다.
 * 다양한 위치에서 플레이스홀더로 사용되는 더미 타입이다.
 * 실제로 이 타입을 보기 전까지는 필요하지 않을 것이다.
 */
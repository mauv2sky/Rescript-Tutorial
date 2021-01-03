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
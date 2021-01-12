/* Polymorphic Variant
 * 먼저 Polymorphic Variant(Poly Variant)의 몇 가지 주요한 특징을 살펴보자.
 *  - 구조적으로 타입이 지정된다.
 *    즉, 값으로 사용되는 명시적인 타입 선언이 필요하지 않으며 특정 모듈에 연결되지 않는다.
 *    컴파일러는 요청 시 타입을 추론하고, 타입 이름 대신 값을 통해 Polymorphic Variant를 비교한다.
 *  - 자바스크립트와 쉽게 상호운용되며, 일반적인 Variant와 다르게 명시적인 런타임 변환이 필요하지 않다.
 *  - 구조적 특성으로 인해 Polymorphic Variant 타입은 타입이 일치하지 않을 때 까다로운 타입 검사 오류를 발생할 수도 있다.
 */


/* Basics
 * 1. Poly Variant의 생성자는 일반적인 Variant와 달리 #로 시작한다.
 *    대괄호를 사용해 (닫힌: 아래에서 설명) 생성자 집합을 표현할 수 있다.
 */
 let myColor = #Red

 type color = [#Red | #Green | #Blue]

 // 2. 명시적인 타입 선언없이 주석에서 Poly Variant 타입을 사용할 수도 있다.
 let render = ( color: [#Red | #Green | #Blue]) => {
     switch(color) {
        | _ => Js.log("...")
     }
 }
 let color: [#Red] = #Red

 // 3. Poly Variant의 생성자 이름은 일반적인 Variant보다 덜 제한적이다. 대문자로 꼭 표기하지 않아도 된다.
 type users = [#admin | #moderator | #user]
 let admin = #admin
 // 드물게 하이픈이나 숫자와 같은 잘못된 식별자를 정의할 수도 있다.
 // \ 문자는 깔끔한 코드를 위해 향후 Rescript 버전에서 삭제된다. => #"1"
 type numbers = [#\"1" | #\"2"]
 let one = #\"1"
 let oneA = #\"1a"

 // 4. 생성자 인자는 앞서 Variant에서 배운 것과 동일하다.
 type account = [
     | #Anonymous
     | #Instargram(string)
     | #Facebook(string, int)
 ]
 let acc: account = #Instargram("Test")

 // 5. 다른 Poly Variant 타입 안에 Poly Variant 타입을 넣어 전체 생성자의 집합으로 사용 가능하다.
 type red = [#Ruby | #Redwood | #Rust]
 type blue = [#Sapphire | #Neon | #Navy]
 type allColor = [red | blue | #Papayawhip]
 let c: allColor = #Ruby

 // 6. 특정 Poly Variant 타입으로 정의된 생성자와 매칭하는 몇 가지 Pattern matching 문법이 있다.
 switch #Papayawhip {
     | #...blue => Js.log("This is a blue color")
     | #...red => Js.log("This is a red color")
     | other => Js.log2("Other color than red and blue: ", other)
 }
 // 위의 switch문을 자세히 풀어낸 코드이다.
 switch #Papayawhip {
     | #Sapphire | #Neon | #Navy => Js.log("This is a blue color.")
     | #Ruby | #Redwood | #Rust => Js.log("This is a red color.")
     | other => Js.log2("Other color than red and blue: ", other)
 }

 // 7. Poly Variant 타입은 기본적으로 비재귀적이나, rec 키워드를 통해 재귀를 허용할 수 있다.
 type rec markdown = [
     | #Text(string)
     | #Paragraph(markdown)
     | #Ul(array<markdown>)
 ]
 let content: markdown = #Paragraph(#Text("Hello World"))

 // 8. Poly Variant 타입에 어노테이션을 통해 상한 및 하한 제약 조건을 정의하는 방법이 있다.
 let basic: [#Red] = #Red  // #Red만 허용.
 let foreground: [> #Red] = #Green  // #Red를 포함하면 다른 값도 허용.
 let background: [< #Red | #Blue] = #Red  // #Red, #Blue외의 다른 값 허용 안함.


/* Polymorphic Variants are Structurally Typed
 * 위에서 봤듯이, Polymorphic Variant는 값을 사용하기 위한 명시적인 타입선언이 필요없다.
 * 컴파일러는 모든 값을 독립적인 타입으로 취급하고 이를 특정 모듈에 연결시키지 않는다.
 * 따라서 정의된 타입 이름이 아닌 구조별로 다른 Poly Variant 타입을 비교한다.
 */
 let color = #Red   // [> #Red]로 추론
 
 // 값이 생성자 집합의 일부인 한, 서로 다른 모듈 및 타입의 Variant값을 상호교환적으로 사용할 수 있다.
 type rgb = [#Red | #Green | #Blue]
 let colors: array<rgb> = [#Red]
 // other은 array<[> #Green]>의 타입으로 추론된다.
 // let other = [#Green]  // error 발생.
 // 타입 검사기는 other이 array<rgb> 타입 어노테이션을 하지 않은 것에 대해 신경쓰지 않는다.
 // other의 타입이 첫번째 생성자와 일치하면, 타입 검사기는 colors와 other의 구조적 타입이 하나의 Poly Variant로 통합될 수 있는지 확인한다.
 // 만약 매치되지 않으면 Belt.Array.concat 호출에서 오류가 발생하게 된다.
 
 // 이 동작은 잘못된 소스 코드 위치에서 혼란스러운 타입 에러를 유발할 수 있다.
 // 아래의 코드를 보면, 실제로 other에서 타이핑 실수로 인해 에러가 난 것이지만 concat에러로 나타난다.
 // let other = [#GreeN]
 // let all = Belt.Array.concat(colors, other)


/* JavaScript Output
 * Poly Variant는 공유되는 자료구조이기 때문에, JS로 바인딩하는데 매우 유용하다.
 * 값은 다음과 같은 JS 출력으로 컴파일된다.
    - Variant 값이 인자가 없는 생성자인 경우 => 동일한 이름의 문자열로 컴파일된다.
    - 인자가 있는 생성자인 경우 => 생성자의 이름은 NAME 필드의 값으로,
      인자는 VAR 필드의 값으로 전환되며 최종적으로 객체로 컴파일된다.
 */
 let capitalized = "#Hello"
 let lowercased = "#goodbye"
 let err = #error("oops!")
 let num = #\"1"

 // Poly Variant는 JavaScript의 함수에 바인딩하는데 중요한 역할을 한다.
 // 예를 들어, Intl.NumberFormat을 바인딩하고 싶다고 가정하고
 // 사용자가 유효한 로케일만 전달하도록 하려면 다음과 같이 외부 바인딩을 정의하고 사용할 수 있다.
 /*
    // IntlNumberFormat.res
    type t
    @bs.val
    external make: ([#\"de-DE" | #\"en-GB" | #\"en-US"]) => t = "Intl.NumberFormat"

    // MyApp.res
    let intl = IntlNumberFormat.make(#\"de_DE")
 */


/* Lower/ Upper Bound Constraints
 * 위에 간단히 설명한 상한과 하한 제약조건에 대한 내용에 대한 개념을 다시 짚고 넘어가도록 하자.
    - Closed ([)
        가장 단순하고 실용적인 Poly Variant 정의로 일반적인 Variant와 마찬가지로 정확한 생성자 집합을 정의한다.
        생성자 집합에 정의된 생성자 중 하나만 허용한다.
        다형성 방식으로 확장할 수 있는 타입을 정의하려는 경우에는 아래의 상한, 하한 구문을 사용하면 된다.
        //  type rgb = [ #Red | #Green | #Blue ]
        //  let color: rgb = #Green

    - Lower Bound ([>)
        하한은 Poly Variant 타입이 인식하는 최소 생성자 집합을 정의한다.
        즉, 생성자 집합에 정의된 생성자를 포함하기만 하면 추가 값을 허용한다.
        확장 가능한 특징이 있어 '개방형 Poly Variant 타입'이라고 부른다.
        //  type basicBlueTone<'a> = [> #Blue | #DeepBlue | #LightBlue]
        //  type color = basicBlueTone<[#Blue | #DeepBlue | #LightBlue | #Purple]>
        //  let color: color = #Purple
        //  type notWorking = basicBlueTone<[#Purple]>  // 최소한의 생성자를 갖추지 않아 에러.

    - Upper Bound ([<)
        상한은 하한과 반대로 작동한다. 확장 타입은 상한 제약에 명시된 생성자만 사용할 수 있다.
        // type validRed<'a> = [< #Fire | #Crimson | #Ash] as 'a
        // type myReds = validRed<[#Ash]>
        // type notWorking = validRed<[#Purple]>    // 상한 제약에 벗어났기 때문에 에러.
 */


/* Variant vs Polymorphic Variant
 * Poly Variant가 Variant보다 우월하다고 느껴질 수도 있으나, 이 둘은 시나리오에 따라 다르게 사용된다.
    - Variant는 항상 특정 모듈에 연결된 타입 정의와 함께 제공되기 때문에 API에 대해 더 나은 캡슐화를 허용한다.
    - Variant는 개념적으로 이해하기 쉽고 코드를 쉽게 리팩토링하고 더 나은 철저한 패턴 매칭을 제공한다.
    - Variant는 재귀 타입 정의에서 더 나은 타입 에러 메시지를 제공한다.
    - Poly Variant는 JS에서 문자열을 표현하는 데 유용하며 다양한 타입 구성 전략을 허용한다. 타입 선언이 비필수적이다.
 * 대부분의 시나리오에서, 특히 일반 Rescript 코드를 작성할 때 Variant를 사용하는 것이 좋다.
 * 비용이 0인 interop 바인딩을 작성하거나 깨끗한 JS 출력을 생성하려는 경우 Poly Variant가 종종 더 나은 선택이 된다.
 */
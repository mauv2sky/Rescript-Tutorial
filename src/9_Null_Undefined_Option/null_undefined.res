/* Null, Undefined and Option
 * Rescript는 null과 undefined 개념이 존재하지 않는다.
 * 이 특징은 전 범위에서 발생되는 null, undefined 버그가 발생하지 않음을 의미한다.
 * 더 이상 'undefined is not a function' 이나 'cannot access someAttribute of undefined!'를 걱정하지 않아도 된다.
 * 하지만, 잠재적으로 존재하지 않는 값에 대한 개념은 유용하며 이 값들은 Rescript 내에서 안전한 상태로 존재하므로 알아둘 필요가 있다.
 */
 type option<'a> = None | Some('a)
 // option 타입으로 값을 감싸 값의 존재 유무를 나타낼 수 있다.
 // 옵션 타입의 값이 None(undefined)이거나 Some에 래핑된 실제 값임을 의미한다.

 let licenseNumber = 5
 // 정상적인 값에 'null일 수 있음'의 개념을 적용하려면, 이 변수를 감싸 option 타입으로 변환해야 한다.
 // 좀 더 설명이 되는 예시를 위해 아래와 같은 조건을 제시할 수 있다. 
 let personHasCar = true // or false
 let licenseNumber' = 
    if personHasCar {
        Some(5)
    } else {
        None
    }

 // 나중에 다른 코드가 위의 값을 받으면 Pattern matching을 통해 두 경우를 모두 처리해야 한다.
 switch licenseNumber' {
 | None => 
    Js.log("The person doesn't have a car")
 | Some(number) => 
    Js.log("The person's license number is " ++ Js.Int.toString(number))
 }
 // 평범한 숫자를 option 타입으로 바꾸고 None을 처리하도록 강제함으로써
 // 개념적 null 값을 잘못 처리하거나, 잊을 가능성을 효과적으로 제거할 수 있다.
 // 순수한 Rescript 프로그램에는 null 오류가 발생하지 않는다.


/* Interoperate with JavaScript undefined and null
 * 예를들어 undefined로 생각되는 JS string이 있을 경우, 그 값을 option<string> 타입으로 정의하면 된다.
 * 마찬가지로, Some(5)나 None 값을 JS단으로 보낸다면 제대로 해석할 것이라 예상한다.
 */
 let x = Some(5)  // 5로 컴파일
 let y = None     // undefined로 컴파일

 // 주의할 점 1
 // Rescript에서는 option을 구성할 수 있기 때문에, option에서 undefined로 변환되는 것은 완벽하지 않다.
 let x = Some(Some(Some(5)))    // 5로 컴파일
 let y = Some(None)             // Caml_option.some(undefined)로 컴파일 ???
 // y가 JS에서 undefined로 컴파일되지 않는 이유를 간단히 설명하면,
 // 다형적인 option 타입을 특별한 주석으로 타입을 명시하지 않으면 많은 작업들이 까다로워지기 때문이다.
 // 이해가 잘 가지 않더라도, 다음의 룰만 잘 지켜주면 문제 없다.
 //     - JS단으로 값을 넘길 때 절.대. option의 값을 중첩하지 말자. (ex. Some(Some(Some(5))))
 //     - JS단에서 넘어온 값에 절.대. option<'a>로 타입 주석을 작성하면 안된다. 항상 고정된 비다형성 타입을 주어야한다.

 // 주의할 점 2
 // JS의 값이 모두 null이거나 undefined일 경우, option<int>와 같은 값으로 입력할 수 없다.
 // Rescript의 option 타입은 None을 다룰 때 undefined or not null만을 확인하기 때문이다.
 // 이를 해결하기 위해 Js.Nullable 모듈을 이용하여 보다 정교한 null 및 undefined 도우미에 대한 엑세스를 제공한다.
 // 예를들어, null 또는 undefined가 될 수 있는 JS string을 전달 받았을 경우 다음과 같이 작성한다.
 @bs.module("MyConstant") external myId: Js.Nullable.t<string> = "myId"
 // 반대로, Rescript에서 nullable 문자열을 생성할 경우에는 다음과 같이 작성한다.
 @bs.module("MyIdValidator") external validate: Js.Nullable.t<string> => bool = "validate"
 let personId: Js.Nullable.t<string> = Js.Nullable.return("abc123")
 let result = validate(personId)
 // return 부분은 문자열을 nullable 문자열로 래핑하여
 // 타입 시스템이 이 값을 전달할 때 단순한 문자열이 아니라 null 또는 undefined한 문자열이라는 사실을 이해하고 추적하도록 한다.

 // option 변환
 // Js.Nullable.fromOption : option -> Js.Nullable.t로 변환된다.
 // Js.Nullable.toOption : Js.Nullable.t -> option으로 변환된다.
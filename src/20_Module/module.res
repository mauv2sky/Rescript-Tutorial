/* Module */

/* Basics
 * 모듈은 파일들을 묶어둔 작은 폴더와 유사하다.
 * type definitions(타입 선언), let binding, nested modules(중첩 모듈) 등을 포함한다.
 */

 /* Creation
  * module 키워드를 사용해 모듈을 생성할 수 있으며, 모듈의 이름은 반드시 대문자로 시작해야 한다.
  * .res 파일에 넣을 수 있는 무엇이든 모듈 정의 블록{}에 포함시킬 수 있다.
  */
  module School = {
      type profession = Teacher | Director

      let person1 = Teacher
      let getProfession = (person) =>
        switch person {
            | Teacher => "A teacher"
            | Director => "A director"
        }
  }
  // 모듈의 내용(타입 포함)은 .점 표기법을 사용하여 레코드와 유사하게 액세스 할 수 있다.
  // 이는 네임스페이스에서 모듈의 유용함을 나타낸다.
  let anotherPerson: School.profession = School.Teacher
  Js.log(School.getProfession(anotherPerson))
  // 중첩 모듈도 동작한다.
  module MyModule = {
      module NestedModule = {
          let message = "hello"
      }
  }
  let message = MyModule.NestedModule.message

 /* opening a module
  * 모듈 내의 값과 타입을 지속적으로 참조하는 것은 지루할 수 있다.
  * 대신에, 모듈을 'open'함으로써 모듈의 이름을 항상 앞에 명시하지 않고도 내용을 참조할 수 있다.
  */
  let p = School.getProfession(School.person1)
  // 이제 이렇게 작성해보자
  open School
  let p = getProfession(person1)
  // School 모듈의 내용을 범위 내에서 바로 사용할 수 있다(파일에 복사되는 것은 아니다).
  // 따라서 profession, getProfession 및 person1을 School 명시 없이 사용 가능하다.
  // open을 드물게 사용하면 편리하지만, 그렇지 않을 경우 값의 출처를 알기 힘들게 된다.
  // 일반적으로 open은 로컬 범위에서 사용하는 것을 권장한다.
  let p = {
      open School
      getProfession(person1)
  }
  // 여기에서는 School의 내용을 바로 사용할 수 없다.

 /* Extending modules
  * 모듈 내에서 include를 사용하면 모듈의 내용이 다른 모듈로 정적 확장되므로, '혼합' 또는 '상속'을 가능하게 한다.
  * 컴파일러 수준의 복사/ 붙여넣기와 동일하므로 include를 사용하는 것을 매우 권장하지 않는다.
  * 최후의 수단으로 사용하자.
  */
  module BaseComponent = {
      let defaultGreeting = "Hello"
      let getAudience = (~excited) => excited ? "world!" : "world"
  }
  module ActualComponent = {
      include BaseComponent
      let defaultGreeting = "Hey"
      let render = () => defaultGreeting ++ " " ++ getAudience(~excited=true)
  }
  // open과 include는 정말 다른 것이다!
  // open은 모듈의 내용을 현재 범위로 가져오기 때문에 매번 모듈 이름과 함께 값을 참조하지 않아도 된다.
  // include는 모듈의 정의를 정적으로 복사한 다음 open도 수행한다.
  // 모듈의 내용을 해당 파일에 복사하느냐 아니냐의 차이가 있다.

 /* Every .res file is a module
  * 모든 Rescript 파일은 대문자로 된 파일 이름과 동일한 이름의 모듈로 컴파일된다.
  * React.res 파일은 암시적으로 React모듈을 형성하며 다른 소스파일에서 볼 수 있다.
  * ReScript 파일 이름은 일반적으로 대소문자를 구분하여 모듈 이름과 일치시켜야 한다.
  * 대문자가 아닌 파일 이름은 유효하지 않지만 암시적으로 대문자 모듈 이름으로 변환된다.
  * 즉 file.res 파일은 File 모듈로 컴파일된다.
  * 컴파일러의 일을 조금이라도 덜어주기 위해 모듈 파일 이름을 대문자로 사용하는 것이 관례다.
  */


/* Signatures
 * 모듈의 타입을 'signature(서명)'라고 하며 명시적으로 작성할 수 있다.
 * 모듈이 .res(실행)파일과 같다면, 모듈의 signature은 .resi(인터페이스)파일과 같다.
 */
 /* Creation
  * signature을 생성하려면 module type 키워드를 사용하면 된다. 이름은 반드시 대문자로 시작한다.
  * .resi파일에 넣을 수 있는 무엇이든 signature 정의 블록{} 안에 넣을 수 있다.
  */
  module type EstablishmentType = {
      type profession
      let getProfession: profession => string
  }
  // 서명은 모듈과 서명이 일치하기 위해 충족해야 하는 요구사항 목록을 정의하고 있다.
  // 요구사항 형식은 다음과 같다.
  //    - let x: int는 int 타입을 가진 x라는 이름의 let 바인딩이 필요하다.
  //    - type t = someType에서 타입 필드 t와 someType은 동일해야 한다.
  //    - type t는 타입 필드 t를 요구하지만 실제로는 t에 대한 구체적인 타입 요구사항을 부과하지는 않는다.
  //        관계를 설명하기 위해 서명의 다른 항목에 t를 사용한다. e.g. let makePair: t => (t, t)
  //        하지만 예를들어 t가 int라고 가정할 수는 없다.
  //        이것은 우리에게 강력하고 뛰어난 추상화 능력을 제공한다.
  // 다양한 종류의 타입 항목을 설명하려면 위 예시의 모듈이 필요한 EstablishmentType 서명을 고려해보자.
  //    - profession이라는 타입을 선언
  //    - profession 타입의 값을 받아 문자열으로 반환하는 함수를 반드시 포함해야 한다.
  // EstablishmentType 타입의 모듈은 위의 School 모듈처럼 서명이 선언한 것보다 더 많은 필드를 포함할 수 있다.
  // (EstablishmentType 타입을 할당하도록 선택한 경우. 그렇지 않으면 School은 모든 필드를 노출함)
  // 이것은 효과적으로 person1 필드를 강제 구현 세부 사항으로 만든다.
  // 외부인은 서명에 포함이 되어있지않아 엑세스를 할 수 없다. 서명은 다른 사람이 엑세스 하는 것을 제한하는 역할을 한다.
  // EstablishmentType.profession은 추상적으며 구제척인 타입을 가지지 않는다.
  // 동일한 인터페이스에서 많은 모듈을 맞춰보는 데 유용한 기능이다.
  module Company: EstablishmentType = {
    type profession = CEO | Designer | Engineer 

    let getProfession = (person) => {
        switch person {
          | CEO => "A CEO"
          | Designer => "A designer"
          | Engineer => "A engineer"
        }
    }  
  }
  // 다른 사람이 의존할 수 없는 구현 세부 사항으로 기본 타입을 숨기는 것도 유용하다.
  // Company.profession 타입이 무엇인지 물어보면 variant를 노출시키는 것 대신 "Company.profession이야"라고만 알려준다.

 /* Extending module signatures
  * 모듈 자체와 같이, 모듈 서명은 include를 사용하는 다른 모듈 서명에 의해 확장될 수도 있다.
  */
  module type BaseComponent = {
      let defaultGreeting: string
      let getAudience: (~excited: bool) => string
  }
  module type ActualComponent = {
      include BaseComponent
      let render: unit => string
  }
  // BaseComponent는 실제 모듈 자체가 아닌 모듈 타입이다!
  // 정의된 모듈 타입이 없는 경우, include(모듈 타입의 실제 모듈이름)를 사용하여 실제 모듈에서 모듈 타입을 추출할 수 있다.
  // 예를 들어 List 모듈 타입을 정의하지 않는 표준 라이브러리로부터 모듈을 확장할 수 있다.
  module type MyList = {
      include (module type of List)
      let myListFun: list<'a> => list<'a>
  }

 /* Every .resi file is a signature
  * React.res 파일이 React 모듈을 암시적으로 정의하는 방법과 유사하게
  * React.resi 파일은 React에 대한 서명을 암시적으로 정의한다.
  * React.resi가 제공되지 않으면 React.res의 서명은 기본적으로 모듈의 모든 필드를 노출한다.
  * 실행 파일이 포함되어 있지 않기 때문에 생태계에서 .resi파일을 사용하여 해당 모듈의 공용 API도 문서화한다.
  * (React.res, React.resi 파일 참고)
  */


/* Module Functions (Functors)
 * 모듈은 함수를 통해서 전달될 수 있다. 파일을 first-item으로 전달하는 것과 같다.
 * 그러나 모듈은 다른 일반적인 개념과는 다른 언어 "계층"에 있으므로 일반함수에 전달할 수 없다.
 * 대신 "Functor"라는 특수함수에 전달할 수 있다.
 * Functor를 정의하고 사용하는 구문은 일반 함수를 정의하고 사용하는 구문과 매우 유사하다.
 * 주요 차이점은 다음과 같다.
    - Functor는 let 대신 module 키워드를 사용한다.
    - Functor는 모듈을 인수로 취하고 모듈을 반환한다.
    - Functor에는 주석 처리 인수가 필요하다.
    - Functor는 모듈과 서명처럼 대문자로 시작해야 한다.
 * 다음 MakeSet은 Comparable 타입의 모듈을 가져와서 유사한 항목을 포함할 수 있는 새 세트를 반환하는 functor의 예이다.
 */
 module type Comparable = {
     type t
     let equal: (t, t) => bool
 }
 module MakeSet = (Item: Comparable) => {
     type backingType = list<Item.t>
     let empty = list{}
     let add = (currentSet: backingType, newItem: Item.t): backingType =>
        if List.exists(x => Item.equal(x, newItem), currentSet) {
            currentSet
        } else {
            list{
                newItem,
                ...currentSet
            }
        }
 }
 // 함수 애플리케이션 구문을 사용하여 Functor를 적용할 수 있다.
 // 이 경우 항목이 정수 쌍인 집합을 만든다.
 module IntPair = {
     type t = (int, int)
     let equal = ((x1: int, y1: int), (x2, y2)) => x1 == x2 && y1 == y2
     let create = (x, y) => (x, y)
 }
 // Inpair은 MakeSet에서 요구하는 Comparable 서명을 준수하게 된다.
 module SetOfIntPairs = MakeSet(IntPair)

 /* Module functions types
  * 모듈 타입처럼 functor 타입은 functor에 대해 가정할 수 있는 것을 제한하고 숨기는 역할도 수행한다.
  * functor 타입의 문법은 함수 타입의 문법과 일치하나, functor가 인수 및 반환값으로 받아들이는 모듈의 서명을 나타내기 위해 타입을 대문자로 표기한다.
  * 이전 MakeSet 예에서는 세트의 지원 타입을 노출하고 있다.
  * MakeSet functor 서명을 주면 기본 데이터 구조를 숨길 수 있다.
  */
  module type MakeSetType = (Item: Comparable) => {
      type backingType
      let empty: backingType
      let add: (backingType, Item.t) => backingType
  }
  module MakeSet1: MakeSetType = (Item: Comparable) => {
     type backingType = list<Item.t>
     let empty = list{}
     let add = (currentSet: backingType, newItem: Item.t): backingType =>
        if List.exists(x => Item.equal(x, newItem), currentSet) {
            currentSet
        } else {
            list{
                newItem,
                ...currentSet
            }
        }
  }


/* Tips & Tricks
 * 모듈과 functor는 나머지 언어(함수, let 바인딩, 자료구조 등)와는 다른 "계층"에 있다.
 * 예를들어, 튜플이나 레코드로 쉽게 전달할 수 없다.
 * 이를 현명하게 사용할 필요가 있다. 대부분 레코드나 함수만으로도 충분하다.
 */

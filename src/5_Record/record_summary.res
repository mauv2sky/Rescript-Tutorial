/* Record
 * 레코드는 자바스크립트의 객체와 유사하지만 "기본적으로 불변하다는 점, 확장이 불가능한 필드 사이즈"라는 차이가 있다.
 */


/* Type Declaration
 * 레코드는 필수적으로 타입 선언이 필요하다.
 */
 type person = {
     age : int,
     name : string
 }


/* Creation
 * 아래의 코드와 같은 방식으로 위에 생성된 person 레코드를 생성할 수 있다.
 * 새로운 레코드 값을 생성할 때, Rescript는 값의 모양과 알맞는 레코드 타입 선언을 찾는다.
 * 생성할 레코드 값의 위치로부터 위로 훑으며 알맞은 레코드 타입을 찾아낸다.
 * 만약 타입이 다른 파일 또는 모듈에 있는 경우에는 어떤 파일 또는 모듈인지 명확하게 명시해야 한다.
    // School.res
    type person = {age : int, name: string}
    // Example.res
    let me : School.person = {age: 20, name: "Big ReScript"}  // 선호되는 방식
    let me2 = {School.age:20, name: "Big ReScript"}
 */
 let me = {
     age : 5,
     name : "Big ReScript"
 }


/* Access
 * 익숙한 . 표기법을 사용해 Record 필드에 접근할 수 있다.
 */
 let name = me.name


/* Immutable Update
 * 이미 생성된 레코드로부터 새 레코드를 생성할 경우에는
 * 스프레드 연산자 ...를 사용하여 원본 레코드의 변경없이 새로운 레코드를 생성할 수 있다.
 * 레코드의 형태는 타입에 따라 고정되므로 스프레드 연산자를 사용해도 레코드에 새 필드를 추가할 수 없다.
 */
 let meNextYear = {...me, age: me.age + 1}


/* Mutable Update
 * 레코드 필드는 = 연산자를 사용하여 선택적으로 값을 변경할 수 있다.
 * 하지만 레코드 타입선언에서 mutable로 표시되지 않은 필드는 변경할 수 없다.
 */
 type person1 = {
     name: string,
     mutable age: int
 }

 let baby = {name: "Baby ReScript", age: 5}
 baby.age = baby.age + 1  // 'baby.age'는 6이 된다.


/* Tips & Tricks
 * 레코드 타입은 필드의 이름으로 찾을 수 있다.
 * 레코드는 'age 필드를 참조하는 함수가 age 필드를 가지는 모든 레코드 타입을 사용하고 싶다'고 할 수 없다.
 * getAge의 인자인 entity는 참조하는 age 필드와 가장 가까이 있는 레코드인 monster 타입이라고 추론한다.
 * 즉 같은 이름의 필드를 가진 여러 레코드가 있을 경우 해당 함수로부터 위로 가까이 있는 레코드의 필드를 참조하게 된다.
 */
 type human = {age: int, name: string}
 type monster = {age: int, hasTentacles: bool}

 let getAge = (entity) => entity.age

 // 다음 코드의 마지막 줄은 에러가 발생한다.
 // 타입 시스템은 me는 human 타입이고, getAge는 monster에 대해서만 동작한다고 오류를 발생시킬 것이다.
 // 이 문제를 해결하려면 리스크립트의 객체(objects)를 참고하자.
 let kraken = {age: 9999, hasTentacles: true}
 let me = {age: 5, name: "Baby Rescript"}

 let age = getAge(kraken)
 // getAge(me)  type error!


/* Design Decisions
 * 이전 섹션의 제한조건을 모두 읽었고 동적 타입 언어에 대한 배경지식도 가지고 있다면, 객체를 바로 사용하는 것 대신 레코드를 사용하는 이유가 무엇인지 궁금할 것 같다.
 * 레코드의 장점은 명시적인 타이핑이 필요하고 동일한 필드 이름을 가진 다른 레코드가 동일한 함수에 전달되도록 허용하지 않는 등의 특징을 가짐으로써 코드의 안정성을 보장한다는 것이다.
 * 객체 대신 레코드를 사용하는 이유는 다음과 같다.
    1. 만약 데이터 타입이 고정되어 있지 않다면, 앱은 잠재적으로 정적 타입 자료구조인 레코드와 (다음에 설명할)베리언트로 표현하기 위해 대부분의 시간을 보낸다.
    2. 레코드 타입은 단일의 명시적인 타입 선언을 찾아 해결하기 때문에 대응 타입(튜플과 같은 구조적 타입)보다 나은 에러 메시지를 제공한다.
        이는 리펙토링을 쉽게 할 수 있도록 도와주는 기능을 한다.
 */

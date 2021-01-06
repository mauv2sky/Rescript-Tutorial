/* Record
 * 레코드는 자바스크립트의 객체와 유사하지만,
 * [기본적으로 불변하다는 점과 확장이 불가능한 필드 사이즈]의 차이가 있다.
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
 * 이미 생성된 Record로부터 새 Record를 생성할 경우
 * ... 스프레드 연산자를 사용하여 원본 Record의 변경없이 새로운 Record를 생성할 수 있다.
 * Record의 형태는 타입에 따라 고정되므로 스프레드 연산자를 사용해도 레코드에 새 필드를 추가할 수 없다.
 */
 let meNextYear = {...me, age: me.age + 1}


/* Mutable Update
 * Record 필드는 = 연산자를 사용하여 선택적으로 변경할 수 있다.
 * 하지만 record 타입선언에서 mutable로 표시되지 않은 필드는 변경할 수 없다.
 */
 type person1 = {
     name: string,
     mutable age: int
 }

 let baby = {name: "Baby ReScript", age: 5}
 baby.age = baby.age + 1  // 'baby.age'는 6이 된다.


/* Tips & Tricks
 * 레코드 타입은 필드의 이름으로 찾을 수 있다.
 * 레코드의 경우, 'age 필드를 사용하는 함수가 age 필드가 있는 모든 Record 타입을 사용하고 싶다'고 할 수 없다.
 * 아래의 코드는 의도된대로 작동하지 않는다.
 */
 type human = {age: int, name: string}
 type monster = {age: int, hasTentacles: bool}

 let getAge = (entity) => entity.age

 // 대신, getAge의 매개변수인 entity가 age 필드와 가장 가까이 있는 레코드 타입인 monster라고 추론한다.
 // 다음 코드의 마지막 줄은 에러가 발생한다.
 // 타입 시스템은 me는 human 타입이고, getAge는 monster에 대해서만 동작한다고 오류를 발생시킬 것이다.
 // 만약 이를 해결하려면 Rescript objects를 참고하자.
 let kraken = {age: 9999, hasTentacles: true}
 let me = {age: 5, name: "Baby Rescript"}

 let age = getAge(kraken)
 // getAge(me)  type error!


/* Design Decisions
 * 당신이 이전 섹션의 제한조건을 모두 읽었고, 만약 동적 언어의 배경지식을 가지고 있다면
 * 아마 object를 바로 사용하는 것 대신에 record를 사용하는 이유가 궁금할 것 같다.
 * (Record는 명시적인 타이핑이 필요하고 동일한 필드 이름을 가진 다른 레코드가 동일한 함수에 전달되도록 허용하지 않는 등의 특징을 가지기 때문이다.)
 * object 사용 이전에 Record를 사용하는 이유는 다음과 같다.
    1. 데이터 형태는 실제로 고정되어 있는데, 만약 고정되어 있지 않다면 앱은 잠재적으로 Record와 (다음에 설명할)variant로 더 잘 표현하기 위해 대부분의 시간을 보낸다.
    2. record 타입은 단일 명시적인 타입 선언을 찾아 해결하기 때문에 대응 타입(튜플과 같은 구조적 타입)보다 나은 에러 메시지를 제공한다.
        이는 리펙토링을 쉽게 할 수 있도록 도와준다. 
 */
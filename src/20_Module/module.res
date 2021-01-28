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
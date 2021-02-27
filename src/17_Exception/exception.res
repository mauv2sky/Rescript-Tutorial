/* Exception
 * 익셉션(예외)은 이례적인 경우에 사용되는 특별한 종류의 배리언트로, 이를 남용해서는 안된다.
 */


/* Usage */
 let numInArray = (items) => true
 let getItem = (items) =>
   if numInArray(items) {
     1
   } else {
     raise(Not_found)
   }

 let result =
   try {
     getItem([1, 2, 3])
   } catch {
   | Not_found => 0 // Default value if getItem throws
   }
 // raise(Not_found)를 발생하면 Not_found에 맞는 예외처리를 하게된다.
 // getItem에서 직접 option<int>를 반환하고 try를 완전히 피할 수도 있다.
 // 함수에서 다른 반환값을 가져오는 동안 익셉션을 통해 직접 예외처리를 할 수 있다.
 let theItem = 1
 let myItems = list{1, 2, 3}
 switch List.find(i => i === theItem, myItems) {
 | item => Js.log(item)
 | exception Not_found => Js.log("No such item found!")
 }
 // 배리언트를 만드는 것처럼 자체 익셉션을 만들 수도 있다. (대문자로 표기해야한다)
 exception InputClosed(string)
 raise(InputClosed("The stream has closed!"))


/* Catching JS Exceptions
 * 자바스크립트의 익셉션과 리스크립트의 익셉션을 구별하기 위해
 * 리스크립트는 Js.Exn.Error(payload) 배리언트를 JS 예외용 네임스페이스로 지정한다.
 * 아래와 같은 방식으로 작성함으로써 JS단에서 발생하는 예외를 처리할 수 있다.
 */
 try {
   ()
 } catch {
 | Js.Exn.Error(obj) =>
   switch Js.Exn.message(obj) {
   | Some(m) => Js.log("Caught a JS exception! Message: " ++ m)
   | None => ()
   }
 }
 // obj는 Js.Exn.t 타입으로, 의도적으로 캡슐화하여 내부 내용을 알 수 없게 함으로써 불법 작업을 허용하지 않는다.
 // obj를 조작하려면 표준 라이브러리의 Js.Exn 모듈 helper를 사용하여 위의 코드처럼 작성하면 된다.
 

/* Raise a JS Exception
 * raise(MyException)은 Rescript 예외를 발생시킨다.
 * JavaScript 예외를 발생 시키려면 Js.Exn.raiseError를 사용하면 된다.
 */
 let myTest = () => {
     Js.Exn.raiseError("Hello!")
 }
 // JS에서 처리할 수 있다.
 %%raw(`
    try{
        myTest()
    } catch (e) {
        console.log(e.message)
    }
 `)


/* Catch ReScript Exceptions from JS
 * 이전 섹션은 생각보다 유용하지 않다. 
 * JS코드가 예외를 발생시키는 Rescript 코드와 함께 작동하도록 하기위해
 * 이제부터는 Rescript에서 실제로 JS예외를 발생시킬 필요가 없다.
 * Rescript 예외는 JS코드에서 사용할 수 있다.
 */
 exception BadArgument({myMessage: string})
 let myTest = () => {
     raise(BadArgument({myMessage: "Oops!"}))
 }
 // JS에 예외 정의없이 바로 적용된다.
 %%raw(`
    try{
        myTest()
    } catch (e) {
        console.log(e.myMessage)
        console.log(e.Error.stack)
    }
 `)
 // 위의 BadArgument 예외는 인라인 record 타입을 사용한다.
 // 우수한 구조 설계를 위해 예외를 {RE_EXN_ID, myMessage, Error}로 컴파일한다. (JS 컴파일 결과를 확인하자)
 // 예외가 위의 예외 대신 일반 위치 인수를 취했다면,
 // 단일 인수를 취하는 표준 라이브러리의 Invalid_argument("Oops!")처럼 인수는 대신 필드 _1로 JS로 컴파일된다.
 // 두 번째 위치 인수는 _2 등으로 컴파일된다. --- 이해 필요


/* Tips & Tricks
 * 일반적인 variant가 있으면 예외가 필요하지 않은 경우가 있다.
 * 컬렉션에서 item을 찾을 수 없을 때, option<item>(not found의 뜻)을 대신 반환해보자.
 * 같은 catch절에서 Rescript와 JS 예외를 모두 처리할 수 있다.
 */
 try {
   ()
 } catch {
 | Not_found => Js.log("RS Oops!") // catch a ReScript exception
 | Invalid_argument(_) => Js.log("RS Oops!!") // catch a second ReScript exception
 | Js.Exn.Error(obj) => Js.log("JS Oops!") // catch the JS exception
 }

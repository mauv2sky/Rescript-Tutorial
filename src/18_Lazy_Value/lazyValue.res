/* Lazy Value
 * 지연된 값은 첫 번째 실행의 결과를 기억해두었다가 다음 반복 실행 시 기억해둔 결과를 반환하는 지연된 계산을 수행한다.
 * 항상 같은 값을 반환하는 복잡한 프로시저의 함수와 표현식을 정의하는데 유용하다. 예를들어 다음의 상황에 적합하다.
 *   - 동일한 트리에서 값 비싼 DOM 순회를 반복해서 수행
 *   - 변경되지 않는 정적 파일 집합에서 파일 시스템 연산 수행
 *   - 항상 동일한 데이터를 반환하는 API 서버에 비용이 많이 드는 요청 수행
 * 지연된 값의 타입은 Lazy.t('a)이며, 여기서 'a는 계산 결과 값의 반환 타입이다.
 * 모든 기능은 전역으로 사용 가능한 Lazy 모듈로 캡슐화되어있다.
 */


/* 지연된 값 생성(Creating a lazy value)
 * 지연된 값은 언어의 일부로, lazy 키워드를 사용하여 표현식에서 지연된 값을 만들 수 있다.
 */
 // getFiles 함수가 파일시스템을 한 번만 읽기를 원한다면 lazy 키워드로 래핑하면된다.
 let getFiles = 
    lazy({
        Js.log("Reading dir")
        Node.Fs.readdirSync("./pages")
    })
 Lazy.force(getFiles)->Js.log   // 첫 번째 호출, 계산이 수행된다.
 Lazy.force(getFiles)->Js.log   // 두 번째 호출, 이전에 처리된 파일들을 반환받는다.
 // 또는 이미 존재하는 함수를 래핑하여 Lazy하게 만들 수도 있다.
 // 파라미터가 없는 함수일 경우,
 let getFiles = () => {
     Node.Fs.readdirSync("./pages")
 }
 let lazyGetFiles = Lazy.from_fun(getFiles)
 // 파라미터가 있는 함수일 경우, lazy.from_fun을 사용할 수 없어 lazy 키워드로 대체한다.
 let doesFileExist = name => {
     Node.Fs.readdirSync("./pages")->Js.Array2.find(s => name === s)
 }
 let lazyDoesFileExist = lazy(doesFileExist("blog.res"))
 // unit => 'a와 같이 인자가 없는 함수를 래핑할 때는 Lazy.from_fun을 사용하고,
 // 하나 이상의 인수가 있는 표현식이나 함수는 lazy(expr) 키워드를 사용하면 된다.


/* 지연된 연산을 강제(Force a lazy computation)
 * 지연된 값들이 값을 리턴할 수 있도록 명시적으로 실행해야 한다.
 * lazy.force를 사용하면 값의 반환을 보장할 수 있다.
 */
 let computation = lazy(1)
 Lazy.force(computation)->Js.log
 // 패턴 매칭을 사용하여 지연된 값을 계산하도록 강제할 수도 있다.
 // switch 절 및 튜플 구조분해와 같은 문법에 적용된다.
 let computation = lazy("computed")
 switch computation {
     | lazy("computed") => Js.log("ok")
     | _ => Js.log("not ok")
 }
 // 단일 값 destructuring
 let lazy(word) = lazy("hello")
 Js.log(word)
 // 튜플 destructuring
 let lazyValues = (lazy("hello"), lazy("word"))
 let (lazy(word1), lazy(word2)) = lazyValues
 Js.log2(word1, word2)
 let lazy(word) = lazy("hello")
 // 보다시피 lazy 문법은 지연 계산을 만들고 처리하는 데 정말 좋은 방법이다.
 // 위의 예시는 JS 컴파일 결과와 함께 보시길 바랍니다.


/* 예외 핸들링(Exception handling)
 * 지연된 값이 예외를 발생하면, Lazy.force가 동일한 예외가 발생한다.
 * try절을 사용해 동일하게 예외를 처리할 수 있다.
 * 예외는 자주 쓰이면 안된다는 것을 기억하자.
 */
 let readFile = 
    lazy({
        raise(Not_found)
    })
 try {
     Lazy.force(readFile)
 } catch {
     | Not_found => Js.log("No file")
 }


/* 참고: 지연된 값은 공유 데이터 타입이 아니며 JS측의 런타임 표현에 의존하면 안된다. */

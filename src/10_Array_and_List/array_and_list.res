/* Array
 * Array는 기본적으로 정렬된 자료 구조로 JavaScript의 array와 동일하게 작동한다.
 * Rescript의 Array의 항목들은 모두 같은 타입이어야 한다.
 * 더 많은 기능을 알고 싶다면 JS API 문서를 참고하자.
 */
 let myArray = ["Hello", "world", "how are you"]

 let firstItem = myArray[0]     // "hello"
 myArray[0] = "hey"     // now ["hey", "world", "how are you"]


/* List
 * Rescript는 단일 연결 리스트 또한 제공한다. 아래의 특징을 가진다.
    - 불변하다. (immutable)
    - 항목을 리스트 앞에 추가할 때 빠르다. (fast at prepending items)
    - 바로 뒤의 항목을 가져올 때 빠르다. (fast at getting the tail)
    - 다른 모든 것에선 느리다. (slow at everything else)
 * Array처럼 List의 항목도 모두 같은 타입이어야 한다.
 * 크기 조정이 필요하거나, 항목을 앞에 빠르게 삽입해야 하거나, 빠르게 분할해야할 경우 리스트를 사용하는 것이 효과적이다.
 * 만약 항목에 무작위로 접근해야 하거나, 앞이 아닌 자리에 삽입을 해야하는 경우에 리스트를 사용하면 코드가 느려지거나 둔해지므로 사용하지 않는 것이 좋다.
 */
 let myList = list{1, 2, 3}
 
 // list를 다른 list에 추가할 수도 있다.
 // 아래와 같이 전개(spread) 문법을 사용하면 된다.
 let myList = list{1, 2, 3}
 let anotherList = list{0, ...myList}
 // 하지만 list{a, ...b, ...c}처럼 여러 개의 전개를 사용해서는 안된다.
 // b의 각 항목이 c의 머리에 하나씩 추가되기 때문에 우연하게 선형 연산(O(b))가 된다.
 // 여러 리스트를 한번에 추가하고 싶다면 List.concat을 사용할 수 있지만 권장되는 방법은 아니다.

 // list의 항목에 접근할 때는 switch를 사용할 수 있다.
 let message = 
    switch myList {
    | list{} => "This list is empty"
    | list{a, ...rest} => "The head of the list is the string " ++ Js.Int.toString(a)
    }
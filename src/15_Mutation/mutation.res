/* Mutation
 * Rescript는 전통적인 명령형 및 가변 프로그래밍 기능을 갖추고 있다.
 * 이러한 기능의 사용은 최소화되어야 하지만 때로는 코드의 성능이 향상되고 친숙한 패턴으로 작성될 수 있다.
 */


/* Mutate Let-binding
 * Let-binding은 변경할 수 없지만 ref로 래핑함으로써 값의 변경이 가능하다.
 * ref는 JS의 객체로 컴파일된다.
 */
 let myValue = ref(5)


/* Usage
 * contents 필드를 사용하여 ref의 실제 값을 얻을 수 있다.
 */
 let five = myValue.contents
 // 새로운 값을 할당할 수도 있다.
 myValue.contents = 6
 // 동일한 의미의 다른 문법이 있다.
 myValue := 6
 // 이전 바인딩 5는 ref 자체가 아니라 ref box에 기본항목을 갖기 때문에 5로 유지된다.
 // ref가 JS에서 객체로 컴파일되는데, exports하지 않은 로컬 ref는 최적화되므로 걱정하지 않아도 된다. (- 이해가 필요


/* Tips & Tricks
 * ref를 사용하기 전에, let 바인딩을 재정의하여 경량의 로컬 mutation을 얻을 수 있음을 알아두는 것이 좋다.
 * 참고 : https://rescript-lang.org/docs/manual/latest/let-binding#binding-shadowing
 */
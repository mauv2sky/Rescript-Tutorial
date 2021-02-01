/* Attribute (Decorator) 
 * 다른 언어들과 마찬가지로 Rescript는 코드 조각을 속성으로 선언함으로써 추가적인 기능을 사용할 수 있다.
 */
 @bs.inline
 let mode = "dev"
 let mode2 = mode
 // @bs.inline 주석은 mode의 값을 사용하려는 위치에 인라인을 적용함을 뜻한다.
 // Rescript에서 이런 주석의 형태를 속성(JS에서는 '데코레이터')이라고 부른다.
 // 속성은 앞에 @ 기호를 붙여 시작하고, 적용하려는 코드 조각의 앞에 작성되어야 한다.
 // 위의 예에서는 let 바인딩에 연결된 것을 볼 수 있다.


/* Usage
 * 사용하려는 어느 곳이든 속성을 사용할 수 있다.
 * 함수 호출을 시각적으로 사용하는 것처럼 데이터를 추가할 수 있다.
 * 아래에 몇 가지 자주 쓰는 속성의 예시가 있다(다음 섹션에서 설명한다).
 */
 @@warning("-27")

 @unboxed
 type a = Name(string)
 
 @bs.val external message: string = "message"

 type student = {
   age: int,
   @bs.as("aria-label") ariaLabel: string,
 }

 @deprecated
 let customDouble = foo => foo * 2

 @deprecated("Use SomeOther.customTriple instead")
 let customTriple = foo => foo * 3 
 // 1. @warning("-27") : 전체 파일에 적용되는 독립형 속성이다.
 //     @@ 기호로 시작되며, 데이터 -27을 전달한다.
 // 2. @unboxed : 타입 선언에 사용한다.
 // 3. @bs.val : external 구문과 같이 사용된다.
 // 4. @bs.as("aria-label") : ariaLabel 레코드 필드에 사용된다.
 // 5. @deprecate : customDouble 표현으로, 함수 및 모듈이 차후 사라질 예정이므로
 //     장기적으로 의존하지 말라는 알림을 컴파일 하는 동안 제공한다.
 // 6. @deprecated("Use SomeOther .customTriple instead") : customTriple 표현으로,
 //     해당 기능의 사용을 중단하는 이유를 문자열로 설명한다.


/* Extension Point
 * 속성에는 "extension points(확장 점)"라고 부르는 두 번째 카테고리가 있다.
 * 확장 점은 코드에 적용되는 어노테이션이 아니다. 확장 점이 바로 코드가 된다.
 * 일반적으로 컴파일러가 암시적으로 다른 항목으로 대체하는 placeholder 역할을 수행한다.
 * 확장 점은 %로, 독립형 확장 점(독립형 일반 속성의 @@ 표기법과 유사)은 %%으로 시작한다.
 */
 %%raw("var a = 1")
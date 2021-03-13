/* Attribute (Decorator) 
 * 다른 언어들과 마찬가지로 리스크립트는 코드 조각을 속성으로 선언함으로써 추가적인 기능을 사용할 수 있다.
 */
 @bs.inline
 let mode = "dev"
 let mode2 = mode
 // @bs.inline 어노테이션을 사용하면 mode의 값을 인라인으로 사용함을 뜻한다.
 // 리스크립트에서 이런 어노테이션의 형태를 속성(JS에서는 '데코레이터')이라고 부른다.
 // 속성은 @로 시작하고, 적용하려는 코드 조각의 앞에 선언되어야 한다.
 // 위의 예에서는 let 바인딩에 연결된 것을 볼 수 있다.


/* Usage
 * 사용하려는 어느 곳이든 속성을 사용할 수 있다.
 * 추가 데이터 또한 함수 호출처럼 시각적으로 사용한다.
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
 // 1. @warning("-27") : 파일 전체에 적용되는 독립형 속성이다. @@ 기호로 시작되며, 데이터 -27을 전달한다.
 // 2. @unboxed : 타입 선언에 사용한다.
 // 3. @bs.val : external 구문과 같이 사용된다.
 // 4. @bs.as("aria-label") : ariaLabel 레코드 필드에 사용된다.
 // 5. @deprecate : customDouble 표현으로, 함수 및 모듈이 차후 사라질 예정이므로
 //     장기적으로 의존하지 말라는 deprecated 경고를 컴파일 동안 제공한다.
 // 6. @deprecated("Use SomeOther .customTriple instead") : customTriple 표현으로,
 //     해당 기능의 사용을 중단하는 이유를 문자열로 설명한다.


/* 확장 구문(Extension Point)
 * 속성에는 확장 구문(Extension Point)이라는 다른 카테고리가 있다.
 * 확장 점은 코드에 적용되는 어노테이션이 아니다. 확장 구문이 바로 코드가 된다.
 * 일반적으로 컴파일러가 암시적으로 다른 항목으로 대체하는 플레이스홀더 역할을 수행한다.
 * 확장 구문은 %로 시작한다. (독립형 일반 속성의 @@ 표기법과 유사하게) 독립형 확장 구문은 %%으로 시작한다.
 */
 %%raw("var a = 1")

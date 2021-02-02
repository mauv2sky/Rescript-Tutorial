/* JSX 
 * Rescript에서 HTML 구문을 사용하고 싶다면 이 섹션을 보도록 하자.
 * Rescript는 JSX 구문을 지원하지만 ReactJS의 구문과 약간의 차이가 있다.
 * Rescript의 JSX는 ReactJS와 관련이 없으며 일반 함수 호출로 변형된다.
 * ReasonReact 독자를 위한 참고 사항 : ReasonReact가 JSX를 변화시키는 것은 아니다. 자세한 내용은 아래 사용법을 참고하자.
 */

/* Capitalized Tag : 대문자 태그
    // 기존 방식
    <MyComponent name={"ReScript"} />
    // Rescript JSX
    @JSX Mycomponent.createElement(~name="Rescript", ~children=list{}, ())
 */


/* Uncapitalized Tag : 소문자 태그
    // 기존 방식
    <div onClick={handler}> child1 child2 </div>
    // Rescript JSX
    @JSX div(~onClick=handler, ~children=list{child1, child2}, ())
 */


/* Fragment
    // 기존 방식
    <> child1 child2 </>
    // Rescript JSX
    @JSX list{child1, child2}
 */

 /* Children
    // 기존 방식
    <MyComponent> child1 child2 </MyComponent>
    // 이것은 child1과 child2 두 아이템을 children 위치로 전달하는 문법이다.
    // 문법적 설탕이 제거된 child1과 child2를 포함한 리스트 문법이다.
    // Rescript JSX
    @JSX MyComponent.createElement(~children=list{child1, child2}, ())
    // 이것은 ReasonReact의 변환은 아니다. ReasonReact는 최종에 리스트를 배열로 변환한다.
    // 따라서 <MyComponent> myChild </MyComponent>는, @JSX MyComponent.createElement(~children=list{myChild}, ())로 자연스럽게 변경된다.
    // 무엇을 하든 children에 전달된 인수는 리스트로 감싸진다.
    // 만약 추가적인 래핑없이 myChild를 직접 전달하려면 어떻게 하면 될까?
 */

 /* Children Spread
    // 위의 문제를 해결하기위한 방안을 살펴보도록 하자.
    // myChild를 리스트로 감싸지 않고 인자로 전달할 수 있다(ReasonReact는 배열로).
    // 기존 방식
    <MyComponent> ...myChild </MyComponent>
    // Rescript JSX
    @JSX MyComponent.createElement(~children, ())
    // 이미 리스트인 myChild를 처리하고, 이를 래핑하는 데 소요되는 시간(타입 오류 검사 등)없이 전달하려는 경우에 특히 유용하다.
    // 또한 children 위치에서 임의의 자료구조를 전달할 수 있다. (JSX children은 단지 소품처럼 도와주는 역할임을 기억하자)
    <MyComponent> ...((theClassName) => <div className=theClassName />) </MyComponent>
    <MyForm> ...("Hello", "Submit") </MyForm>
 */


/* Usage
 * ReasonReact JSX 문서에 위의 호출을 ReasonReact 호출로 변환하는 JSX 어플리케이션 예제가 있다.
 * 다음은 JSX 태그의 대부분의 기능을 보여주는 예제이다.
    <MyComponent
        booleanAttribute={true}
        stringAttribute="string"
        intAttribute=1
        forcedOptional=?{Some("hello")}
        onClick={handleClick}
        <div> {React.string("hello")} </div>
    </MyComponent>
 */


/* Departures From JS JSX
    - 속성과 children은 {}가 필수사항은 아니지만 학습의 용이성을 위해 표기한다.
    - JSX prop spread 구문 <Comp {...props} /> 은 지원하지 않는다. 위에 설명한 children spread(<Comp> ...children </Comp>)이 있기 때문이다.
    - Punning(약어)이 존재한다.
 */

 /* Punning
  * 레이블과 값이 동일한 경우에 사용할 수 있는 줄임말을 뜻한다.
  * 예를들어 자바스크립트에서 return {name: name} 대신 return {name}을 하는 것과 같다.
  * Reason JSX는 이러한 약어를 지원한다. <input checked />는 <input checked=checked />의 약어로 사용된다.
  * 포매터가 작동할 때마다 약어처리가 가능한 부분은 자동으로 변경된다.
  * 전달해야하는 props의 수가 많을 수록 유용하게 사용된다.
  <MyComponent isLoading text onClick />

  * 이는 punning이 없는 ReactJS JSX에서 유래된 것이다.
  * ReactJS의 <input checked />는 이전 버전과의 호환성을 위해 DOM 관용구를 따르기 때문에 <input checked=true />로 변경된다.
  */


/* Tips & Tricks
 * JSX의 장점을 활용하려는 사용자들에게 @JSX는 JSX 포매팅하려는 함수를 찾는 잠재적인 ppx 매크로이다.
 * 이 방법은 모든 사람이 특정 라이브러리(ReasonReact)를 사용할 필요없이 JSX 문법을 활용할 수 있다.
 * JSX 호출은 레이블이 지정된 함수의 기능을 지원한다 : optional, 명시적으로 전달되는 optional, 기본값이 있는 optional
 */


/* Design Decision
 * 왜 Children spread 같은 방법이 ReactJS에서 필요하지 않은지 아마 궁금할 수도 있다.
 * ReactJS는 일부 특수한 런타임 로직과 특수 구문 변환 그리고 가변 인수 감지 마킹을 사용해 이런 경우를 대부분 방지한다.
 * 이런 동적 사용은 타입 시스템 감지를 조금 복잡하게 만든다.
 * ReasonReact의 모든 구문을 컨트롤하기 때문에 컴파일 시간 및 런타임 비용없이 래핑하거나 래핑하지 않는 경우를 명확히 구분하기 위해
 * Rescript에서는 children spread를 사용하기로 결정했다.
 */
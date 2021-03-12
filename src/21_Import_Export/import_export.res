/* Import & Export */

/* Import a Module/File
 * 자바스크립트와는 다르게, 리스크립트에서는 import 구문을 작성하지 않아도 된다.
 */
 let schoolMessage = School.message
 // 위 코드는 Student.res 파일의 message를 참조한다.
 // 모든 리스크립트 파일은 모듈이기 때문에, 다른 파일의 내용에 접근하는 것과 다른 모듈의 내용에 접근하는 것은 같은 의미를 갖는다.
 // 그러므로 리스크립트 프로젝트 파일의 이름은 고유해야 한다.


/* Export Stuff
 * 기본적으로 모든 파일의 타입 선언, 바인딩과 모듈은 내보내지며, 다른 파일에서 공개적으로 사용할 수 있다.
 * 이는 JS로 컴파일된 값을 JS코드에서 즉시 사용할 수 있음을 의미한다.
 * 선택한 몇 가지 항목만 내보내고 싶다면 interface 파일을 사용하자(Module 섹션의 Signatures 참고).
 */


/* Work with JavaScript Import & Export
 * JS 모듈을 import/ export 하는 방법은 자바스크립트 Interop 섹션의 Import from/ Export to JS를 참조하자.
 */

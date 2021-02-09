/* Tuple
 * 튜플은 자바스크립트에는 없는 Rescript의 자료구조이다.
 * "불변하고, 생성 시 크기가 고정되며, 다른 타입을 함께 포함 가능한" 특징을 가진다.
 * 튜플에 타입 주석을 사용할 수도 있다. 튜플 내에 값 대신 데이터타입을 명시한 것을 주석으로 사용한다.
 * 크기가 1인 튜플은 존재하지 않으며 이때는 값 자체만 사용하면 된다.
 */
 let ageAndName = (24, "Lil' ReScript")
 let my3dCoordinates = (20.0, 30.5, 100.0)

 let ageAndGender : (int, string) = (24, "Woman")
 type coord3d = (float, float, float)
 let my3dcoord : coord3d = (20.0, 30.5, 100.0)


/* Usage
 * _ 표기를 통해 튜플의 구조를 분해하여 튜플의 특정 멤버를 얻을 수 있다.
 * 쉽게 말해 _ 표기가 위치하는 튜플의 멤버를 무시할 것임을 뜻한다.
 * 기존의 튜플은 새로운 값으로 업데이트되지 않으며(불변한 특징), 이전 항목을 구조화하여 새 항목을 추가해 튜플을 생성한다.
 */
 let (_, y, _) = my3dCoordinates  // y만 얻을 수 있다.

 let coordinates1 = (10, 20, 30)
 let (c1x, _, _) = coordinates1
 let coordinate2 = (c1x + 50, 20, 30)


/* Tips & Tricks
 * 여러 값을 전달하는 상황에 튜플을 사용하면 편리하다.
     let getCenterCoordinates = () => {
     let x = doSomeOperationSHere()
     let y = doSomeMoreOperationsHere()
     (x, y)
     }
 * 튜플은 로컬 범위로 유지하며 사용해야 한다.
 * 오래 유지되고 자주 전달되는 자료구조의 경우에는 필드 이름이 지정된 레코드(Record)를 사용하는 것이 좋다.
 */
 

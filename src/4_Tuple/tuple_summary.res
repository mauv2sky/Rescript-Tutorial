/* Tuple
 * 튜플은 자바스크립트에는 없는 Rescript 관련 자료구조이다.
 * [불변, 생성 시 크기 고정, 다른 타입 함께 포함 가능]의 특징을 가진다.
 * 튜플의 타입은 타입 주석에도 사용할 수 있다. 이는 시각적으로 튜플 값과 유사하다.
 * 크기가 1인 튜플은 없으므로 값 자체만 사용하면 된다.
 */
 let ageAndName = (24, "Lil' ReScript")
 let my3dCoordinates = (20.0, 30.5, 100.0)

 let ageAndGender : (int, string) = (24, "Woman")
 type coord3d = (float, float, float)
 let my3dcoord : coord3d = (20.0, 30.5, 100.0)


/* 용법
 * 튜플의 특정 멤버를 얻으려면 _를 통해 구조를 분해하면 된다.
 * _는 튜플의 지정된 멤버를 무시함을 뜻한다.
 * 튜플은 새로운 값으로 업데이트되지 않으며 이전 항목을 구조화하여 새 항목을 만든다.
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
 * 튜플을 local로 유지하여 사용해야 한다. 오래 유지되고 종종 전달되는 자료구조의 경우,
 * 필드 이름이 지정된 레코드(Record)를 선호한다.
 */
 
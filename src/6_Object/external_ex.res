// document의 타입은 랜덤 타입 'a 입니다.
// 굳이 명시하지 않아도 된다.
@bs.val external document: 'a = "document"

// 메소드 호출
document["addEventListener"]("mouseup", _event => {
    Js.log("clicked!")
})

// 속성 가져오기
let loc = document["location"]

// 속성 설정하기
document["location"]["href"] = "https://rescript-lang.org"
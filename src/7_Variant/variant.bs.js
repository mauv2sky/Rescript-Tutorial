// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var MyLibrary = require("./myLibrary");

function draw(prim) {
  MyLibrary.draw(prim);
  
}

function betterDraw(animal) {
  MyLibrary.draw(animal._0);
  
}

MyLibrary.draw(1.5);

function drawFloat(prim) {
  MyLibrary.draw(prim);
  
}

function drawString(prim) {
  MyLibrary.draw(prim);
  
}

var data = 'dog'
   if (data === 'dog') {
      console.log('Wof');
   } else if (data === 'cat') {
      console.log('Meow');
   } else if (data === 'bird') {
      console.log('Kashiiin');
   }
;

console.log("Wof");

var areYouCrushingIt = /* Yes */0;

var pet = /* Dog */0;

var pet2 = /* Dog */0;

var myAccount = {
  TAG: /* Facebook */1,
  _0: "Josh",
  _1: 26
};

var friendAccount = {
  TAG: /* Instagram */0,
  _0: "Jenny"
};

var me = {
  TAG: /* Id */1,
  name: "Joe",
  password: "123"
};

var meTwo = {
  TAG: /* Id */1,
  _0: {
    name: "Ivy",
    password: "qwer"
  }
};

var g1 = /* Hello */0;

var g2 = /* Goodbye */1;

var o1 = /* Good */0;

var o2 = /* Error */{
  _0: "oops!"
};

var f1 = /* Child */0;

var f2 = {
  TAG: /* Mom */0,
  _0: 30,
  _1: "Jane"
};

var f3 = {
  TAG: /* Dad */1,
  _0: 32
};

var p1 = /* Teacher */0;

var p2 = /* Student */{
  gpa: 99.5
};

var a1 = {
  TAG: /* Warrior */0,
  _0: {
    score: 10.5
  }
};

var a2 = {
  TAG: /* Wizard */1,
  _0: "Joe"
};

var data = /* Dog */0;

exports.areYouCrushingIt = areYouCrushingIt;
exports.pet = pet;
exports.pet2 = pet2;
exports.myAccount = myAccount;
exports.friendAccount = friendAccount;
exports.me = me;
exports.meTwo = meTwo;
exports.g1 = g1;
exports.g2 = g2;
exports.o1 = o1;
exports.o2 = o2;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.p1 = p1;
exports.p2 = p2;
exports.a1 = a1;
exports.a2 = a2;
exports.draw = draw;
exports.betterDraw = betterDraw;
exports.drawFloat = drawFloat;
exports.drawString = drawString;
exports.data = data;
/*  Not a pure module */

// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';


function renderDot(coordinates) {
  console.log("Pretend to draw at:", coordinates.x, coordinates.y);
  
}

renderDot({
      x: 20.5,
      y: 30.5
    });

function renderDot$1(coordinates1) {
  console.log("Pretend to draw at:", coordinates1.x, coordinates1.y);
  
}

function toWorldCoordinates(coordinates1) {
  return {
          x: coordinates1.x + 10,
          y: coordinates1.y + 20
        };
}

var playerLocalCoordinates = {
  x: 20.5,
  y: 30.5
};

renderDot$1(toWorldCoordinates(playerLocalCoordinates));

var studentName = "Ivy";

var hi = "hello!";

exports.studentName = studentName;
exports.hi = hi;
exports.renderDot = renderDot$1;
exports.toWorldCoordinates = toWorldCoordinates;
exports.playerLocalCoordinates = playerLocalCoordinates;
/*  Not a pure module */
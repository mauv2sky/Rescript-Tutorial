// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Caml_option = require("bs-platform/lib/js/caml_option.js");
var MyIdValidator = require("MyIdValidator");

var licenseNumber$prime = 5;

if (licenseNumber$prime !== undefined) {
  console.log("The person's license number is " + licenseNumber$prime.toString());
} else {
  console.log("The person doesn't have a car");
}

var personId = "abc123";

var result = MyIdValidator.validate(personId);

var licenseNumber = 5;

var personHasCar = true;

var x = 5;

var y = Caml_option.some(undefined);

exports.licenseNumber = licenseNumber;
exports.personHasCar = personHasCar;
exports.licenseNumber$prime = licenseNumber$prime;
exports.x = x;
exports.y = y;
exports.personId = personId;
exports.result = result;
/*  Not a pure module */

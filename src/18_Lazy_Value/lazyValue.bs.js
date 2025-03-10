// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Lazy = require("bs-platform/lib/js/lazy.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var CamlinternalLazy = require("bs-platform/lib/js/camlinternalLazy.js");
var Caml_js_exceptions = require("bs-platform/lib/js/caml_js_exceptions.js");

var getFiles = {
  LAZY_DONE: false,
  VAL: (function () {
      console.log("Reading dir");
      return Fs.readdirSync("./pages");
    })
};

console.log(CamlinternalLazy.force(getFiles));

console.log(CamlinternalLazy.force(getFiles));

function getFiles$1(param) {
  return Fs.readdirSync("./pages");
}

var lazyGetFiles = Lazy.from_fun(getFiles$1);

function doesFileExist(name) {
  return Caml_option.undefined_to_opt(Fs.readdirSync("./pages").find(function (s) {
                  return name === s;
                }));
}

var lazyDoesFileExist = {
  LAZY_DONE: false,
  VAL: (function () {
      return doesFileExist("blog.res");
    })
};

var computation = {
  LAZY_DONE: true,
  VAL: 1
};

console.log(CamlinternalLazy.force(computation));

var computation$1 = {
  LAZY_DONE: true,
  VAL: "computed"
};

var match = CamlinternalLazy.force(computation$1);

if (match === "computed") {
  console.log("ok");
} else {
  console.log("not ok");
}

var match$1 = {
  LAZY_DONE: true,
  VAL: "hello"
};

var word = CamlinternalLazy.force(match$1);

console.log(word);

var lazyValues_0 = {
  LAZY_DONE: true,
  VAL: "hello"
};

var lazyValues_1 = {
  LAZY_DONE: true,
  VAL: "word"
};

var lazyValues = [
  lazyValues_0,
  lazyValues_1
];

var word1 = CamlinternalLazy.force(lazyValues_0);

var word2 = CamlinternalLazy.force(lazyValues_1);

console.log(word1, word2);

var match$2 = {
  LAZY_DONE: true,
  VAL: "hello"
};

var word$1 = CamlinternalLazy.force(match$2);

var readFile = {
  LAZY_DONE: false,
  VAL: (function () {
      throw {
            RE_EXN_ID: "Not_found",
            Error: new Error()
          };
    })
};

try {
  CamlinternalLazy.force(readFile);
}
catch (raw_exn){
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn.RE_EXN_ID === "Not_found") {
    console.log("No file");
  } else {
    throw exn;
  }
}

exports.getFiles = getFiles$1;
exports.lazyGetFiles = lazyGetFiles;
exports.doesFileExist = doesFileExist;
exports.lazyDoesFileExist = lazyDoesFileExist;
exports.computation = computation$1;
exports.lazyValues = lazyValues;
exports.word1 = word1;
exports.word2 = word2;
exports.word = word$1;
exports.readFile = readFile;
/*  Not a pure module */

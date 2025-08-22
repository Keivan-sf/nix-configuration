// let hh1 = document.querySelector("h1");
// hh1.style.color = "blue";

let clock = document.querySelector(".clock");
setInterval(() => {
  let date = new Date();
  let hour = date.getHours().toString();
  hour = hour.length < 2 ? "0" + hour : hour;
  let minute = date.getMinutes().toString();
  minute = minute.length < 2 ? "0" + minute : minute;
  clock.innerHTML = hour + " " + minute;
}, 1000);

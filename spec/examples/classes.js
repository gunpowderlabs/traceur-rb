export class Greeter {
  constructor(greeting) {
    this.greeting = greeting;
  }

  greet(name) {
    console.log(`${this.greeting} ${name}!`);
  }
}

var greeter = new Greeter("Hello");
greeter.greet("world");

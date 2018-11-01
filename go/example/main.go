package main

import (
	"bytes"
	"flag"
)

func main() {
	foo()
	foo := flag.String("foo", "bar", "foo flag")
	flag.Parse()
	println(*foo)
}

func foo() string {
	buf := &bytes.Buffer{}
	buf.WriteString("foo")
	buf.WriteString("bar")
	return buf.String()
}

package main

import (
	"bytes"
	"flag"
)

var (
	branch, commit, version, goVersion string
)

func main() {
	foo()
	foo := flag.String("foo", "bar", "foo flag")
	flag.Parse()

	println("Branch:", branch)
	println("Commit:", commit)
	println("Version:", version)
	println("GoVersion:", goVersion)
	println("Arg foo:", *foo)
}

func foo() string {
	buf := &bytes.Buffer{}
	buf.WriteString("foo")
	buf.WriteString("bar")
	return buf.String()
}

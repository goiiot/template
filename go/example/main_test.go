package main

import (
	"testing"
)

func TestFoo(t *testing.T) {
	if foo() != "foobar" {
		t.Fail()
	}
}

func BenchmarkFoo(b *testing.B) {
	b.ReportAllocs()
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		foo()
	}
}

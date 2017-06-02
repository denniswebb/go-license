package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/ryanuber/go-license"
)

func main() {
	top := "."

	if len(os.Args) > 1 {
		top = os.Args[1]
	}

	err := filepath.Walk(top, checkLicense)

	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
}

func checkLicense(path string, info os.FileInfo, err error) error {
	if err != nil {
		fmt.Print(err)
		return nil
	}
	if !info.IsDir() {
		return nil
	}

	l, err := license.NewFromDir(path)
	if err == nil {
		fmt.Printf("%s: %s", path, l.Type)
	}
	return nil
}

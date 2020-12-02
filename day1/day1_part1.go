package main

import (
    "fmt"
    "io/ioutil"
    "strconv"
    "strings"
)

func main() {
    content, err := ioutil.ReadFile("input.txt")

    if err != nil {
      panic(err)
    }

    lines := strings.Split(string(content), "\n")

    set := make(map[int]bool)
    set[0] = true

    for _, l := range lines {
      number, _ := strconv.Atoi(l)
      number_to_check := 2020 - number

      if set[number_to_check] {
        fmt.Printf("%v\n", number_to_check * number)
        break
      }

      set[number] = true
    }
}

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

    part1(lines)
    part2(lines)
}

func part1(lines []string) {
    matching := 0

    for i, l := range lines {
      if i == len(lines) - 1 {
        break
      }

      bags := strings.Split(l, ": ")

      password := bags[1]

      sub_bags := strings.Split(bags[0], " ")
      min_max := strings.Split(sub_bags[0], "-")
      min, _ := strconv.Atoi(min_max[0])
      max, _ := strconv.Atoi(min_max[1])
      letter := sub_bags[1]

      occurrences := strings.Count(password, letter)

      if occurrences >= min && occurrences <= max {
        matching++
      }
    }

    fmt.Println(matching)
}

func part2(lines []string) {
    matching := 0

    for i, l := range lines {
      if i == len(lines) - 1 {
        break
      }

      bags := strings.Split(l, ": ")

      password := bags[1]

      sub_bags := strings.Split(bags[0], " ")
      min_max := strings.Split(sub_bags[0], "-")
      min, _ := strconv.Atoi(min_max[0])
      max, _ := strconv.Atoi(min_max[1])
      letter := sub_bags[1]

      first_candidate := string(password[min - 1])
      second_candidate := string(password[max - 1])
      if (first_candidate == letter && second_candidate != letter) ||
           (first_candidate != letter && second_candidate == letter) {
        matching++
      }
    }

    fmt.Println(matching)
}

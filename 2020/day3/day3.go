package main

import (
    "fmt"
    "io/ioutil"
    "strings"
)

var (
    line_length = 0
)

func main() {
    content, err := ioutil.ReadFile("input.txt")

    if err != nil {
      panic(err)
    }

    grid := strings.Fields(string(content))
    line_length = len(grid[0])

    fmt.Println(Part1(grid))
    fmt.Println(Part2(grid))
}

func Trees(grid []string, x, y int) int {
    trees := 0

    for i, l := range grid {
        if i % y == 0 && l[(i * x / y) % line_length] == byte('#') {
            trees++
        }
    }

    return trees
}

func Part1(grid []string) int {
    return Trees(grid, 3, 1)
}

func Part2(grid []string) int {
    var slopes = [5][2]int {{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}}
    var prod = 1

    for _, slope := range slopes {
        prod *= Trees(grid, slope[0], slope[1])
    }

    return prod
}

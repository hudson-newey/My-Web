/*
Wire Tap Copyright (C) 2018 Grathium Sofwares <grathiumsoftwears@gmail.com>
	This program comes with ABSOLUTELY NO WARRANTY
	This is a free software, and you are welcome to redistribute it under certain
	conditions.
*/

package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"encoding/hex"
)

func main() {
	var website string

	for ok := true; ok; ok = true {
		fmt.Println("Wire Tap Copyright (C) 2018 Grathium Sofwares <grathiumsoftwears@gmail.com>", // legal shit
		"\nThis program comes with ABSOLUTELY NO WARRANTY",
		"This is a free software, and you are welcome to redistribute it under certain\n",
		"conditions.",
		)

		fmt.Println("\nWebsite to Access (without http):")
		fmt.Scanln(&website)
	
		websiteedit := "http://" + website
		output := getHTML(websiteedit) // use the getHTML function to get the source of the user input website
	
		// write the output to a file to use later
		fmt.Println(output); fmt.Printf("\033c")
		websiteHTML := string(output[:])
	
		// create the website file
		err := ioutil.WriteFile(website + ".html", []byte(websiteHTML), 0755)
		if err != nil {
			fmt.Printf("Unable to write file: %v", err)
		}
	
		fmt.Println("" +
			"Done!")
		// pause the program
		var pause string
		fmt.Scanln(&pause)
		fmt.Printf("\033c") // clear the screen ready for a new session
	}
}



func getHTML(w string) []byte {
	url := w
	fmt.Println("packet code of ", url)
	resp, err := http.Get(url)
	// handle the error if there is one
	if err != nil {
		panic(err)
	}
	// do this now so it won't be forgotten
	defer resp.Body.Close()
	// reads html as a slice of bytes
	html, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}
	// show the HTML code as a string %s
	return html
}

// random hex string generator
func randomHex(n int) string {
	bytes := make([]byte, n)
	return hex.EncodeToString(bytes)
  }
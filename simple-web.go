package main

import (
	"fmt"
	"net/http"
	"html/template"
	"os"
)

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, f *http.Request){
		var data = map[string]string{
			"Name": os.Getenv("NAME"),
		}

		var t, error = template.ParseFiles("index.html")
		if error != nil{
			fmt.Println(error.Error())
			return
		}
		t.Execute(w, data)
	})

	fmt.Println("starting web server at localhost")
	http.ListenAndServe(":8080", nil)
}
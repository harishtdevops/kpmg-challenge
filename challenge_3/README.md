## Challenge 3

## Problem Statement

> We have a nested object, we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.
> Example Inputs
> `object = {“a”:{“b”:{“c”:”d”}}}`
> key = a/b/c
> `object = {“x”:{“y”:{“z”:”a”}}}`
> key = x/y/z
> value = a


## Solution

# Pre-requesties
1. Python to be installed on machine where the script needs to be executed `py --version`

# Command to run 
Run the script `nested_obj_key.py` with the arguments as nested object with key value
` py .\nested_obj_key.py -d "{'a':{'b':{'c'}}}" -k "a b" `

It displays the output as below
` Keys:['a', 'b'] `
` Values:{'c'} `

# Reference 
![image](https://user-images.githubusercontent.com/90919654/134827294-01ff025b-9f6a-48e1-a494-5181b5bf5580.png)

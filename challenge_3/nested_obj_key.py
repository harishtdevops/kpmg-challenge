import os
import argparse


def dict_iterator(input, key):
    try:
        val = input[key]
    except Exception as e:
        print(e)
        val = None
    return val


def main(data, keyinput):
    if "/" in keyinput:
        keyinput = keyinput.split('/')
    else:
        keyinput = keyinput.split()
    print("Keys:" + str(keyinput))
    flagVal = True
    if not isinstance(data, dict):
        print("Input is not a Dict")
    while flagVal is True:
        if isinstance(data, dict):
            for i in range(len(keyinput)):
                data = dict_iterator(data, keyinput[i])
                if data is None:
                    data = "Invalid Key passed"
                if i == 0:
                    flagVal = False
        else:
            flagVal = False
    return data


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Should be Nested Objects')
    parser.add_argument('-d', action='store', type=str, dest='object',
                        help='''Dict value should be like "{'a':{'b':{'c':'d'}}}" ''', required=True)
    parser.add_argument('-k', action='store', type=str, dest='keyinput',
                        help='''Values should be like "a/b/c/" or "x" ''', required=True)
    options = parser.parse_args()
    dataVal = eval(options.object)
    keyVal = options.keyinput
    keyResult = main(dataVal, keyVal)
    print("Values:"+ str(keyResult))